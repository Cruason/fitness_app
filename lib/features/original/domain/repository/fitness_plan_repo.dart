import 'package:fitness_app/features/original/domain/entity/day_entity.dart';
import 'package:fitness_app/features/original/domain/entity/exercise.dart';

import '../../../../core/resources/data_state.dart';
import '../entity/fitness_plan_entity.dart';

abstract class FitnessPlanRepository {
  Future<DataState<void>> addFitnessEntity(dynamic entity, int? parentId);

  Future<DataState<List<FitnessPlanEntity>>> getFitnessPlans();
  Future<DataState<List<DayExercisesEntity>>> getFitnessDays(int parentId);
  Future<DataState<List<ExerciseEntity>>> getFitnessExercises(int parentId);

  Future<DataState<List<FitnessPlanEntity>>> searchFitnessPlan(String name);

  Future<DataState<void>> updateFitnessEntity(dynamic entity, int? parentId);

  Future<DataState<void>> deleteFitnessEntity(dynamic entity);

  Future<DataState<FitnessPlanEntity?>> getFitnessPlanById(int id);
}