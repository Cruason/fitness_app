import 'package:equatable/equatable.dart';
import 'package:fitness_app/features/original/data/model/day_exercise.dart';

import '../../../../core/constants/constants.dart';

class DayExercisesEntity extends Equatable{
  final int? id;
  final String? dayName;
  final String? name;

  const DayExercisesEntity( {this.id, this.name, this.dayName,});

  @override
  List<Object?> get props => [
    id,
    dayName,
    name,
  ];

  DayExercisesEntity copyWith({int? id,String? dayName,String? name,}){
    return DayExercisesEntity(
        id: id??this.id,
        name: name??this.name,
        dayName: dayName??this.dayName,
    );
  }

  factory DayExercisesEntity.fromModel(DayExerciseModel dayExerciseModel){
    return DayExercisesEntity(
      id:  dayExerciseModel.id,
      name: dayExerciseModel.name,
      dayName: dayExerciseModel.dayName
    );
  }
}