package com.example.topanimesrepos.view

import com.example.topanimesrepos.entity.Anime

sealed class TopAnimesReposViewState {

    object InProgress : TopAnimesReposViewState()

    class ShowRepositories(val animes: List<Anime>) : TopAnimesReposViewState()

    class ShowError(val message: String?) : TopAnimesReposViewState()
}
