package com.anime.topanimesrepos.view

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import androidx.lifecycle.MutableLiveData
import com.anime.core.connectivity.ConnectivityLiveData
import com.anime.core.providers.DataProvider
import com.anime.topanimesrepos.entity.Anime
import com.anime.topanimesrepos.entity.TopAnimesReposState
import com.anime.topanimesrepos.utils.LiveDataTestUtil
import com.anime.topanimesrepos.utils.MainCoroutineScopeRule
import org.hamcrest.MatcherAssert
import org.hamcrest.core.IsInstanceOf
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.junit.MockitoJUnitRunner

@RunWith(MockitoJUnitRunner::class)
class TopAnimesReposViewModelTest {

    @get:Rule
    val instantTaskExecutorRule = InstantTaskExecutorRule()

    @get:Rule
    val coroutineScope = MainCoroutineScopeRule()

    lateinit var subject: TopAnimesReposViewModel

    @Test
    fun returnSuccessResultOnLoad() {
        val anime = Anime(
            rank = 0,
            title = "Reincarnated Slime",
            webUrl = "",
            image_url = "",
            members = 0,
            expiry = 1
        )
        val animeList = arrayListOf(anime)
        val githubReposState = TopAnimesReposState.Success(animeList)
        val dataProvider = DummyDataProvider(githubReposState)

        subject = TopAnimesReposViewModel(dataProvider)

        coroutineScope.runBlockingTest {
            subject.load()
            MatcherAssert.assertThat(
                LiveDataTestUtil.getValue(subject.topAnimesReposViewState),
                IsInstanceOf.instanceOf(TopAnimesReposViewState.ShowRepositories::class.java)
            )
        }
    }

    @Test
    fun returnErrorResultOnLoad() {
        val anime = Anime(
            rank = 0,
            title = "Reincarnated Slime",
            webUrl = "",
            image_url = "",
            members = 0,
            expiry = 1
        )
        val animeList = arrayListOf(anime)
        val githubReposState = TopAnimesReposState.Error("repositoryList")
        val dataProvider = DummyDataProvider(githubReposState)

        subject = TopAnimesReposViewModel(dataProvider)

        coroutineScope.runBlockingTest {
            subject.load()
            MatcherAssert.assertThat(
                LiveDataTestUtil.getValue(subject.topAnimesReposViewState),
                IsInstanceOf.instanceOf(TopAnimesReposViewState.ShowError::class.java)
            )
        }
    }

    class DummyDataProvider(private val animeReposState: TopAnimesReposState) :
        DataProvider<TopAnimesReposState> {
        override fun requestData(callback: (item: TopAnimesReposState) -> Unit) {
            callback(animeReposState)
        }
    }

}