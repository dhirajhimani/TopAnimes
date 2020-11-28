package com.example.topanimes.di

import com.example.topanimesrepos.di.TopAnimesReposModule
import com.example.topanimes.TopAnimesApplication
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
