package com.anime.topanimes.di

import android.app.Application
import android.content.Context
import android.net.ConnectivityManager
import androidx.lifecycle.MutableLiveData
import com.anime.core.connectivity.ConnectivityLiveData
import com.anime.core.connectivity.ConnectivityState
import com.anime.topanimesrepos.view.TopAnimesReposViewState
import com.anime.topanimes.TopAnimesApplication
import dagger.Module
import dagger.Provides
import javax.inject.Singleton

@Module
object ApplicationModule {

    @Provides
    @JvmStatic
    @Singleton
    internal fun provideApplication(app: TopAnimesApplication): Application = app

    @Provides
    @JvmStatic
    @Singleton
    fun providesConnectivityManager(app: Application): ConnectivityManager =
        app.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager

    @Provides
    @JvmStatic
    @Singleton
    fun providesConnectivityLiveData(app: Application): MutableLiveData<ConnectivityState> =
        ConnectivityLiveData(app)

    @Provides
    @JvmStatic
    @Singleton
    fun bindsGithubReposViewLiveData(): MutableLiveData<TopAnimesReposViewState> =
        MutableLiveData()

}
