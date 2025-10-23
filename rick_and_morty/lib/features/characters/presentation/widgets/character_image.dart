import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../../features.dart';

class _RickAndMortyCacheManager {
  static CacheManager instance = CacheManager(
    Config(
      'rickAndMortyCache',
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 200,
    ),
  );
}

class CharacterImage extends StatelessWidget {
  const CharacterImage({super.key, required this.character, this.scale = 0.18});
  final CharacterEntity character;
  final double scale;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final imageSize = width * scale;
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: CachedNetworkImage(
        cacheManager: _RickAndMortyCacheManager.instance,
        imageUrl: character.image,
        width: imageSize,
        height: imageSize,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          width: imageSize,
          height: imageSize,
          color: Colors.grey.shade300,
          child: const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.black54,
            ),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          width: imageSize,
          height: imageSize,
          color: Colors.grey.shade300,
          child: const Icon(Icons.error, color: Colors.red),
        ),
      ),
    );
  }
}
