import 'package:fitness_app/core/resources/data_state.dart';
import 'package:fitness_app/features/original/domain/entity/day_entity.dart';
import 'package:fitness_app/features/original/presentation/bloc/details/details_event.dart';
import 'package:fitness_app/features/original/presentation/bloc/details/details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecase/get_all_exercises.dart';
import '../../../domain/usecase/get_fitness_plan_by_id.dart';

class DetailsBloc extends Bloc<DetailsEvent, PlanDetailsState> {
  final GetFitnessPlanByIdUseCase getFitnessPlanById;
  final GetAllExercisesUseCase getAllExercisesUseCase;
  late int? planId;
  late DayExercisesEntity? selectedDay;

  DetailsBloc(this.getFitnessPlanById, this.getAllExercisesUseCase) : super(const PlanDetailsEmptyState()) {
    on<GetPlanDetailsEvent>(onPlanLoading);
    on<GetExercisesDetailsEvent>(onExercisesLoading);
  }


  Future<void> onPlanLoading(GetPlanDetailsEvent event, Emitter emitter) async {
    emitter(const PlanDetailsLoadingState());
    print(event.id);
    var result = await getFitnessPlanById.call(params: event.id);
    if (result is DataSuccess) {
      if (result.data == null) {
        emitter(const PlanDetailsEmptyState());
      } else {
        emitter(PlanDetailsSuccessState(result.data!));
      }
    }
    if (result is DataError) {
      emitter(PlanDetailsErrorState(result.error));
    }
  }

  Future<void> onExercisesLoading(GetExercisesDetailsEvent event, Emitter emitter) async {
    emitter(const PlanDetailsLoadingState());
    var result = await getAllExercisesUseCase.call(params: event.id);
    if (result is DataSuccess) {
      if (result.data == null) {
        emitter(const PlanDetailsEmptyState());
      } else {
        emitter(PlanDetailsSuccessState(result.data!));
      }
    }
    if (result is DataError) {
      emitter(PlanDetailsErrorState(result.error));
    }
  }
}
