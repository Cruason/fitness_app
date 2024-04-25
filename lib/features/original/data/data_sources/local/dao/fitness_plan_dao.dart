
import 'package:fitness_app/features/original/data/model/fitness_plan.dart';
import 'package:floor/floor.dart';

@dao
abstract class FitnessPlanDao{
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertFitnessPlan(FitnessPlanModel fitnessPlanModel);

  @delete
  Future<void> deleteFitnessPlan(FitnessPlanModel fitnessPlanModel);

  @Query('SELECT * FROM fitness_plan')
  Future<List<FitnessPlanModel>> selectAllFitnessPlan();

  @Query('SELECT * FROM fitness_plan WHERE name LIKE %:name%')
  Future<List<FitnessPlanModel>> searchFitnessPlan(String name);
  
  @Query('SELECT * FROM fitness_plan WHERE id = :id')
  Future<FitnessPlanModel?> selectFitnessPlanById(int id);

  @update
  Future<int> updateFitnessPlan(FitnessPlanModel fitnessPlanModel);
}