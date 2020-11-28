package com.anime.topanimesrepos.di

import com.anime.core.di.CoreNetworkModule
import com.anime.topanimesrepos.net.TopAnimesReposApi
import com.squareup.moshi.Moshi
import com.squareup.moshi.kotlin.reflect.KotlinJsonAdapterFactory
import dagger.Module
import dagger.Provides
import okhttp3.Interceptor
import okhttp3.OkHttpClient
import retrofit2.Retrofit
import retrofit2.converter.moshi.MoshiConverterFactory
import javax.inject.Named
import javax.inject.Singleton

@Module(includes = [CoreNetworkModule::class])
object NetworkModule {

    @Provides
    @Named("JSON")
    @JvmStatic
    internal fun providesJson() =
        Interceptor { chain ->
            val newRequest = chain.request().let { request ->
                request.newBuilder()
                    .addHeader("accept", "application/vnd.github.v3+json")
                    .build()
            }
            chain.proceed(newRequest)
        }

    @Provides
    @JvmStatic
    internal fun providesOkHttpClient(
        builder: OkHttpClient.Builder,
        @Named("JSON") jsonInterceptor: Interceptor,
    ): OkHttpClient =
        builder.addInterceptor(jsonInterceptor)
            .build()

    @Provides
    @Singleton
    @JvmStatic
    internal fun providesRetrofit(
        okHttpClient: OkHttpClient
    ): Retrofit =
        Retrofit.Builder()
            .baseUrl("https://api.jikan.moe/v3/top/anime/")
            .client(okHttpClient)
            .addConverterFactory(MoshiConverterFactory.create(Moshi.Builder().add(KotlinJsonAdapterFactory()).build()))
            .build()

    @Provides
    @JvmStatic
    internal fun providesGithubReposApi(retrofit: Retrofit): TopAnimesReposApi =
        retrofit.create(TopAnimesReposApi::class.java)

}
