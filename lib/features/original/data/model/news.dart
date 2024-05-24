import 'package:equatable/equatable.dart';

class NewsModel extends Equatable {
  final String title;
  final String description;
  final String urlToImage;
  final String url;

  const NewsModel({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.url,
  });

  @override
  List<Object?> get props => [title, description, urlToImage, url];

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title']??"",
      description: json['description']??"",
      urlToImage: json['urlToImage']??"",
      url: json['url']??"",
    );
  }
}
