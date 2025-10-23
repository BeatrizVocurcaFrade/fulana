import 'package:flutter/material.dart';

import '../../../features.dart';

class CharacterDetailPage extends StatelessWidget {
  final CharacterEntity character;

  const CharacterDetailPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(character.name)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CharacterImage(
                character: character,
                scale: 0.8,
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
      ),
    );
  }
}
