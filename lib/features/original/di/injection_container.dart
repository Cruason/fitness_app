import 'dart:io';

import 'package:fitness_app/features/original/data/data_sources/local/app_database.dart';
import 'package:fitness_app/features/original/data/repository/fitness_plan_repo_impl.dart';
import 'package:fitness_app/features/original/data/repository/news_repo_impl.dart';
import 'package:fitness_app/features/original/data/service/firebase_auth_service_impl.dart';
import 'package:fitness_app/features/original/domain/repository/fitness_plan_repo.dart';
import 'package:fitness_app/features/original/domain/repository/news_repo.dart';
import 'package:fitness_app/features/original/domain/service/firebase_auth_service.dart';
import 'package:fitness_app/features/original/domain/usecase/add_fitness_plan.dart';
import 'package:fitness_app/features/original/domain/usecase/delete_fitness_plan.dart';
import 'package:fitness_app/features/original/domain/usecase/get_all_exercises.dart';
import 'package:fitness_app/features/original/domain/usecase/get_all_fitness_plans.dart';
import 'package:fitness_app/features/original/domain/usecase/get_fitness_plan_by_id.dart';
import 'package:fitness_app/features/original/domain/usecase/search_fitness_plan.dart';
import 'package:fitness_app/features/original/domain/usecase/update_fitness_plan.dart';
import 'package:fitness_app/features/original/presentation/bloc/details/details_bloc.dart';
import 'package:fitness_app/features/original/presentation/bloc/edit_plan/edit_plan_bloc.dart';
import 'package:fitness_app/features/original/presentation/bloc/news/newsBloc.dart';
import 'package:fitness_app/features/original/presentation/bloc/plan_list//fitness_plan_bloc.dart';
import 'package:fitness_app/features/original/presentation/bloc/update_plan/update_bloc.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.instance;

Future<void> initializeDependencies() async {
  // final database =
  //     await $FloorAppDataBase.databaseBuilder('app_database.db').build();
  //
  // await database.close();
  // await File(database.database.database.path).delete();

  final newDatabase = await $FloorAppDataBase
      .databaseBuilder('app_database.db')
      .build();

  // newDatabase.database.delete("trial");
  // newDatabase.database.delete("exercise");
  // newDatabase.database.delete("day");
  // newDatabase.database.delete("fitness_plan");

  di.registerSingleton<AppDataBase>(newDatabase);

  di.registerSingleton<FitnessPlanRepository>(FitnessPlanRepositoryImpl(di()));
  di.registerSingleton<NewsRepository>(NewsRepositoryImpl());


  di.registerSingleton<AddFitnessPlanUseCase>(AddFitnessPlanUseCase(di()));
  di.registerSingleton<DeleteFitnessPlanUseCase>(DeleteFitnessPlanUseCase(di()));
  di.registerSingleton<GetAllFitnessPlansUseCase>(GetAllFitnessPlansUseCase(di()));
  di.registerSingleton<UpdateFitnessPlanUseCase>(UpdateFitnessPlanUseCase(di()));
  di.registerSingleton<SearchFitnessPlanUseCase>(SearchFitnessPlanUseCase(di()));
  di.registerSingleton<GetFitnessPlanByIdUseCase>(GetFitnessPlanByIdUseCase(di()));
  di.registerSingleton<GetAllExercisesUseCase>(GetAllExercisesUseCase(di()));
  di.registerSingleton<FirebaseAuthService>(FirebaseAuthServiceImpl());


  di.registerFactory<FitnessPlanBloc>(() => FitnessPlanBloc(di(),di(),di(), di()));
  di.registerFactory<DetailsBloc>(() => DetailsBloc(di(), di()));
  di.registerFactory<EditPlanBloc>(() =>EditPlanBloc());
  di.registerFactory<UpdatePlanBloc>(() => UpdatePlanBloc(di(), di(), di()));
  di.registerFactory<NewsBloc>(() => NewsBloc(di()));
}
