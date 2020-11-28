package com.example.topanimesrepos.scheduler

import androidx.work.*
import com.example.core.scheduler.UpdateScheduler
import com.example.topanimesrepos.entity.Anime
import java.util.concurrent.TimeUnit
import javax.inject.Inject

class RepositoriesScheduler @Inject constructor() : UpdateScheduler<Anime> {

    override fun scheduleUpdate(items: List<Anime>) {
        WorkManager.getInstance()
            .enqueueUniqueWork(
                UNIQUE_WORK_ID,
                ExistingWorkPolicy.REPLACE,
                OneTimeWorkRequestBuilder<RepositoriesUpdateWorker>()
                    .setInitialDelay(items.earliestUpdate(), TimeUnit.MILLISECONDS)
                    .setConstraints(
                        Constraints.Builder()
                            .setRequiredNetworkType(NetworkType.UNMETERED)
                            .setRequiresBatteryNotLow(true)
                            .build()
                    )
                    .build()
            )
    }

    private fun List<Anime>.earliestUpdate() =
        (minBy { it.expiry }?.expiry?.let { it - System.currentTimeMillis() }
            ?: TimeUnit.HOURS.toMillis(2)) / 2

    companion object {
        private const val UNIQUE_WORK_ID: String = "RepositoriesScheduler"
    }
}