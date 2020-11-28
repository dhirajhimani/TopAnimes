package com.anime.topanimesrepos.database

import com.anime.topanimesrepos.entity.Anime
import com.anime.core.providers.DataMapper

class DatabaseRepositoriesMapper :
        DataMapper<Anime, DbRepository> {

    override fun encode(source: Anime): DbRepository {
        return DbRepository(
            source.rank,
            source.title,
            source.webUrl,
            source.image_url,
            source.members,
            source.expiry
        )
    }


    override fun decode(source: DbRepository): Anime {
        return Anime(
            source.rank,
            source.title,
            source.myAnimeListURl,
            source.image_url,
            source.members,
            source.expiry
        )
    }
}
