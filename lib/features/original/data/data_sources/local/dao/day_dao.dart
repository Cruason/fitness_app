
import 'package:fitness_app/features/original/data/model/day_exercise.dart';
import 'package:floor/floor.dart';

@dao
abstract class DayExerciseDao{
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertDay(DayExerciseModel dayExerciseModel);

  @Query('DELETE FROM day WHERE id = :id')
  Future<void> deleteExerciseById(int id);

  @Query('SELECT * FROM day WHERE fitness_plan_id = :planId')
  Future<List<DayExerciseModel>> selectAllDay(int planId);

  @update
  Future<int> updateDay(DayExerciseModel dayExerciseModel);


}