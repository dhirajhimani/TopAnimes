package com.anime.topanimesrepos.net

import retrofit2.Call
import retrofit2.http.GET


interface TopAnimesReposApi {

    @GET("1/upcoming")
    fun getGithubRepos(): Call<TopAnimes>
}
