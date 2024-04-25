import 'package:equatable/equatable.dart';

abstract class UpdateEvent extends Equatable{
  const UpdateEvent();
}



class UpdateEntityEvent extends UpdateEvent{
  final dynamic entity;
  final int? parentId;
  const UpdateEntityEvent({required this.entity, this.parentId});


  @override
  List<Object?> get props => [
    entity,

  ];
}
class UpdatingFinishedEvent extends UpdateEvent{
  const UpdatingFinishedEvent();

  @override
  List<Object?> get props => [];
}

class DeleteEntityEvent extends UpdateEvent{
  final dynamic entity;

  const DeleteEntityEvent({required this.entity,});

  @override
  // TODO: implement props
  List<Object?> get props => [
    entity,
  ];
}

class AddEntityEvent extends UpdateEvent{
  final dynamic entity;
  final int? parentId;
  const AddEntityEvent({required this.entity, this.parentId});


  @override
  List<Object?> get props => [
    entity,

  ];
}
