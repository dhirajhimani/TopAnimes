package com.anime.topanimes

import androidx.fragment.app.Fragment
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import androidx.test.espresso.Espresso.onView
import androidx.test.espresso.assertion.ViewAssertions.matches
import androidx.test.espresso.matcher.ViewMatchers.isDisplayed
import androidx.test.espresso.matcher.ViewMatchers.withId
import com.anime.core.providers.DataProvider
import com.anime.topanimesrepos.entity.Anime
import com.anime.topanimesrepos.entity.TopAnimesReposState
import com.anime.topanimesrepos.net.TopAnime
import com.anime.topanimesrepos.view.TopAnimesReposFragment
import com.anime.topanimesrepos.view.TopAnimesReposViewModel
import com.anime.topanimesrepos.view.TopAnimesReposViewState

internal fun Injector<Fragment>.registerAnimeReposFragmentInjector() =
    registerInjector<TopAnimesReposFragment> {
        viewModelFactory = TestViewModelFactory()
    }

fun currentAnimes(func: TopAnimesFragmentActions.() -> Unit) =
    TopAnimesFragmentActions().apply(func)

private val currentAnimeReposState = MutableLiveData<TopAnimesReposViewState>()

class TopAnimesFragmentActions {

    fun verifyRepositoryListItemsDisplayed() {
        onView(withId(R.id.container)).apply {
            check(matches(isDisplayed()))
        }
    }
}

val topAnime = TopAnime(
    rank = 0,
    title = "Reincarnated Slime",
    url = "",
    image_url = "",
    members = 0,
)

private val dummyAnime = Anime(
    rank = 0,
    title = "Reincarnated Slime",
    webUrl = "",
    image_url = "",
    members = 0,
    expiry = System.currentTimeMillis()
)

private val githubReposProvider = object : DataProvider<TopAnimesReposState> {

    override fun requestData(callback: (item: TopAnimesReposState) -> Unit) {
        callback(TopAnimesReposState.Success(arrayListOf(dummyAnime)))
    }

}

private class TestViewModelFactory : ViewModelProvider.Factory {

    @Suppress("UNCHECKED_CAST")
    override fun <T : ViewModel?> create(modelClass: Class<T>): T {
        return if (modelClass == TopAnimesReposViewModel::class.java) {
            TopAnimesReposViewModel(githubReposProvider) as T
        } else {
            throw Exception("Not recognised")
        }
    }
}
