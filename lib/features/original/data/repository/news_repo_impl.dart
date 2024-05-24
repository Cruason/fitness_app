import 'dart:convert';
import 'package:fitness_app/core/resources/data_state.dart';
import 'package:fitness_app/features/original/data/model/news.dart';
import 'package:fitness_app/features/original/domain/entity/newsEntity.dart';
import 'package:http/http.dart' as http;
import '../../domain/repository/news_repo.dart';

class NewsRepositoryImpl extends NewsRepository {
  final String apiKey = 'a5c5062dd0fa4a978dea30ca4cb53fce';
  final String baseUrl = 'https://newsapi.org/v2';

  @override
  Future<DataState<List<NewsEntity>>> getNews() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/top-headlines?country=us&category=sports&apiKey=$apiKey'));

      final json = jsonDecode(response.body);
      final List articles = json['articles'];
      final newsModel =
          articles.map((article) => NewsModel.fromJson(article));
      final news = List<NewsEntity>.from(
          newsModel.map((model) => NewsEntity.fromModel(model)));
      return DataSuccess(news);
    } catch (e) {
      return DataError(e.toString());
    }
  }
}
