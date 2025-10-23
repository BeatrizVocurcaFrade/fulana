import 'package:flutter/material.dart';

import '../../domain/domain.dart';

class CharacterCard extends StatelessWidget {
  final CharacterEntity character;
  final VoidCallback onTap;

  const CharacterCard(
      {super.key, required this.character, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(character.image,
            width: 56, height: 56, fit: BoxFit.cover,errorBuilder: (context, error, stackTrace) => Text("ds"),),
      ),
      title: Text(character.name,
          style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(character.species),
      onTap: onTap,
    );
  }
}
