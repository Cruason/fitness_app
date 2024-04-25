import 'package:equatable/equatable.dart';
import 'package:fitness_app/features/original/domain/entity/fitness_plan_entity.dart';

abstract class FitnessPlanState extends Equatable {
  final dynamic entity;
  final String? message;

  const FitnessPlanState({this.entity, this.message});

  @override
  List<Object> get props => [entity ?? List.empty(), message ?? ""];
}

class FitnessPlanLoadingState extends FitnessPlanState {
  const FitnessPlanLoadingState();
}

class FitnessPlanSuccessState extends FitnessPlanState {
  const FitnessPlanSuccessState(dynamic entity)
      : super(entity: entity);
}

class FitnessPlanErrorState extends FitnessPlanState {
  const FitnessPlanErrorState(String? error) : super(message: error);
}

class FitnessPlanCompletedState extends FitnessPlanState {
  final FitnessPlanEntity fitnessPlanEntity;
  const FitnessPlanCompletedState(this.fitnessPlanEntity, String? message): super(message: message);
}
