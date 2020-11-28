package com.example.topanimesrepos.view

import android.view.View
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.drawable.DrawableTransitionOptions.withCrossFade
import com.example.topanimesrepos.R
import com.example.topanimesrepos.entity.Anime


class TopAnimesReposViewHolder(
    item: View,
    private val repositoryView: View = item.findViewById(R.id.repository_view),
    private val extraInfoView: View = item.findViewById(R.id.contentGroup),
    private val avatarImageView: ImageView = item.findViewById(R.id.avatar_image),
    private val nameView: TextView = item.findViewById(R.id.name),
    private val descriptionView: TextView = item.findViewById(R.id.description),
    private val repoUrlView: TextView = item.findViewById(R.id.repo_url),
    private val languageView: TextView = item.findViewById(R.id.language),
    private val starCountView: TextView = item.findViewById(R.id.star_count),
    private val forkCountView: TextView = item.findViewById(R.id.fork_count)
) : RecyclerView.ViewHolder(item) {

    fun bind(
        position: Int,
        isExpanded: Boolean,
        anime: Anime,
        clickListener: ItemClickListener
    ) {
        nameView.text = anime.title
        descriptionView.text = "Unknown"
        repoUrlView.text = anime.myAnimeListURl
        languageView.text = "N/A"
        starCountView.text = anime.members.toString()
        forkCountView.text = "N/A"

        Glide.with(avatarImageView)
            .load(anime.image_url)
            .transition(withCrossFade())
            .circleCrop()
            .into(avatarImageView)

        extraInfoView.visibility = if (isExpanded) View.VISIBLE else View.GONE
        extraInfoView.isActivated = isExpanded
        repositoryView.setOnClickListener {
            clickListener.onItemClick(position, isExpanded)
        }
    }
}
