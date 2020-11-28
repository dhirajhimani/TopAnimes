package com.anime.topanimesrepos.net

import com.anime.topanimesrepos.entity.TopAnimesReposState
import com.anime.topanimesrepos.entity.Anime
import com.anime.core.INetworkCheck
import com.anime.core.providers.DataMapper
import com.anime.core.providers.DataProvider
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import java.util.concurrent.TimeUnit

class TopAnimesReposProvider(
    private val topAnimesReposApi: TopAnimesReposApi,
    private val connectivityChecker: INetworkCheck,
    private val mapper: DataMapper<Pair<List<TopAnime>, Long>, List<Anime>>
) : DataProvider<TopAnimesReposState> {

    override fun requestData(callback: (topAnimesReposState: TopAnimesReposState) -> Unit) {
        if (!connectivityChecker.isConnected) {
            callback(TopAnimesReposState.Error("No network connectivity"))
            return
        }
        callback(TopAnimesReposState.Loading)
        topAnimesReposApi.getGithubRepos().enqueue(object : Callback<TopAnimes> {
            override fun onFailure(call: Call<TopAnimes>, t: Throwable) {
                callback(TopAnimesReposState.Error(t.localizedMessage))
            }

            override fun onResponse(call: Call<TopAnimes>, response: Response<TopAnimes>) {
                response.body()?.also { topAnimes ->
                    val timeToExpire = System.currentTimeMillis() + TimeUnit.HOURS.toMillis(2)
                    callback(TopAnimesReposState.Success(mapper.encode(topAnimes.top to timeToExpire)))
                }
            }
        })
    }

    override fun requestData(): TopAnimesReposState {
        return if (!connectivityChecker.isConnected) {
            TopAnimesReposState.Error("No network connectivity")
        } else {
            val response: Response<TopAnimes> = topAnimesReposApi.getGithubRepos().execute()
            response.takeIf { it.isSuccessful }?.body()?.let { topAnimes ->
                val timeToExpire = System.currentTimeMillis() + TimeUnit.HOURS.toMillis(2)
                TopAnimesReposState.Success(mapper.encode(topAnimes.top to timeToExpire))
             } ?: TopAnimesReposState.Error(response.errorBody()?.string() ?: "Network Error")
        }
    }
}
