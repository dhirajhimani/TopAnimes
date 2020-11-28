package com.example.topanimesrepos.di

import android.app.Application
import androidx.room.Room
import com.example.core.providers.DataMapper
import com.example.core.providers.DataPersister
import com.example.topanimesrepos.database.*
import com.example.topanimesrepos.entity.Anime
import dagger.Module
import dagger.Provides

@Module
object DatabaseModule {

    @Provides
    @JvmStatic
    internal fun providesDatabase(context: Application): RepositoriesDatabase =
        Room.databaseBuilder(context, RepositoriesDatabase::class.java, "animes").build()

    @Provides
    @JvmStatic
    internal fun providesRepositoriesDao(database: RepositoriesDatabase): RepositoriesDao =
        database.repositoryDao()

    @Provides
    @JvmStatic
    internal fun providesDatabaseRepositoriesMapper():
            DataMapper<Anime, DbRepository> =
        DatabaseRepositoriesMapper()

    @Provides
    @JvmStatic
    internal fun providesDatabasePersister(
        dao: RepositoriesDao,
        mapper: DataMapper<Anime, DbRepository>
    ): DataPersister<List<Anime>> =
        DatabaseRepositoriesPersister(dao, mapper)
}