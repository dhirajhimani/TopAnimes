package com.example.topanimesrepos.di

import com.example.core.providers.DataPersister
import com.example.core.providers.DataProvider
import com.example.core.scheduler.UpdateScheduler
import com.example.topanimesrepos.entity.TopAnimesReposRepository
import com.example.topanimesrepos.entity.TopAnimesReposState
import com.example.topanimesrepos.entity.Anime
import dagger.Module
import dagger.Provides
import javax.inject.Named

@Module
object EntitiesModule {

    @Provides
    @Named(TopAnimesReposModule.ENTITIES)
    @JvmStatic
    internal fun providesGithubReposRepository(
        persistence: DataPersister<List<Anime>>,
        @Named(TopAnimesReposModule.NETWORK) networkProvider: DataProvider<TopAnimesReposState>,
        scheduler: UpdateScheduler<Anime>
    ): DataProvider<TopAnimesReposState> = TopAnimesReposRepository(persistence, networkProvider, scheduler)
}
