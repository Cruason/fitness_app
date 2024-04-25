import 'package:fitness_app/core/resources/data_state.dart';
import 'package:fitness_app/features/original/data/data_sources/local/app_database.dart';
import 'package:fitness_app/features/original/data/model/day_exercise.dart';
import 'package:fitness_app/features/original/data/model/exercise.dart';
import 'package:fitness_app/features/original/data/model/fitness_plan.dart';
import 'package:fitness_app/features/original/data/model/trial.dart';
import 'package:fitness_app/features/original/domain/entity/day_entity.dart';
import 'package:fitness_app/features/original/domain/entity/exercise.dart';
import 'package:fitness_app/features/original/domain/entity/fitness_plan_entity.dart';
import 'package:fitness_app/features/original/domain/entity/trial.dart';
import 'package:fitness_app/features/original/domain/repository/fitness_plan_repo.dart';

class FitnessPlanRepositoryImpl extends FitnessPlanRepository {
  final AppDataBase appDataBase;

  FitnessPlanRepositoryImpl(this.appDataBase);

  @override
  Future<DataState<void>> addFitnessEntity(
      dynamic entity, int? parentId) async {
    try {
      if (entity is FitnessPlanEntity) {
        addPlan(entity);
      }
      if (entity is DayExercisesEntity) {
        addDay(entity, parentId!);
      }
      if (entity is ExerciseEntity) {
        addExercise(entity, parentId!);
      }
      if (entity is TrialEntity) {
        addTrial(entity, parentId!);
      }
      return const DataSuccess(null);
    } catch (e) {
      return DataError(e.toString());
    }
  }

  Future<void> addTrial(TrialEntity trialEntity, int parentId) async {
    await appDataBase.trialDao
        .insertTrial(TrialModel.fromEntity(trialEntity, parentId));
  }

  Future<void> addExercise(ExerciseEntity exerciseEntity, int parentId) async {
    int exerciseId = await appDataBase.exerciseDao
        .insertExercise(ExerciseModel.fromEntity(exerciseEntity, parentId));
    var trials = exerciseEntity.trials!;
    for (var k = 0; k < trials.length; k++) {
      addTrial(trials[k], exerciseId);
    }
  }

  Future<void> addDay(
      DayExercisesEntity dayExercisesEntity, int parentId) async {
    await appDataBase.dayExerciseDao
        .insertDay(DayExerciseModel.fromEntity(dayExercisesEntity, parentId));
  }

  Future<void> addPlan(FitnessPlanEntity fitnessPlanEntity) async {
    await appDataBase.fitnessPlanDao
        .insertFitnessPlan(FitnessPlanModel.fromEntity(fitnessPlanEntity));
  }

  @override
  Future<DataState<void>> deleteFitnessEntity(dynamic entity) async {
    try {
      if (entity is TrialEntity) {
        await deleteTrial(entity);
      }
      if (entity is ExerciseEntity) {
        await deleteExercise(entity);
      }
      if (entity is DayExercisesEntity) {
        await deleteDay(entity);
      }
      if (entity is FitnessPlanEntity) {
        await deletePlan(entity);
      }
      return const DataSuccess(null);
    } catch (e) {
      return DataError(e.toString());
    }
  }

  @override
  Future<DataState<List<FitnessPlanEntity>>> getFitnessPlans() async {
    try {
      final fitnessPlansModel =
          await appDataBase.fitnessPlanDao.selectAllFitnessPlan();
      List<FitnessPlanEntity> fitnessPlanList =[];

      for(var i=0;i<fitnessPlansModel.length; i++) {
        final days = await getFitnessDays(fitnessPlansModel[i].id!);
        fitnessPlanList.add(FitnessPlanEntity.fromModel(fitnessPlansModel[i], days.data));
      }

      return DataSuccess(fitnessPlanList);
    } catch (e) {
      return DataError(e.toString());
    }
  }

  @override
  Future<DataState<List<FitnessPlanEntity>>> searchFitnessPlan(
      String name) async {
    try {
      final fitnessPlansModel =
          await appDataBase.fitnessPlanDao.searchFitnessPlan(name);
      final fitnessPlansEntity = List<FitnessPlanEntity>.from(
          fitnessPlansModel.map((e)async{
            final  days =  await getFitnessDays(e.id!);
            return FitnessPlanEntity.fromModel(e, days.data);
          }));
      return DataSuccess(fitnessPlansEntity);
    } catch (e) {
      return DataError(e.toString());
    }
  }

  @override
  Future<DataState<void>> updateFitnessEntity(
      dynamic entity, int? parentId) async {
    try {
      if (entity is TrialEntity) {
        await appDataBase.trialDao
            .updateTrial(TrialModel.fromEntity(entity, parentId!));
      }
      if (entity is ExerciseEntity) {
        await appDataBase.exerciseDao
            .updateExercise(ExerciseModel.fromEntity(entity, parentId!));
      }
      if (entity is DayExercisesEntity) {
        await appDataBase.dayExerciseDao
            .updateDay(DayExerciseModel.fromEntity(entity, parentId!));
      }
      if (entity is FitnessPlanEntity) {
        await appDataBase.fitnessPlanDao
            .updateFitnessPlan(FitnessPlanModel.fromEntity(entity));
      }

      return const DataSuccess(null);
    } catch (e) {
      return DataError(e.toString());
    }
  }

  Future<void> deletePlan(FitnessPlanEntity fitnessPlan) async {
    final days = await getFitnessDays(fitnessPlan.id!);
    for (var day in days.data!) {
      await deleteDay(day);
    }

    await appDataBase.fitnessPlanDao
        .deleteFitnessPlan(FitnessPlanModel.fromEntity(fitnessPlan));
  }

  Future<void> deleteDay(DayExercisesEntity day) async {
    final exercises = await getFitnessExercises(day.id!);
    for (var exercise in exercises.data!) {
      await deleteExercise(exercise);
    }
    await appDataBase.dayExerciseDao.deleteExerciseById(day.id!);
  }

  Future<void> deleteExercise(ExerciseEntity exercise) async {
    var trials = exercise.trials;
    for (var trial in trials!) {
      await deleteTrial(trial);
    }

    await appDataBase.exerciseDao.deleteExerciseById(exercise.id!);
  }

  Future<void> deleteTrial(TrialEntity trial) async {
    await appDataBase.trialDao.deleteTrialById(trial.id!);
  }

  @override
  Future<DataState<FitnessPlanEntity?>> getFitnessPlanById(int id) async {
    try {
      final fitnessPlanModel =
          await appDataBase.fitnessPlanDao.selectFitnessPlanById(id);
      if(fitnessPlanModel!= null){
        final days = await getFitnessDays(fitnessPlanModel.id!);
        final fitnessPlanEntity = FitnessPlanEntity.fromModel(fitnessPlanModel,days.data);
        return DataSuccess(fitnessPlanEntity);
      }
      return const DataSuccess(null);
    } catch (e) {
      return DataError(e.toString());
    }
  }

  @override
  Future<DataState<List<DayExercisesEntity>>> getFitnessDays(
      int parentId) async {
    try {
      final daysModel = await appDataBase.dayExerciseDao.selectAllDay(parentId);
      final daysEntity = List<DayExercisesEntity>.from(
          daysModel.map((e) => DayExercisesEntity.fromModel(e)));

      return DataSuccess(daysEntity);
    } catch (e) {
      return DataError(e.toString());
    }
  }

  @override
  Future<DataState<List<ExerciseEntity>>> getFitnessExercises(
      int parentId) async {
    try {
      final exercisesModel =
          await appDataBase.exerciseDao.selectAllExercise(parentId);
      List<ExerciseEntity> exercises = [];

      for (var exerciseModel in exercisesModel) {
        final exerciseId = exerciseModel.id;
        final trialsModel =
            await appDataBase.trialDao.selectAllTrials(exerciseId!);

        List<TrialEntity> trials = trialsModel
            .map(
              (e) => TrialEntity(
                id: e.id,
                weight: e.weight,
                repeats: e.repeats,
                restInMin: e.restInMin,
              ),
            )
            .toList();

        final exercise = ExerciseEntity(
          id: exerciseId,
          name: exerciseModel.name,
          trials: trials,
        );
        exercises.add(exercise);
      }
      return DataSuccess(exercises);
    } catch (e) {
      return DataError(e.toString());
    }
  }
}
