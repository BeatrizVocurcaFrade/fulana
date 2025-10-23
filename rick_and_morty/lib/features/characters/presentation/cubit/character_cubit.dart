import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/domain.dart';

part 'character_cubit.freezed.dart';
part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final GetCharactersUseCase useCase;
  int _page = 1;
  bool _hasMore = true;
  final List<CharacterEntity> _characters = [];

  CharacterCubit(this.useCase) : super(const CharacterState.initial());

  Future<void> loadCharacters() async {
    if (!_hasMore) return;

    emit(CharacterState.loading(_characters));
    try {
      final newCharacters = await useCase(_page);
      _characters.addAll(newCharacters);
      _hasMore = newCharacters.isNotEmpty;
      _page++;
      emit(CharacterState.loaded(_characters, _hasMore));
    } catch (e) {
      emit(CharacterState.error(e.toString()));
    }
  }
}
