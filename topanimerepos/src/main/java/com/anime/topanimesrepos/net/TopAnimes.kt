package com.anime.topanimesrepos.net

data class TopAnimes(val top: List<TopAnime>)

data class TopAnime(
    val rank: Int,
    val title: String,
    val url: String,
    val image_url: String,
    val members: Int
)