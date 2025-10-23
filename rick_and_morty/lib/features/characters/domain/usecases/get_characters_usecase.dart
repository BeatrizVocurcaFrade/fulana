import '../entities/character_entity.dart';
import '../repositories/character_repository.dart';

class GetCharactersUseCase {
  final CharacterRepository repository;
  GetCharactersUseCase(this.repository);

  Future<List<CharacterEntity>> call(int page) {
    return repository.getCharacters(page);
  }
}
