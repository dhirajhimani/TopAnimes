package com.anime.topanimesrepos.di

import androidx.lifecycle.ViewModel
import com.anime.core.di.BaseViewModule
import com.anime.core.di.ViewModelKey
import com.anime.core.di.WorkerKey
import com.anime.core.work.DaggerWorkerFactory
import com.anime.topanimesrepos.scheduler.RepositoriesUpdateWorker
import com.anime.topanimesrepos.view.TopAnimesReposFragment
import com.anime.topanimesrepos.view.TopAnimesReposViewModel
import dagger.Binds
import dagger.Module
import dagger.android.ContributesAndroidInjector
import dagger.multibindings.IntoMap

@Module(
    includes = [
        EntitiesModule::class,
        DatabaseModule::class,
        NetworkModule::class,
        BaseViewModule::class,
        SchedulerModule::class,
        TopAnimesReposApiModule::class
    ]
)
@Suppress("unused")
abstract class TopAnimesReposModule {

    companion object {
        const val ENTITIES = "ENTITIES"
        const val NETWORK = "NETWORK"
    }

    @ContributesAndroidInjector
    abstract fun bindGithubReposFragment(): TopAnimesReposFragment

    @Binds
    @IntoMap
    @ViewModelKey(TopAnimesReposViewModel::class)
    abstract fun bindReposViewModel(viewModel: TopAnimesReposViewModel)
            : ViewModel

    @Binds
    @IntoMap
    @WorkerKey(RepositoriesUpdateWorker::class)
    abstract fun bindRepositoriesUpdateWorker(factory: RepositoriesUpdateWorker.Factory)
            : DaggerWorkerFactory.ChildWorkerFactory

}
