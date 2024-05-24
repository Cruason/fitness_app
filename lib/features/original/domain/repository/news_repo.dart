import 'package:fitness_app/core/resources/data_state.dart';
import 'package:fitness_app/features/original/domain/entity/newsEntity.dart';

abstract class NewsRepository {

  Future<DataState<List<NewsEntity>>> getNews();
}
