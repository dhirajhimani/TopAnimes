package com.anime.topanimesrepos.net

import com.anime.core.INetworkCheck
import com.anime.topanimesrepos.entity.TopAnimesReposState
import com.nhaarman.mockito_kotlin.whenever
import com.squareup.moshi.Moshi
import com.squareup.moshi.kotlin.reflect.KotlinJsonAdapterFactory
import okhttp3.OkHttpClient
import okhttp3.mockwebserver.MockResponse
import okhttp3.mockwebserver.MockWebServer
import org.hamcrest.MatcherAssert
import org.hamcrest.core.IsInstanceOf.instanceOf
import org.junit.*
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertTrue
import org.junit.runner.RunWith
import org.mockito.Mock
import org.mockito.junit.MockitoJUnitRunner
import retrofit2.Retrofit
import retrofit2.converter.moshi.MoshiConverterFactory
import java.util.concurrent.CountDownLatch

@RunWith(MockitoJUnitRunner::class)
class RepositoryResponseTest {

    private val responses = AnimesResponse()

    private val converterFactory = MoshiConverterFactory.create(
        Moshi.Builder()
            .add(KotlinJsonAdapterFactory())
            .build()
    )

    private lateinit var retrofit: Retrofit
    private lateinit var service: TopAnimesReposApi
    private lateinit var mapper: TopAnimesReposMapper
    private lateinit var provider: TopAnimesReposProvider

    @Mock
    private lateinit var connectivityChecker: INetworkCheck

    companion object {

        private val mockServer = MockWebServer()

        @BeforeClass
        fun startServer() {
            mockServer.start()
        }

        @AfterClass
        fun clearResources() {
            mockServer.shutdown()
        }
    }

    @Before
    fun setup() {
        retrofit = Retrofit.Builder()
            .client(OkHttpClient.Builder().build())
            .baseUrl(mockServer.url(""))
            .addConverterFactory(converterFactory)
            .build()
        service = retrofit.create(TopAnimesReposApi::class.java)
        mapper = TopAnimesReposMapper()
        provider = TopAnimesReposProvider(service, connectivityChecker, mapper)
    }

    @Test
    fun `On making request we get a successful transaction`() {
        val consumer = CurrentConsumer(2)
        whenever(connectivityChecker.isConnected).thenReturn(true)
        MockResponse()
            .setResponseCode(200)
            .setBody(responses.repositories.string()).also {
                mockServer.enqueue(it)
            }
        provider.requestData(consumer::consumeCurrent)
        consumer.await()
        assertNotNull(consumer.current)
    }

    @Test
    fun `On making request we get a successful transaction check Item Details`() {
        val consumer = CurrentConsumer(2)
        whenever(connectivityChecker.isConnected).thenReturn(true)
        MockResponse()
            .setResponseCode(200)
            .setBody(responses.repositories.string()).also {
                mockServer.enqueue(it)
            }
        provider.requestData(consumer::consumeCurrent)
        consumer.await()
        val githubReposState: TopAnimesReposState = consumer.current!!
        MatcherAssert.assertThat(githubReposState,
            instanceOf(TopAnimesReposState.Success::class.java))
        val repository = (githubReposState as TopAnimesReposState.Success).animes[0]
        // need to use the contains since the expiry will change on every call
        assertTrue(repository.toString().contains("Anime(rank=1, title=Shingeki no Kyojin: The Final Season, webUrl=https://myanimelist.net/anime/40028/Shingeki_no_Kyojin__The_Final_Season, image_url=https://cdn.myanimelist.net/images/anime/1536/109462.jpg?s=8e5dd158dd33ff8de7b34e230f4a2c10, members=219237, expiry="))
    }

    @Test
    fun `In case of no Network On making request we get a network Error`() {
        val consumer = CurrentConsumer(1)
        whenever(connectivityChecker.isConnected).thenReturn(false)
        provider.requestData(consumer::consumeCurrent)
        consumer.await()
        val githubReposState: TopAnimesReposState = consumer.current!!
        MatcherAssert.assertThat(githubReposState,
            instanceOf(TopAnimesReposState.Error::class.java))
    }
}

    private open class CurrentConsumer(val waitActions: Int) {
        private val latch = CountDownLatch(waitActions)
        var current: TopAnimesReposState? = null

        fun consumeCurrent(current: TopAnimesReposState?) {
            this.current = current
            latch.countDown()
        }

        fun await() {
            latch.await()
        }
}