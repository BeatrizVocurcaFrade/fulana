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
  void dispose() {
    _controller.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rick & Morty',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<CharacterCubit, CharacterState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Color(0xFF97CE4C),
                    strokeWidth: 4,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Carregando personagens...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            loading: (characters) => CharacterListView(
                characters: characters,
                isLoading: true,
                controller: _controller),
            loaded: (characters, hasMore) => CharacterListView(
                characters: characters,
                hasMore: hasMore,
                controller: _controller),
            error: (msg) => Center(child: Text(msg)),
          );
        },
      ),
    );
  }
}

class CharacterListView extends StatelessWidget {
  final List<CharacterEntity> characters;
  final bool isLoading;
  final bool hasMore;
  final ScrollController controller;

  const CharacterListView({
    super.key,
    required this.characters,
    this.isLoading = false,
    this.hasMore = true,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      itemCount: characters.length + ((isLoading || hasMore) ? 1 : 0),
      itemBuilder: (context, index) {
        switch (index < characters.length) {
          case true:
            final character = characters[index];
            return CharacterCard(
              character: character,
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) =>
                        CharacterDetailPage(character: character),
                    transitionsBuilder: (_, animation, __, child) =>
                        FadeTransition(opacity: animation, child: child),
                  ),
                );
              },
            );
          case false:
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: SizedBox(
                height: 300,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFFB6DAEE),
                  ),
                ),
              ),
            );
        }
      },
    );
  }
}
