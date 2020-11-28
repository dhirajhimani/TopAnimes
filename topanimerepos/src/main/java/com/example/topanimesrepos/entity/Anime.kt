package com.example.topanimesrepos.entity

data class Anime(
    val rank: Int,
    val title: String,
    val webUrl: String,
    val image_url: String,
    val members: Int,
    val expiry: Long
)