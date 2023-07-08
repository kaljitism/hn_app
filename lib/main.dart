import 'package:flutter/material.dart';
import 'package:hn_app/src/article.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const HNApp());
}

class HNApp extends StatelessWidget {
  const HNApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hacker News',
      theme: ThemeData(useMaterial3: true),
      home: const HNHomePage(),
    );
  }
}

class HNHomePage extends StatefulWidget {
  const HNHomePage({super.key});

  @override
  State<HNHomePage> createState() => _HNHomePageState();
}

class _HNHomePageState extends State<HNHomePage> {
  final List<Article> _articles = articles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hacker News'),
        backgroundColor: const Color(0xffBE6466),
      ),
      body: ListView(
        children: _articles.map(_buildItem).toList(),
      ),
    );
  }

  Widget _buildItem(Article article) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListTile(
        title: Text(article.text, style: const TextStyle(fontSize: 20)),
        subtitle: Row(
          children: [
            const Icon(Icons.insert_comment, size: 16),
            Text("  ${article.commentsCount} comments"),
          ],
        ),
        onTap: () async {
          final fakeUrl = Uri.parse("https://${article.domain}");
          if (await canLaunchUrl(fakeUrl)) {
            launchUrl(fakeUrl);
            print("launching $fakeUrl");
          } else {
            print("Could not launch $fakeUrl");
          }
        },
      ),
    );
  }
}
