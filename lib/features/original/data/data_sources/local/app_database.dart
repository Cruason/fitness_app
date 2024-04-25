import 'dart:async';

import 'package:fitness_app/features/original/data/data_sources/local/dao/day_dao.dart';
import 'package:fitness_app/features/original/data/data_sources/local/dao/exercise_dao.dart';
import 'package:fitness_app/features/original/data/data_sources/local/dao/fitness_plan_dao.dart';
import 'package:fitness_app/features/original/data/data_sources/local/dao/trial_dao.dart';
import 'package:fitness_app/features/original/data/model/day_exercise.dart';
import 'package:fitness_app/features/original/data/model/exercise.dart';
import 'package:fitness_app/features/original/data/model/fitness_plan.dart';
import 'package:fitness_app/features/original/data/model/trial.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../../../../core/constants/constants.dart';
part 'app_database.g.dart';

@Database(version: 1, entities: [FitnessPlanModel, DayExerciseModel, ExerciseModel, TrialModel])
abstract class AppDataBase extends FloorDatabase{
  FitnessPlanDao get fitnessPlanDao;
  DayExerciseDao get dayExerciseDao;
  ExerciseDao get exerciseDao;
  TrialDao get trialDao;
}
