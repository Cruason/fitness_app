import 'package:equatable/equatable.dart';

abstract class FitnessPlanEvent extends Equatable{
  final dynamic entity;
  const FitnessPlanEvent({this.entity});

  @override
  List<Object> get props =>[
    entity
  ];
}

class GetFitnessPlanEvent extends FitnessPlanEvent{
  const GetFitnessPlanEvent();
}



class SearchFitnessPlanEvent extends FitnessPlanEvent{
  const SearchFitnessPlanEvent(String name): super(entity: name);
}

class DeleteFitnessPlanEvent extends FitnessPlanEvent{
  const DeleteFitnessPlanEvent(dynamic entity): super(entity:entity);
}

class AddFitnessPlanEvent extends FitnessPlanEvent{
  const AddFitnessPlanEvent (dynamic fitnessPlanEntity): super(entity: fitnessPlanEntity);
}

