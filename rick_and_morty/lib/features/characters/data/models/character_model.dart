import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/domain.dart';

part 'character_model.freezed.dart';
part 'character_model.g.dart';

@freezed
sealed class CharacterModel with _$CharacterModel {
  factory CharacterModel({
    required int id,
    required String name,
    required String status,
    required String species,
    required String image,
  }) = _CharacterModel;

  factory CharacterModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);

  static CharacterEntity toEntity(CharacterModel model) => CharacterEntity(
        id: model.id,
        name: model.name,
        status: model.status,
        species: model.species,
        image: model.image,
      );
}
