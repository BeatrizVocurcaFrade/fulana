import 'package:freezed_annotation/freezed_annotation.dart';

part 'character_entity.freezed.dart';

@freezed
sealed class CharacterEntity with _$CharacterEntity {
  factory CharacterEntity({
    required int id,
    required String name,
    required String status,
    required String species,
    required String image,
  }) = _CharacterEntity;
}
