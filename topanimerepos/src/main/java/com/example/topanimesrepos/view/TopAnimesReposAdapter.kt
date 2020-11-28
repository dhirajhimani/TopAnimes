package com.example.topanimesrepos.view

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.example.topanimesrepos.R
import com.example.topanimesrepos.entity.Anime

class TopAnimesReposAdapter(
    private val items: MutableList<Anime> = mutableListOf()
) : RecyclerView.Adapter<TopAnimesReposViewHolder>(), ItemClickListener {

    private var mExpandedPosition = -1
    private var previousExpandedPosition = -1

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): TopAnimesReposViewHolder =
        TopAnimesReposViewHolder(
            LayoutInflater.from(parent.context)
                .inflate(getLayoutId(viewType), parent, false)
        )

    private fun getLayoutId(viewType: Int) =
        when(viewType) {
            ViewSize.FULL.ordinal -> R.layout.item_top_anime_full
            ViewSize.DOUBLE.ordinal -> R.layout.item_top_anime_medium
            else -> R.layout.item_top_anime_small
        }

    override fun getItemCount(): Int = items.size

    override fun onBindViewHolder(holder: TopAnimesReposViewHolder, position: Int) {
        val isExpanded = position == mExpandedPosition
        if (isExpanded)
            previousExpandedPosition = position
        items[position].also { anime ->
            holder.bind(
                position,
                isExpanded,
                anime,
                this
            )
        }
    }

    fun getItems(): List<Anime> {
        return items
    }

    fun replace(animes: List<Anime>) {
        items.clear()
        items += animes
        notifyDataSetChanged()
    }

    override fun onItemClick(position: Int, isExpanded: Boolean) {
    }
}
