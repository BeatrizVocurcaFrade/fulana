import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/features/characters/domain/domain.dart';

class CharacterDetailPage extends StatelessWidget {
  final CharacterEntity character;

  const CharacterDetailPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(character.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(character.image,
                  height: 200, fit: BoxFit.cover),
            ),
            const SizedBox(height: 20),
            Text(character.name,
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('Status: ${character.status}'),
            Text('Espécie: ${character.species}'),
          ],
        ),
      ),
    );
  }
}
