package com.example.topanimesrepos.database

import androidx.room.Database
import androidx.room.RoomDatabase

@Database(entities = [DbRepository::class], version = 1, exportSchema = false)
abstract class RepositoriesDatabase : RoomDatabase() {

    abstract fun repositoryDao(): RepositoriesDao
}