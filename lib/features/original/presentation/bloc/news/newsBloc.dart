import 'package:bloc/bloc.dart';
import 'package:fitness_app/features/original/presentation/bloc/news/newsEvent.dart';
import 'package:fitness_app/features/original/presentation/bloc/news/newsState.dart';

import '../../../domain/repository/news_repo.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;

  NewsBloc(this.newsRepository) : super(NewsInitial()) {
    on<GetNews>((event, emit) async {
      emit(NewsLoading());
      try {
        final news = await newsRepository.getNews();
        if(news.data != null){
          emit(NewsLoaded(news.data!));
        }else{
          emit(NewsError("empty"));
        }
      } catch (e) {
        emit(NewsError(e.toString()));
      }
    });
  }
}
