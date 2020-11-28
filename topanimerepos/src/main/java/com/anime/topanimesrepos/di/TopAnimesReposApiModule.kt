package com.anime.topanimesrepos.di

import com.anime.core.ConnectivityChecker
import com.anime.core.providers.DataMapper
import com.anime.core.providers.DataProvider
import com.anime.topanimesrepos.entity.TopAnimesReposState
import com.anime.topanimesrepos.entity.Anime
import com.anime.topanimesrepos.net.*
import dagger.Module
import dagger.Provides
import javax.inject.Named

@Module
object TopAnimesReposApiModule {

    @Provides
    @Named(TopAnimesReposModule.NETWORK)
    @JvmStatic
    fun providesGithubReposProvider(
        topAnimesReposApi: TopAnimesReposApi,
        connectivityChecker: ConnectivityChecker,
        mapper: DataMapper<Pair<List<TopAnime>, Long>, List<Anime>>
    ): DataProvider<TopAnimesReposState> =
        TopAnimesReposProvider(
            topAnimesReposApi,
            connectivityChecker,
            mapper
        )

    @Provides
    @JvmStatic
    fun providesGithubReposMapper(): DataMapper<Pair<List<TopAnime>, Long>, List<Anime>> =
        TopAnimesReposMapper()
}
