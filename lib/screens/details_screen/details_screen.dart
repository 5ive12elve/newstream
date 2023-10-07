import 'package:flutter/material.dart';
import '../../model/news_model.dart';

class DetailsScreen extends StatelessWidget {
  final Articles article;

  const DetailsScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 66, 0, 3),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 127, 0, 0),
        title: Text(
            article.title ?? 'Article Details',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (article.urlToImage != null && article.urlToImage!.isNotEmpty)
              Image.network(article.urlToImage!),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Source: ${article.source?.name ?? 'Unknown'}',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Published At: ${article.publishedAt ?? 'N/A'}',
                style: TextStyle(
                  fontSize: 22.0,
                    fontWeight: FontWeight.w300,
                    color: Colors.white
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Author: ${article.author ?? 'Unknown'}',
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.orangeAccent
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${article.description ?? 'N/A'}',
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w300,
                    color: Colors.orangeAccent
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
