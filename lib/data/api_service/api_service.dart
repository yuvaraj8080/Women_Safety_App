import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../features/News/model/news.dart';

Future<List<NewArticleModel>> fetchNews() async {
  final response = await http.get(
    Uri.parse('https://newsapi.org/v2/everything?q=bitcoin'),
    headers: {'X-api_service-Key': 'fcdbf060cc944959afda76a67c6d21ca'},
  );

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final List<dynamic> articlesJson = jsonResponse['articles'];

    return articlesJson.map((json) => NewArticleModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load news');
  }
}
