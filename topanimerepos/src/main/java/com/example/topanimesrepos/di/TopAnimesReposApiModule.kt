package com.example.topanimesrepos.di

import com.example.core.ConnectivityChecker
import com.example.core.providers.DataMapper
import com.example.core.providers.DataProvider
import com.example.topanimesrepos.entity.TopAnimesReposState
import com.example.topanimesrepos.entity.Anime
import com.example.topanimesrepos.net.*
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
