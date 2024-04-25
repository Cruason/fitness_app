import 'package:equatable/equatable.dart';


abstract class EditPlanState extends Equatable {
  final dynamic entity;
  final String? error;

  const EditPlanState(
      {this.entity,this.error});

  @override
  List<Object> get props =>
      [
        entity,
        error??""
      ];
}


class EditingState extends EditPlanState {
  const EditingState();
}

class EditingCompletedState extends EditPlanState {
  const EditingCompletedState(dynamic entity)
      :super(entity: entity);
}


class EditingErrorState extends EditPlanState{
  const EditingErrorState(String error) : super (error: error);
}