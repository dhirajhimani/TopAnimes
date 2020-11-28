package com.anime.topanimesrepos.database

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query

@Dao
interface RepositoriesDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insertAnimes(repositories: List<DbRepository>)

    @Query("SELECT * FROM anime")
    fun getAnimes(): List<DbRepository>

    @Query("DELETE FROM anime WHERE expiry < :target")
    fun deleteOutdated(target: Long)

    @Query("DELETE From anime")
    fun deleteAll()
}
