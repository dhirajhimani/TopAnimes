package com.anime.topanimes.ui

import androidx.fragment.app.Fragment
import androidx.test.rule.ActivityTestRule
import androidx.test.runner.AndroidJUnit4
import com.anime.topanimes.*
import com.anime.topanimes.Injector
import com.anime.topanimes.registerAnimeReposFragmentInjector
import com.anime.topanimesrepos.entity.Anime
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(AndroidJUnit4::class)
class GithubReposFragmentTest {
    private val injector = Injector<Fragment>()

    @get:Rule
    @Suppress("UNUSED")
    val testRule: ActivityTestRule<TopAnimesActivity> = object : ActivityTestRule<TopAnimesActivity>(TopAnimesActivity::class.java, true, true) {
        override fun beforeActivityLaunched() {
            super.beforeActivityLaunched()
            injector.apply {
                injectApplication<TopAnimesApplication> { fragmentInjector ->
                    fragmentDispatchingAndroidInjector = fragmentInjector
                }
                registerAnimeReposFragmentInjector()
            }
        }
    }


    private val dummyAnime = Anime(
        rank = 0,
        title = "Reincarnated Slime",
        webUrl = "",
        image_url = "",
        members = 0,
        expiry = System.currentTimeMillis()
    )

    @Test
    fun testRepositoriesDisplaysCorrectly() {
        currentAnimes {
            verifyRepositoryListItemsDisplayed()
            // TODO we could send live data and
            //  put matcher to verify the results are there on screen
        }
    }
}