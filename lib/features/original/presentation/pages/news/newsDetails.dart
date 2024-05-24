import 'package:flutter/material.dart';
import 'package:fitness_app/features/original/domain/entity/newsEntity.dart';

class NewsDetailPage extends StatelessWidget {
  final NewsEntity article;

  const NewsDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          article.title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          article.urlToImage.isNotEmpty
              ? Image.network(article.urlToImage)
              : Container(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              article.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Read more at: ${article.url}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
