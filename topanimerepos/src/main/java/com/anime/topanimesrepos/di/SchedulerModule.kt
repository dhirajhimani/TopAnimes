package com.anime.topanimesrepos.di

import com.anime.core.scheduler.UpdateScheduler
import com.anime.topanimesrepos.entity.Anime
import com.anime.topanimesrepos.scheduler.RepositoriesScheduler
import dagger.Binds
import dagger.Module
import javax.inject.Singleton

@Module
abstract class SchedulerModule {

    @Binds
    @Singleton
    abstract fun providesScheduler(scheduler: RepositoriesScheduler): UpdateScheduler<Anime>

}