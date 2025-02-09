import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_women_safety_app/features/News/Widgets/news_widget.dart';
import 'package:flutter_women_safety_app/features/News/Widgets/report_widget.dart';
import 'package:flutter_women_safety_app/features/News/model/news.dart';
import '../../../data/api_service/api_service.dart';




class NewsTabView extends StatefulWidget {
  @override
  _NewsTabViewState createState() => _NewsTabViewState();
}

class _NewsTabViewState extends State<NewsTabView> {
  late Future<List<NewArticleModel>> futureArticles;

  @override
  void initState() {
    futureArticles = fetchNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('News & Reports'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'News'),
              Tab(text: 'Reports'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // First Tab: News Articles
            FutureBuilder<List<NewArticleModel>>(
              future: futureArticles,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Failed to load news: ${snapshot.error}'));
                } else {
                  final articles = snapshot.data!;
                  return ListView.builder(
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      final article = articles[index];
                      return NewsWidget(
                        article: article,
                      );
                    },
                  );
                }
              },
            ),
            // Second Tab: Firebase Reports
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('ReportIncidents').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Failed to load reports: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No reports found.'));
                } else {
                  final reports = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: reports.length,
                    itemBuilder: (context, index) {
                      final report = reports[index];
                      return ReportWidget(
                        city: report['IncidentCity'],
                        description: report['IncidentDescription'],
                        fullName: report['FullName'],
                        phoneNo: report['PhoneNo'],
                        time: report['IncidentDate'].toDate(),
                        type: report['TitleIncident'],
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
