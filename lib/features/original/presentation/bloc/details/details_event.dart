import 'package:equatable/equatable.dart';

abstract class DetailsEvent extends Equatable{
  const DetailsEvent();
}

class GetPlanDetailsEvent extends DetailsEvent{
  final int id;

  const GetPlanDetailsEvent({required this.id});

  @override
  List<Object?> get props =>[
    id
  ];

}


class GetExercisesDetailsEvent extends DetailsEvent{
  final int id;

  const GetExercisesDetailsEvent({required this.id});

  @override
  List<Object?> get props =>[
    id
  ];

}


