package com.anime.topanimesrepos.view

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.anime.core.connectivity.ConnectivityLiveData
import com.anime.core.connectivity.ConnectivityState
import com.anime.topanimesrepos.entity.TopAnimesReposState
import com.anime.core.providers.DataProvider
import com.anime.topanimesrepos.di.TopAnimesReposModule
import kotlinx.coroutines.*
import javax.inject.Inject
import javax.inject.Named
import kotlin.coroutines.CoroutineContext

class TopAnimesReposViewModel @Inject constructor(
    @Named(TopAnimesReposModule.ENTITIES) private val topAnimesReposProvider: DataProvider<TopAnimesReposState>,
    val connectivityLiveData: MutableLiveData<ConnectivityState> = MutableLiveData(),
    private val mutableLiveData: MutableLiveData<TopAnimesReposViewState> = MutableLiveData()
) : ViewModel(), CoroutineScope {

    private val sortButtonsEnabled: MutableLiveData<Boolean> = MutableLiveData()

    private val job = Job()
    override val coroutineContext: CoroutineContext
        get() = Dispatchers.Main + job

    val topAnimesReposViewState: LiveData<TopAnimesReposViewState>
        get() = mutableLiveData

    val buttonState: LiveData<Boolean>
        get() = sortButtonsEnabled

    init {
        load()
    }

    override fun onCleared() {
        super.onCleared()
        job.cancel()
    }

    fun load() = launch {
        withContext(Dispatchers.IO) {
            topAnimesReposProvider.requestData { githubReposState ->
                update(githubReposState)
            }
        }
    }

    private fun update(topAnimesReposState: TopAnimesReposState) = launch {
        withContext(Dispatchers.Main) {
            mutableLiveData.value = when (topAnimesReposState) {
                TopAnimesReposState.Loading -> TopAnimesReposViewState.InProgress
                is TopAnimesReposState.Error -> TopAnimesReposViewState.ShowError(topAnimesReposState.message)
                is TopAnimesReposState.Success -> TopAnimesReposViewState.ShowRepositories(topAnimesReposState.animes)
            }
        }
    }

    fun sortByMemebers() {
        launch {
            withContext(Dispatchers.Default) {
                when(val data = mutableLiveData.value) {
                    is TopAnimesReposViewState.ShowRepositories -> {
                        val items = data.animes.sortedByDescending { it.members }
                        update(TopAnimesReposState.Success(items))
                    }
                }
            }
        }
    }

    fun sortByRank() {
        launch {
            sortButtonsEnabled.value = false
            withContext(Dispatchers.Default) {
                delay(1000)
                    when (val data = mutableLiveData.value) {
                        is TopAnimesReposViewState.ShowRepositories -> {
                            val items = data.animes.sortedBy { it.rank }
                            update(TopAnimesReposState.Success(items))
                        }
                        else -> {
                            // Nothing yet
                        }
                    }
            }
            sortButtonsEnabled.value = true
        }
    }

}