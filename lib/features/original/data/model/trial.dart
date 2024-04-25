import 'dart:ffi';

import 'package:fitness_app/features/original/data/model/exercise.dart';
import 'package:fitness_app/features/original/domain/entity/trial.dart';
import 'package:floor/floor.dart';


@Entity(tableName: "trial", foreignKeys: [
  ForeignKey(childColumns: ['exercise_id'], parentColumns: ['id'], entity:ExerciseModel )
])
class TrialModel{
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'exercise_id')
  final int? exerciseId;
  final int? repeats;
  final double? weight;
  final int? restInMin;

  TrialModel({this.id, this.exerciseId,this.repeats, this.weight, this.restInMin});
  factory TrialModel.fromEntity(TrialEntity entity, int exerciseId){
    return TrialModel(
      id:entity.id,
      exerciseId: exerciseId,
      repeats: entity.repeats,
      weight: entity.weight,
      restInMin: entity.restInMin
    );
  }
}