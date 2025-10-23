part of 'character_cubit.dart';

@freezed
class CharacterState with _$CharacterState {
  const factory CharacterState.initial() = _Initial;
  const factory CharacterState.loading(List<CharacterEntity> characters) = _Loading;
  const factory CharacterState.loaded(List<CharacterEntity> characters, bool hasMore) = _Loaded;
  const factory CharacterState.error(String message) = _Error;
}
