package com.anime.topanimes.di

import com.anime.topanimesrepos.di.TopAnimesReposModule
import com.anime.topanimes.TopAnimesApplication
import dagger.Component
import dagger.android.AndroidInjectionModule
import dagger.android.AndroidInjector
import javax.inject.Singleton

@Singleton
@Component(
    modules = [
        AndroidInjectionModule::class,
        ApplicationModule::class,
        ActivityModule::class,
        TopAnimesReposModule::class
    ]
)
interface ApplicationComponent : AndroidInjector<TopAnimesApplication> {

    @Component.Builder
    abstract class Builder : AndroidInjector.Builder<TopAnimesApplication>()
}
