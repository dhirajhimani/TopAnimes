package com.example.topanimesrepos.entity

sealed class TopAnimesReposState {

    object Loading : TopAnimesReposState()

    class Success(val animes: List<Anime>) : TopAnimesReposState()

    class Error(val message: String?) : TopAnimesReposState()
}
