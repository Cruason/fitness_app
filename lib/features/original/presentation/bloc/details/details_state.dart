
import 'package:equatable/equatable.dart';


abstract class PlanDetailsState extends Equatable {
  final dynamic entity;
  final String? error;

  const PlanDetailsState({this.entity, this.error});

  @override
  List<Object> get props => [entity, error ?? ""];
}

class PlanDetailsLoadingState extends PlanDetailsState {
  const PlanDetailsLoadingState();
}


class PlanDetailsSuccessState extends PlanDetailsState {
  const PlanDetailsSuccessState(dynamic entity)
      : super(entity: entity);
}

class PlanDetailsEmptyState extends PlanDetailsState {
  const PlanDetailsEmptyState();
}

class PlanDetailsDeletedState extends PlanDetailsState{
  const PlanDetailsDeletedState(): super ();
}


class PlanDetailsErrorState extends PlanDetailsState{
  const PlanDetailsErrorState(String? error) : super (error: error);
}
