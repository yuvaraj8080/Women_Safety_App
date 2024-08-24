import 'package:flutter/material.dart';
import 'package:flutter_women_safety_app/Api/api_service.dart';
import 'package:flutter_women_safety_app/features/personalization/screens/News/model/news.dart';

class NewsTabView extends StatefulWidget {
  @override
  _NewsTabViewState createState() => _NewsTabViewState();
}

class _NewsTabViewState extends State<NewsTabView> {
  late Future<List<Article>> futureArticles;

  @override
  void initState() {
    super.initState();
    futureArticles = fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('News'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Bitcoin News'),
              Tab(text: 'Future Tab'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // First Tab: List of News Articles
            FutureBuilder<List<Article>>(
              future: futureArticles,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Failed to load news'));
                } else {
                  final articles = snapshot.data!;
                  return ListView.builder(
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      final article = articles[index];
                      return ListTile(
                        title: Text(article.title),
                        subtitle: Text(article.description),
                        leading: article.urlToImage != null
                            ? Image.network(article.urlToImage, width: 100, fit: BoxFit.cover)
                            : null,
                        onTap: () {
                          // Handle tap event, e.g., navigate to a detailed view
                        },
                      );
                    },
                  );
                }
              },
            ),
            // Second Tab: Blank for future use
            Center(child: Text('This tab is blank for future use.')),
          ],
        ),
      ),
    );
  }
}
