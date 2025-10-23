import 'package:hive/hive.dart';

class LocalCache {
  static const String charactersBox = 'characters';

  Future<void> saveCharacters(List<Map<String, dynamic>> data) async {
    final box = await Hive.openBox(charactersBox);
    await box.put('list', data);
  }

  Future<List<Map<String, dynamic>>> getCharacters() async {
    final box = await Hive.openBox(charactersBox);
    final list = box.get('list', defaultValue: <Map<String, dynamic>>[]);
    return List<Map<String, dynamic>>.from(list);
  }
}
