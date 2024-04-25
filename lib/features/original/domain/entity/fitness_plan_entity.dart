import 'package:equatable/equatable.dart';
import 'package:fitness_app/features/original/data/model/fitness_plan.dart';
import 'package:fitness_app/features/original/domain/entity/day_entity.dart';

class FitnessPlanEntity extends Equatable {
  final int? id;
  final String? name;
  final List<DayExercisesEntity>? days;

  const FitnessPlanEntity({this.id, this.name, this.days, });

  @override
  List<Object?> get props => [
    id,
    name,
  ];

  FitnessPlanEntity copyWith({int? id,String? name, String? dayNames, List<DayExercisesEntity>? days}){
    return FitnessPlanEntity(
        id: id??this.id,
        name: name??this.name,
        days: days??this.days
    );
  }

  factory FitnessPlanEntity.fromModel(FitnessPlanModel? fitnessPlanModel, List<DayExercisesEntity>? days){
    return FitnessPlanEntity(
      id: fitnessPlanModel?.id,
      name: fitnessPlanModel?.name,
      days: days
    );
  }
}