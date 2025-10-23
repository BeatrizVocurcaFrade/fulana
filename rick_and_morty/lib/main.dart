import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty_app/core/cache/local_cache.dart';
import 'package:rick_and_morty_app/features/characters/data/datasources/character_local_datasource.dart';

import 'core/network/api_client.dart';
import 'features/characters/data/datasources/character_remote_datasource.dart';
import 'features/characters/data/repositories/character_repository_impl.dart';
import 'features/characters/domain/usecases/get_characters_usecase.dart';
import 'features/characters/presentation/cubit/character_cubit.dart';
import 'features/characters/presentation/pages/character_list_page.dart';

void main() {
  runApp(const RickMortyApp());
}

class RickMortyApp extends StatelessWidget {
  const RickMortyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CharacterCubit(
        GetCharactersUseCase(
          CharacterRepositoryImpl(local: CharacterLocalDataSource(LocalCache()),
           remote:  CharacterRemoteDataSource(ApiClient()),
          ),
        ),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rick and Morty',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: const Color(0xFFB6DAEE),
          scaffoldBackgroundColor: const Color(0xFF0D0D0D),
          useMaterial3: true,
          colorScheme: ColorScheme.dark(
            primary: const Color(0xFFB6DAEE),
            secondary:   Colors.brown,
            surface:  Colors.yellow,
          ),
          textTheme: GoogleFonts.bangersTextTheme(
            Theme.of(context).textTheme.apply(
                  bodyColor: Colors.white,
                  displayColor: Colors.greenAccent,
                ),
          ),
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: Colors.greenAccent,
          ),
        ),
        home: const CharacterListPage(),
      ),
    );
  }
}
