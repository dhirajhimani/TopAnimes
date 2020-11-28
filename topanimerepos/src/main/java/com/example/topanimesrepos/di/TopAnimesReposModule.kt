package com.example.topanimesrepos.di

import androidx.lifecycle.ViewModel
import com.example.core.di.BaseViewModule
import com.example.core.di.ViewModelKey
import com.example.core.di.WorkerKey
import com.example.core.work.DaggerWorkerFactory
import com.example.topanimesrepos.scheduler.RepositoriesUpdateWorker
import com.example.topanimesrepos.view.TopAnimesReposFragment
import com.example.topanimesrepos.view.TopAnimesReposViewModel
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
