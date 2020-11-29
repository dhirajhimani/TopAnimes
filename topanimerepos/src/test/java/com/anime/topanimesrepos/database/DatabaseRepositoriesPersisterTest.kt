package com.anime.topanimesrepos.database

import com.anime.core.providers.DataMapper
import com.anime.core.providers.DataPersister
import com.anime.topanimesrepos.entity.Anime
import com.nhaarman.mockito_kotlin.any
import com.nhaarman.mockito_kotlin.mock
import com.nhaarman.mockito_kotlin.verify
import com.nhaarman.mockito_kotlin.whenever
import org.junit.Assert.assertTrue
import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.Mock
import org.mockito.junit.MockitoJUnitRunner
import java.util.concurrent.CountDownLatch

@RunWith(MockitoJUnitRunner::class)
class DatabaseRepositoriesPersisterTest {

    lateinit var dataPersister: DataPersister<List<Anime>>

    lateinit var dataMapper: DataMapper<Anime, DbRepository>

    @Mock
    private lateinit var repositoriesDao: RepositoriesDao

    @Test
    fun `Database Repositories Persister first clears the old data and than inserts the new one`() {
        //given
        dataMapper = mock()
        dataPersister = DatabaseRepositoriesPersister(repositoriesDao, dataMapper)

        //when
        dataPersister.persistData(emptyList())

        //than
        verify(repositoriesDao).deleteAll()
        verify(repositoriesDao).insertAnimes(emptyList())
    }

    @Test
    fun `Database Repositories Persister deletes old data when making request for data`() {
        //given
        val consumer = CurrentConsumer()
        dataMapper = mock()
        dataPersister = DatabaseRepositoriesPersister(repositoriesDao, dataMapper)
        whenever(repositoriesDao.getAnimes()).thenReturn(emptyList())

        //when
        dataPersister.requestData(consumer::consumeCurrent)

        //than
        assertTrue(consumer.current!!.isEmpty())
        verify(repositoriesDao).deleteOutdated(any())
    }


    private open class CurrentConsumer() {
        private val latch = CountDownLatch(1)
        var current: List<Anime>? = null

        fun consumeCurrent(current: List<Anime>?) {
            this.current = current
            latch.countDown()
        }

        fun await() {
            latch.await()
        }
    }

}