package com.anime.topanimesrepos.view

import android.view.View
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.drawable.DrawableTransitionOptions.withCrossFade
import com.anime.topanimesrepos.R
import com.anime.topanimesrepos.entity.Anime


class TopAnimesReposViewHolder(
    item: View,
    private val repositoryView: View = item.findViewById(R.id.anime_view),
    private val avatarImageView: ImageView = item.findViewById(R.id.image),
    private val nameView: TextView = item.findViewById(R.id.name),
    private val rankView: TextView = item.findViewById(R.id.rank),
) : RecyclerView.ViewHolder(item) {

    fun bind(
        position: Int,
        isExpanded: Boolean,
        anime: Anime,
        clickListener: ItemClickListener
    ) {
        nameView.text = anime.title
        rankView.text = anime.rank.toString()

        Glide.with(avatarImageView)
            .load(anime.image_url)
            .transition(withCrossFade())
            .into(avatarImageView)

        repositoryView.setOnClickListener {
            clickListener.onItemClick(repositoryView.context, anime, isExpanded)
        }
    }
}
