package com.anime.topanimes.di

import com.anime.topanimes.TopAnimesActivity
import dagger.Module
import dagger.android.ContributesAndroidInjector

@Module
abstract class ActivityModule {

    @ContributesAndroidInjector
    abstract fun bindRepoFetcherActivity(): TopAnimesActivity

}
