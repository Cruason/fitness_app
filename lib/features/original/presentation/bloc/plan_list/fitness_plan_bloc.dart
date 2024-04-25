import 'package:fitness_app/core/resources/data_state.dart';
import 'package:fitness_app/features/original/domain/usecase/add_fitness_plan.dart';
import 'package:fitness_app/features/original/domain/usecase/get_all_fitness_plans.dart';
import 'package:fitness_app/features/original/presentation/bloc/plan_list//fitness_plan_event.dart';
import 'package:fitness_app/features/original/presentation/bloc/plan_list//fitness_plan_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fitness_app/features/original/domain/usecase/delete_fitness_plan.dart';
import 'package:fitness_app/features/original/domain/usecase/search_fitness_plan.dart';


class FitnessPlanBloc extends Bloc<FitnessPlanEvent, FitnessPlanState> {
  final GetAllFitnessPlansUseCase getAllFitnessPlansUseCase;
  final DeleteFitnessPlanUseCase deleteFitnessPlanUseCase;
  final SearchFitnessPlanUseCase searchFitnessPlanUseCase;
  final AddFitnessPlanUseCase addFitnessPlanUseCase;

  FitnessPlanBloc(this.getAllFitnessPlansUseCase,
      this.deleteFitnessPlanUseCase, this.searchFitnessPlanUseCase, this.addFitnessPlanUseCase)
      : super(const FitnessPlanLoadingState()) {

    on<GetFitnessPlanEvent>(onLoadFitnessPlans);
    on<DeleteFitnessPlanEvent>(onDeleteFitnessPlan);
    on<AddFitnessPlanEvent>(onAddFitnessPlan);
  }



  Future<void> onLoadFitnessPlans(
      GetFitnessPlanEvent event, Emitter emitter) async {
    emitter(const FitnessPlanLoadingState());
    var result = await getAllFitnessPlansUseCase.call();
    if (result is DataSuccess) {
      print(result.data);
      emitter(FitnessPlanSuccessState(result.data));
    }
    if (result is DataError) {
      emitter(FitnessPlanErrorState(result.error));
    }
  }

  Future<void> onDeleteFitnessPlan(
      DeleteFitnessPlanEvent event, Emitter emitter) async {
    emitter(const FitnessPlanLoadingState());
    var result = await deleteFitnessPlanUseCase.call(params: event.entity);
    if(result is DataSuccess){
      emitter(FitnessPlanCompletedState(event.entity, "${event.entity.name} удален"));
    }
    if(result is DataError){
      emitter(FitnessPlanErrorState(result.error));
    }
  }


  Future<void> onAddFitnessPlan(AddFitnessPlanEvent event, Emitter emitter)async{
    emitter(const FitnessPlanLoadingState());
    final result = await addFitnessPlanUseCase.call(params: event.entity);
    if(result is DataSuccess){
      add(const GetFitnessPlanEvent());
    }
    if(result is DataError){
      emitter(FitnessPlanErrorState(result.error));
    }
  }
  Future<void> onSearchFitnessPlan(
      SearchFitnessPlanEvent event, Emitter emitter) async {
    emitter(const FitnessPlanLoadingState());
    var result = await searchFitnessPlanUseCase.call(params: event.entity);
    if(result is DataSuccess){
      emitter(FitnessPlanSuccessState(result.data));
    }
    if(result is DataError){
      emitter(FitnessPlanErrorState(result.error));
    }
  }

}
