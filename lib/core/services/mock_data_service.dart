import '../../domain/entities/anime.dart';
import '../../domain/entities/manga.dart';
import '../../domain/entities/light_novel.dart';

/// Mock data service providing sample data for testing
class MockDataService {
  /// Mock anime data
  static List<Anime> get mockAnimeList => [
    const Anime(
      id: 1,
      rank: 1,
      title: 'Attack on Titan: The Final Season',
      url: 'https://myanimelist.net/anime/40028',
      imageUrl: 'https://cdn.myanimelist.net/images/anime/1/110531.jpg',
      synopsis: 'The fourth and final season of Attack on Titan.',
      score: 9.0,
      status: 'Currently Airing',
      episodes: 16,
      season: 'Winter 2021',
      broadcast: 'Sundays at 00:10 (JST)',
      members: 1500000,
    ),
    const Anime(
      id: 2,
      rank: 2,
      title: 'Demon Slayer: Kimetsu no Yaiba',
      url: 'https://myanimelist.net/anime/44081',
      imageUrl: 'https://cdn.myanimelist.net/images/anime/1/123767.jpg',
      synopsis: 'Tanjiro continues his mission to turn his sister back into a human.',
      score: 8.7,
      status: 'Finished Airing',
      episodes: 44,
      season: 'Spring 2021',
      broadcast: 'Sundays at 23:15 (JST)',
      members: 2000000,
    ),
    const Anime(
      id: 3,
      rank: 3,
      title: 'Jujutsu Kaisen',
      url: 'https://myanimelist.net/anime/40748',
      imageUrl: 'https://cdn.myanimelist.net/images/anime/1/113138.jpg',
      synopsis: 'A boy swallows a cursed talisman and must learn to control his newfound powers.',
      score: 8.6,
      status: 'Finished Airing',
      episodes: 24,
      season: 'Fall 2020',
      broadcast: 'Fridays at 01:25 (JST)',
      members: 1800000,
    ),
  ];

  /// Mock manga data
  static List<Manga> get mockMangaList => [
    const Manga(
      id: 1,
      title: 'One Piece',
      url: 'https://myanimelist.net/manga/13',
      imageUrl: 'https://cdn.myanimelist.net/images/manga/2/253146.jpg',
      synopsis: 'Monkey D. Luffy sets off on an adventure to become the next Pirate King.',
      score: 9.2,
      status: 'Publishing',
      chapters: 1100,
      volumes: 105,
      members: 2500000,
    ),
    const Manga(
      id: 2,
      title: 'Berserk',
      url: 'https://myanimelist.net/manga/2',
      imageUrl: 'https://cdn.myanimelist.net/images/manga/1/157897.jpg',
      synopsis: 'Guts, a former mercenary now known as the "Black Swordsman."',
      score: 9.4,
      status: 'Publishing',
      chapters: 374,
      volumes: 41,
      members: 800000,
    ),
    const Manga(
      id: 3,
      title: 'Monster',
      url: 'https://myanimelist.net/manga/1',
      imageUrl: 'https://cdn.myanimelist.net/images/manga/3/258749.jpg',
      synopsis: 'Dr. Tenma must choose between saving a child or a mayor.',
      score: 9.1,
      status: 'Finished',
      chapters: 162,
      volumes: 18,
      members: 650000,
    ),
  ];

  /// Mock light novel data
  static List<LightNovel> get mockLightNovelList => [
    const LightNovel(
      id: 1,
      title: 'Sword Art Online',
      url: 'https://ranobedb.org/novel/1',
      imageUrl: 'https://cdn.ranobedb.org/covers/1.jpg',
      synopsis: 'Players are trapped in a virtual reality MMORPG where dying in the game means dying in real life.',
      status: 'Completed',
      year: 2009,
      volumes: 25,
      authors: ['Reki Kawahara'],
      language: 'Japanese',
    ),
    const LightNovel(
      id: 2,
      title: 'Overlord',
      url: 'https://ranobedb.org/novel/2',
      imageUrl: 'https://cdn.ranobedb.org/covers/2.jpg',
      synopsis: 'A player finds himself trapped in the world of his favorite MMORPG as his character, an undead overlord.',
      status: 'Ongoing',
      year: 2012,
      volumes: 16,
      authors: ['Kugane Maruyama'],
      language: 'Japanese',
    ),
    const LightNovel(
      id: 3,
      title: 'Re:Zero − Starting Life in Another World',
      url: 'https://ranobedb.org/novel/3',
      imageUrl: 'https://cdn.ranobedb.org/covers/3.jpg',
      synopsis: 'Subaru gains the ability to return to a previous point in time upon death.',
      status: 'Ongoing',
      year: 2014,
      volumes: 30,
      authors: ['Tappei Nagatsuki'],
      language: 'Japanese',
    ),
  ];

  /// Get mock search results based on query
  static Map<String, List<dynamic>> getMockSearchResults(String query) {
    final results = <String, List<dynamic>>{};
    
    // Filter anime
    final animeResults = mockAnimeList
        .where((anime) => anime.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    if (animeResults.isNotEmpty) {
      results['anime'] = animeResults;
    }
    
    // Filter manga
    final mangaResults = mockMangaList
        .where((manga) => manga.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    if (mangaResults.isNotEmpty) {
      results['manga'] = mangaResults;
    }
    
    // Filter light novels
    final lightNovelResults = mockLightNovelList
        .where((ln) => ln.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    if (lightNovelResults.isNotEmpty) {
      results['light_novels'] = lightNovelResults;
    }
    
    return results;
  }
}