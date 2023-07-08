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
      body: Builder(builder: (context) {
        return RefreshIndicator(
          onRefresh: () async {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Refreshing...')),
            );
          },
          child: ListView(
            children: _articles.map(_buildItem).toList(),
          ),
        );
      }),
    );
  }

  Widget _buildItem(Article article) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ExpansionTile(
        title: Text(article.text, style: const TextStyle(fontSize: 20)),
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.insert_comment, size: 16),
                    Text("  ${article.commentsCount} comments"),
                  ],
                ),
                MaterialButton(
                  onPressed: () {
                    launchUrl(Uri.parse('http://${article.domain}'));
                  },
                  color: const Color(0xffBE6466).withOpacity(0.9),
                  textColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Text('Open Blog  '),
                      Icon(Icons.open_in_new, size: 16),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
