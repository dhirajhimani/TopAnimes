package com.example.topanimesrepos.database

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "anime")
data class DbRepository(
    @PrimaryKey val rank: Int,
    val title: String,
    val myAnimeListURl: String,
    val image_url: String,
    val members: Int,
    val expiry: Long)