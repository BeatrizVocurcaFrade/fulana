import '../../../../core/core.dart';
import '../data.dart';

class CharacterLocalDataSource {
  final LocalCache cache;

  CharacterLocalDataSource(this.cache);

  Future<void> saveCharacters(List<CharacterModel> characters) async {
    final data = characters.map((e) => e.toJson()).toList();
    await cache.saveCharacters(data);
  }

  Future<List<CharacterModel>> getCharacters() async {
    final data = await cache.getCharacters();
    return data.map((e) => CharacterModel.fromJson(e)).toList();
  }
}
