import 'package:fitness_app/features/original/data/model/fitness_plan.dart';
import 'package:floor/floor.dart';

import '../../../../core/constants/constants.dart';
import '../../domain/entity/day_entity.dart';

@Entity(tableName: 'day', foreignKeys: [
  ForeignKey(
      childColumns: ['fitness_plan_id'],
      parentColumns: ['id'],
      entity: FitnessPlanModel)
],)
class DayExerciseModel {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'fitness_plan_id')
  final int? fitnessPlanId;

  @ColumnInfo(name: 'day_name')
  final String? dayName;

  final String? name;

  DayExerciseModel({this.id, this.fitnessPlanId, this.dayName, this.name});

  factory DayExerciseModel.fromEntity(DayExercisesEntity entity,int fitnessPlanId) {
    return DayExerciseModel(
      id: entity.id,
      fitnessPlanId: fitnessPlanId,
      dayName: entity.dayName,
      name: entity.name,
    );
  }
}
