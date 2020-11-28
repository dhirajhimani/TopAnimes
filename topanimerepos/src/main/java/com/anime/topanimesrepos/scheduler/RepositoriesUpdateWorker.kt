package com.anime.topanimesrepos.scheduler

import android.content.Context
import androidx.work.ListenableWorker
import androidx.work.Worker
import androidx.work.WorkerParameters
import com.anime.core.providers.DataPersister
import com.anime.core.providers.DataProvider
import com.anime.core.scheduler.UpdateScheduler
import com.anime.core.work.DaggerWorkerFactory
import com.anime.topanimesrepos.di.TopAnimesReposModule
import com.anime.topanimesrepos.entity.TopAnimesReposState
import com.anime.topanimesrepos.entity.Anime
import javax.inject.Inject
import javax.inject.Named

class RepositoriesUpdateWorker(
    private val provider: DataProvider<TopAnimesReposState>,
    private val persister: DataPersister<List<Anime>>,
    private val scheduler: UpdateScheduler<Anime>,
    context: Context,
    workerParameters: WorkerParameters
) : Worker(context, workerParameters) {

    override fun doWork(): Result =
        when (val state = provider.requestData()) {
            is TopAnimesReposState.Success -> {
                persister.persistData(state.animes)
                scheduler.scheduleUpdate(state.animes)
                Result.success()
            }
            is TopAnimesReposState.Error -> {
                Result.retry()
            }
            TopAnimesReposState.Loading -> throw IllegalStateException("Unexpected Loading State")
        }

    class Factory @Inject constructor(
        @Named(TopAnimesReposModule.NETWORK) private val provider: DataProvider<TopAnimesReposState>,
        private val persister: DataPersister<List<Anime>>,
        private val scheduler: UpdateScheduler<Anime>,
    ) : DaggerWorkerFactory.ChildWorkerFactory {

        override fun create(
            appContext: Context,
            workerParameters: WorkerParameters
        ): ListenableWorker =
            RepositoriesUpdateWorker(provider, persister, scheduler, appContext, workerParameters)
    }
}