import 'dart:ffi';

import 'package:equatable/equatable.dart';

class TrialEntity extends Equatable{
  final int? id;
  final int? repeats;
  final double? weight;
  final int? restInMin;

  const TrialEntity({this.id, this.repeats, this.weight, this.restInMin});

  @override
  List<Object?> get props => [
    id,
    repeats,
    weight,
    restInMin
  ];

  TrialEntity copyWith(
      {int? id, int? repeats, double? weight, int? restInMin}){
    return TrialEntity(
      id: id?? this.id,
      repeats: repeats?? this.repeats,
      restInMin: restInMin?? this.restInMin,
      weight: weight?? this.weight
    );
  }
}