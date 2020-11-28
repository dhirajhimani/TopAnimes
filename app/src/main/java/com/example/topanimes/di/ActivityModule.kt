package com.example.topanimes.di

import com.example.topanimes.TopAnimesActivity
import dagger.Module
import dagger.android.ContributesAndroidInjector

@Module
abstract class ActivityModule {

    @ContributesAndroidInjector
    abstract fun bindRepoFetcherActivity(): TopAnimesActivity

}
