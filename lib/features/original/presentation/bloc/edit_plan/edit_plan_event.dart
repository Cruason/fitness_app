import 'package:equatable/equatable.dart';

abstract class EditEntityEvent extends Equatable {
  final dynamic entity;

  const EditEntityEvent(
      {this.entity});

  @override
  List<Object> get props => [
        entity
      ];
}

class EditStartedEvent extends EditEntityEvent {
  const EditStartedEvent();
}

class EditFinishedEvent extends EditEntityEvent{
  const EditFinishedEvent(dynamic entity) : super(entity: entity);
}

class EditEmptyPlanEvent extends EditEntityEvent {
  const EditEmptyPlanEvent();
}
