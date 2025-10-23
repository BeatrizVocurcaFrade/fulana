// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'character_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CharacterEntity {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get species => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;

  /// Create a copy of CharacterEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CharacterEntityCopyWith<CharacterEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharacterEntityCopyWith<$Res> {
  factory $CharacterEntityCopyWith(
          CharacterEntity value, $Res Function(CharacterEntity) then) =
      _$CharacterEntityCopyWithImpl<$Res, CharacterEntity>;
  @useResult
  $Res call({int id, String name, String status, String species, String image});
}

/// @nodoc
class _$CharacterEntityCopyWithImpl<$Res, $Val extends CharacterEntity>
    implements $CharacterEntityCopyWith<$Res> {
  _$CharacterEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CharacterEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? status = null,
    Object? species = null,
    Object? image = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      species: null == species
          ? _value.species
          : species // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CharacterEntityImplCopyWith<$Res>
    implements $CharacterEntityCopyWith<$Res> {
  factory _$$CharacterEntityImplCopyWith(_$CharacterEntityImpl value,
          $Res Function(_$CharacterEntityImpl) then) =
      __$$CharacterEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String status, String species, String image});
}

/// @nodoc
class __$$CharacterEntityImplCopyWithImpl<$Res>
    extends _$CharacterEntityCopyWithImpl<$Res, _$CharacterEntityImpl>
    implements _$$CharacterEntityImplCopyWith<$Res> {
  __$$CharacterEntityImplCopyWithImpl(
      _$CharacterEntityImpl _value, $Res Function(_$CharacterEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of CharacterEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? status = null,
    Object? species = null,
    Object? image = null,
  }) {
    return _then(_$CharacterEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      species: null == species
          ? _value.species
          : species // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CharacterEntityImpl implements _CharacterEntity {
  _$CharacterEntityImpl(
      {required this.id,
      required this.name,
      required this.status,
      required this.species,
      required this.image});

  @override
  final int id;
  @override
  final String name;
  @override
  final String status;
  @override
  final String species;
  @override
  final String image;

  @override
  String toString() {
    return 'CharacterEntity(id: $id, name: $name, status: $status, species: $species, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CharacterEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.species, species) || other.species == species) &&
            (identical(other.image, image) || other.image == image));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, status, species, image);

  /// Create a copy of CharacterEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CharacterEntityImplCopyWith<_$CharacterEntityImpl> get copyWith =>
      __$$CharacterEntityImplCopyWithImpl<_$CharacterEntityImpl>(
          this, _$identity);
}

abstract class _CharacterEntity implements CharacterEntity {
  factory _CharacterEntity(
      {required final int id,
      required final String name,
      required final String status,
      required final String species,
      required final String image}) = _$CharacterEntityImpl;

  @override
  int get id;
  @override
  String get name;
  @override
  String get status;
  @override
  String get species;
  @override
  String get image;

  /// Create a copy of CharacterEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CharacterEntityImplCopyWith<_$CharacterEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
