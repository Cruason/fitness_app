
import 'package:fitness_app/features/original/data/model/trial.dart';
import 'package:floor/floor.dart';

@dao
abstract class TrialDao{
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertTrial(TrialModel trialModel);


  @Query('DELETE FROM trial WHERE id = :id')
  Future<void> deleteTrialById(int id);

  @Query('SELECT * FROM trial WHERE exercise_id =:exerciseId')
  Future<List<TrialModel>> selectAllTrials(int exerciseId);

  @update
  Future<int> updateTrial(TrialModel trialModel);

}