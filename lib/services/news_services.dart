import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/news_model.dart';


class NewsServices {
  final String apiKey;
  final String baseUrl;

  NewsServices({required this.apiKey, required this.baseUrl});

  Future<List<Articles>> fetchNews() async {
    final response = await http.get(Uri.parse('$baseUrl/everything?q=keyword&apiKey=$apiKey'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> articlesData = responseData['articles'];

      return articlesData.map((articleJson) {
        return Articles.fromJson(articleJson);
      }).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
