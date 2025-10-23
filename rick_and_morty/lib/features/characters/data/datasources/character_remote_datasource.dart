import '../../../../core/core.dart';
import '../data.dart';

class CharacterRemoteDataSource {
  final ApiClient client;
  CharacterRemoteDataSource(this.client);

  Future<List<CharacterModel>> fetchCharacters(int page) async {
    final data = await client.get('character?page=$page');
    final results = List<Map<String, dynamic>>.from(data['results']);
    return results.map(CharacterModel.fromJson).toList();
  }
}
