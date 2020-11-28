package com.anime.topanimesrepos.view

import android.content.Context
import com.anime.topanimesrepos.entity.Anime


interface ItemClickListener {
    fun onItemClick(context: Context, anime: Anime, isExpanded: Boolean)
}