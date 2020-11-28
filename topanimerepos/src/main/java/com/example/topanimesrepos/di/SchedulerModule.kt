package com.example.topanimesrepos.di

import com.example.core.scheduler.UpdateScheduler
import com.example.topanimesrepos.entity.Anime
import com.example.topanimesrepos.scheduler.RepositoriesScheduler
import dagger.Binds
import dagger.Module
import javax.inject.Singleton

@Module
abstract class SchedulerModule {

    @Binds
    @Singleton
    abstract fun providesScheduler(scheduler: RepositoriesScheduler): UpdateScheduler<Anime>

}