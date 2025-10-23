import '../../domain/domain.dart';
import '../data.dart';

import '../datasources/character_local_datasource.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource remote;
  final CharacterLocalDataSource local;

  CharacterRepositoryImpl({required this.remote, required this.local});

  @override
  Future<List<CharacterEntity>> getCharacters(int page) async {
    try {
      final remoteData = await remote.fetchCharacters(page);
      if (page == 1) {
        await local.saveCharacters(remoteData);
      }
      return remoteData.map((e) => CharacterModel.toEntity(e)).toList();
    } catch (e) {
      final cached = await local.getCharacters();
      if (cached.isNotEmpty) {
        return cached.map((e) => CharacterModel.toEntity(e)).toList();
      }
      rethrow;
    }
  }
}
