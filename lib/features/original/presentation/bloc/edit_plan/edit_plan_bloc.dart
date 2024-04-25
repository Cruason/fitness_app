import 'package:fitness_app/features/original/presentation/bloc/edit_plan/edit_plan_event.dart';
import 'package:fitness_app/features/original/presentation/bloc/edit_plan/edit_plan_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entity/fitness_plan_entity.dart';

class EditPlanBloc extends Bloc<EditEntityEvent, EditPlanState> {

  EditPlanBloc() : super(const EditingState()) {
    on<EditEmptyPlanEvent>(buildEmptyPlan);
    on<EditStartedEvent>(onEditStarted);
    on<EditFinishedEvent>((event, emit) => emit(EditingCompletedState(event.entity)));
  }

  void onEditStarted(EditStartedEvent event, Emitter emitter) {
    emitter(const EditingState());
  }

  Future<void> buildEmptyPlan(EditEmptyPlanEvent event, Emitter emitter) async{
    emitter(const EditingState());
    const fitnessPlanEntity =  FitnessPlanEntity();
    emitter(const EditingCompletedState(fitnessPlanEntity));
  }
}
