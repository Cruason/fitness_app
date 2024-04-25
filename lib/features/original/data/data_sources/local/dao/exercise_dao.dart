
import 'package:fitness_app/features/original/data/model/exercise.dart';
import 'package:floor/floor.dart';

@dao
abstract class ExerciseDao{
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertExercise(ExerciseModel exerciseModel);

  @Query('DELETE FROM exercise WHERE id = :id')
  Future<void> deleteExerciseById(int id);

  @Query('SELECT * FROM exercise WHERE day_id = :dayId')
  Future<List<ExerciseModel>> selectAllExercise(int dayId);

  @update
  Future<int> updateExercise(ExerciseModel exerciseModel);
}