import 'dart:convert';
import 'package:http/http.dart' as http;

class DogService {
  final String baseUrl = 'https://dog.ceo/api';

  Future<List<String>> getBreeds() async {
    final url = Uri.parse('$baseUrl/breeds/list/all');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final breedsMap = data['message'] as Map<String, dynamic>;
      return breedsMap.keys.toList();
    } else {
      throw Exception('Error al cargar las razas');
    }
  }

  Future<String> getRandomImage(String breed) async {
    final url = Uri.parse('$baseUrl/breed/$breed/images/random');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['message'];
    } else {
      throw Exception('No se pudo cargar la imagen');
    }
  }
}
