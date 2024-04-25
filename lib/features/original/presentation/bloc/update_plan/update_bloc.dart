import 'package:fitness_app/core/resources/data_state.dart';
import 'package:fitness_app/features/original/presentation/bloc/update_plan/update_event.dart';
import 'package:fitness_app/features/original/presentation/bloc/update_plan/update_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecase/add_fitness_plan.dart';
import '../../../domain/usecase/delete_fitness_plan.dart';
import '../../../domain/usecase/update_fitness_plan.dart';

class UpdatePlanBloc extends Bloc<UpdateEvent, UpdateState> {
  final UpdateFitnessPlanUseCase updateFitnessPlanUseCase;
  final AddFitnessPlanUseCase addFitnessPlanUseCase;
  final DeleteFitnessPlanUseCase deleteFitnessPlanUseCase;

  UpdatePlanBloc(this.updateFitnessPlanUseCase, this.addFitnessPlanUseCase,
      this.deleteFitnessPlanUseCase)
      : super(const UpdateLoadingState()) {
    on<UpdateEntityEvent>(onUpdateEntity);
    on<AddEntityEvent>(onAddEntity);
    on<UpdatingFinishedEvent>(
        (event, emit) => emit(const UpdateLoadingState()));
    on<DeleteEntityEvent>(onDeleteEntity);
  }



  Future<void> onUpdateEntity(UpdateEntityEvent event, Emitter emitter) async {
    var result = await updateFitnessPlanUseCase.call(params: event.entity, id: event.parentId);
    if (result is DataSuccess) {
      emitter( const UpdateSuccessState("Изменения прошли успешно"));
    }
    if (result is DataError) {
      emitter(UpdateErrorState(result.error ?? "Unknown Error"));
    }
  }

  Future<void> onAddEntity(AddEntityEvent event, Emitter emitter) async {
    var result = await addFitnessPlanUseCase.call(
        params: event.entity, id: event.parentId);
    if (result is DataSuccess) {
      emitter(const UpdateSuccessState("Добавление прошло успешно"));
    }
    if (result is DataError) {
      emitter(UpdateErrorState(result.error ?? "Unknown Error"));
    }
  }

  Future<void> onDeleteEntity(DeleteEntityEvent event, Emitter emitter) async {
    var result = await deleteFitnessPlanUseCase.call(params: event.entity);
    if (result is DataSuccess) {
      emitter(const UpdateSuccessState("Удаление прошло успешно"));
    }
    if (result is DataError) {
      emitter(UpdateErrorState(result.error ?? "Unknown Error"));
    }
  }
}
