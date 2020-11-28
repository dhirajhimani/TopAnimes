package com.anime.topanimesrepos.entity

import com.anime.core.providers.DataPersister
import com.anime.core.providers.DataProvider
import com.anime.core.scheduler.UpdateScheduler
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

class TopAnimesReposRepository(
    private val persister: DataPersister<List<Anime>>,
    private val provider: DataProvider<TopAnimesReposState>,
    private val scheduler: UpdateScheduler<Anime>
) : DataProvider<TopAnimesReposState> {

    override fun requestData(callback: (item: TopAnimesReposState) -> Unit) =
        persister.requestData { repositories ->
            if (repositories.isEmpty()) {
                provider.requestData { state ->
                    if (state is TopAnimesReposState.Success) {
                        GlobalScope.launch(Dispatchers.IO) {
                            persister.persistData(state.animes)
                        }
                        scheduler.scheduleUpdate(state.animes)
                    }
                    callback(state)
                }
            } else {
                callback(TopAnimesReposState.Success(repositories))
            }
        }
}
