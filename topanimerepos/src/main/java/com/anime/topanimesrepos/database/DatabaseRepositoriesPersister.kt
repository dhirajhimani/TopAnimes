package com.anime.topanimesrepos.database

import com.anime.core.providers.DataMapper
import com.anime.core.providers.DataPersister
import com.anime.topanimesrepos.entity.Anime


class DatabaseRepositoriesPersister(
    private val dao: RepositoriesDao,
    private val mapper: DataMapper<Anime, DbRepository>
) : DataPersister<List<Anime>> {

    override fun persistData(data: List<Anime>) {
        dao.deleteAll()
        val dbData: List<DbRepository> = data.map { repository ->
            mapper.encode(repository)
        }
        dao.insertAnimes(dbData)
    }

    override fun requestData(callback: (item: List<Anime>) -> Unit) {
        dao.deleteOutdated(System.currentTimeMillis())
        val repositories = dao.getAnimes().map { dbRepository ->
            mapper.decode(dbRepository)
        }
        callback(repositories)
    }
}
