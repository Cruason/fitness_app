import 'package:fitness_app/features/original/data/model/day_exercise.dart';
import 'package:fitness_app/features/original/data/model/trial.dart';
import 'package:fitness_app/features/original/domain/entity/exercise.dart';
import 'package:floor/floor.dart';


@Entity(tableName: 'exercise', foreignKeys: [
  ForeignKey(childColumns: ['day_id'], parentColumns: ['id'], entity: DayExerciseModel)
])
class ExerciseModel {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'day_id')
  final int? dayId;

  final String? name;

  ExerciseModel({this.id, this.dayId, this.name});

  factory ExerciseModel.fromEntity(ExerciseEntity entity, int dayId){
    return ExerciseModel(
      id: entity.id,
      dayId: dayId,
      name: entity.name,
    );
  }
}