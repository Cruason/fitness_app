import 'package:equatable/equatable.dart';
import 'package:fitness_app/features/original/data/model/news.dart';

class NewsEntity extends Equatable {
  final String title;
  final String description;
  final String urlToImage;
  final String url;

  const NewsEntity({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.url,
  });

  @override
  List<Object?> get props => [title, description, urlToImage, url];

  factory NewsEntity.fromModel(NewsModel newsModel) {
    return NewsEntity(
      title: newsModel.title,
      description: newsModel.description,
      urlToImage: newsModel.urlToImage,
      url: newsModel.url,
    );
  }
}
