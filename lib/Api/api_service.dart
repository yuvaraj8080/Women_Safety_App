import 'dart:convert';
import 'package:flutter_women_safety_app/features/personalization/screens/News/model/news.dart';
import 'package:http/http.dart' as http;

Future<List<Article>> fetchNews() async {
  final response = await http.get(
    Uri.parse('https://newsapi.org/v2/everything?q=bitcoin'),
    headers: {
      'X-Api-Key': 'fcdbf060cc944959afda76a67c6d21ca',
    },
  );

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    final List<dynamic> articlesJson = json['articles'];
    return articlesJson.map((json) => Article.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load news');
  }
}
