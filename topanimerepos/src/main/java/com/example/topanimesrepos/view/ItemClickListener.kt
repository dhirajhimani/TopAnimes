package com.example.topanimesrepos.view

import android.content.Context
import com.example.topanimesrepos.entity.Anime


interface ItemClickListener {
    fun onItemClick(context: Context, anime: Anime, isExpanded: Boolean)
}