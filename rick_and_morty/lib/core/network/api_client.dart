import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core.dart';

class ApiClient {
  final _baseUrl = 'https://rickandmortyapi.com/api';

  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$endpoint'));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw ApiException('Erro ${response.statusCode}: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw ApiException('Falha na conexão: $e');
    }
  }
}
