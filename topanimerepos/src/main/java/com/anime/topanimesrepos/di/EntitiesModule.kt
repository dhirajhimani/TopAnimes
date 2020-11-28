package com.anime.topanimesrepos.di

import com.anime.core.providers.DataPersister
import com.anime.core.providers.DataProvider
import com.anime.core.scheduler.UpdateScheduler
import com.anime.topanimesrepos.entity.TopAnimesReposRepository
import com.anime.topanimesrepos.entity.TopAnimesReposState
import com.anime.topanimesrepos.entity.Anime
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
