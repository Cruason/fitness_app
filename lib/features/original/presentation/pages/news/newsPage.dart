import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/news/newsBloc.dart';
import '../../bloc/news/newsState.dart';
import '../../bloc/news/newsEvent.dart';
import 'newsDetails.dart';

class NewsPage extends StatelessWidget {
  final NewsBloc newsBloc;

  const NewsPage({super.key, required this.newsBloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: newsBloc..add(GetNews()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Sports News',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsInitial) {
              return Center(child: Text('Please wait...'));
            } else if (state is NewsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is NewsLoaded) {
              return ListView.builder(
                itemCount: state.news.length,
                itemBuilder: (context, index) {
                  final article = state.news[index];
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          article.title,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        subtitle: Text(
                          article.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        leading: article.urlToImage.isNotEmpty
                            ? Image.network(
                          article.urlToImage,
                          width: 100,
                          fit: BoxFit.cover,
                        )
                            : null,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsDetailPage(article: article),
                            ),
                          );
                        },
                      ),
                      Divider(
                        color: Theme.of(context).colorScheme.secondary,
                        thickness: 1,
                      ),
                    ],
                  );
                },
              );
            } else if (state is NewsError) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
