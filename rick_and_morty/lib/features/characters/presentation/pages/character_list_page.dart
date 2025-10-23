import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features.dart';
import '../cubit/character_cubit.dart';

class CharacterListPage extends StatefulWidget {
  const CharacterListPage({super.key});

  @override
  State<CharacterListPage> createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<CharacterListPage> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_onScroll);
    context.read<CharacterCubit>().loadCharacters();
  }

  void _onScroll() {
    if (_controller.position.pixels >=
        _controller.position.maxScrollExtent - 200) {
      context.read<CharacterCubit>().loadCharacters();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rick & Morty'), centerTitle: true),
      body: BlocBuilder<CharacterCubit, CharacterState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: (characters) => _buildList(characters, isLoading: true),
            loaded: (characters, hasMore) => _buildList(characters, hasMore: hasMore),
            error: (msg) => Center(child: Text(msg)),
          );
        },
      ),
    );
  }

  Widget _buildList(List<CharacterEntity> characters,
      {bool isLoading = false, bool hasMore = true}) {
    return ListView.builder(
      controller: _controller,
      itemCount: characters.length + (isLoading || hasMore ? 1 : 0),
      itemBuilder: (context, i) {
        if (i < characters.length) {
          final character = characters[i];
          return CharacterCard(character: character, onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => CharacterDetailPage(character: character),
                transitionsBuilder: (_, animation, __, child) =>
                    FadeTransition(opacity: animation, child: child),
              ),
            );
          });
        } else {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
