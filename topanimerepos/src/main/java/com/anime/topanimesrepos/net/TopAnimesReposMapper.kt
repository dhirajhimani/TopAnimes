package com.anime.topanimesrepos.net

import com.anime.topanimesrepos.entity.Anime
import com.anime.core.providers.DataMapper

class TopAnimesReposMapper : DataMapper<Pair<List<TopAnime>, Long>, List<Anime>> {

    override fun encode(source: Pair<List<TopAnime>, Long>): List<Anime> {
        val (githubRepositories, expiry) = source
        return githubRepositories.map { topAnime ->
            Anime(
                topAnime.rank,
                topAnime.title,
                topAnime.url,
                topAnime.image_url,
                topAnime.members,
                expiry
            )
        }
    }

}