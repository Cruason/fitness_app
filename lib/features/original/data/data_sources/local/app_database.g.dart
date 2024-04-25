// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDataBase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDataBaseBuilder databaseBuilder(String name) =>
      _$AppDataBaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDataBaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDataBaseBuilder(null);
}

class _$AppDataBaseBuilder {
  _$AppDataBaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDataBaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDataBaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDataBase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDataBase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDataBase extends AppDataBase {
  _$AppDataBase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  FitnessPlanDao? _fitnessPlanDaoInstance;

  DayExerciseDao? _dayExerciseDaoInstance;

  ExerciseDao? _exerciseDaoInstance;

  TrialDao? _trialDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `fitness_plan` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `day` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `fitness_plan_id` INTEGER, `day_name` TEXT, `name` TEXT, FOREIGN KEY (`fitness_plan_id`) REFERENCES `fitness_plan` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `exercise` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `day_id` INTEGER, `name` TEXT, FOREIGN KEY (`day_id`) REFERENCES `day` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `trial` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `exercise_id` INTEGER, `repeats` INTEGER, `weight` REAL, `restInMin` INTEGER, FOREIGN KEY (`exercise_id`) REFERENCES `exercise` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FitnessPlanDao get fitnessPlanDao {
    return _fitnessPlanDaoInstance ??=
        _$FitnessPlanDao(database, changeListener);
  }

  @override
  DayExerciseDao get dayExerciseDao {
    return _dayExerciseDaoInstance ??=
        _$DayExerciseDao(database, changeListener);
  }

  @override
  ExerciseDao get exerciseDao {
    return _exerciseDaoInstance ??= _$ExerciseDao(database, changeListener);
  }

  @override
  TrialDao get trialDao {
    return _trialDaoInstance ??= _$TrialDao(database, changeListener);
  }
}

class _$FitnessPlanDao extends FitnessPlanDao {
  _$FitnessPlanDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _fitnessPlanModelInsertionAdapter = InsertionAdapter(
            database,
            'fitness_plan',
            (FitnessPlanModel item) =>
                <String, Object?>{'id': item.id, 'name': item.name}),
        _fitnessPlanModelUpdateAdapter = UpdateAdapter(
            database,
            'fitness_plan',
            ['id'],
            (FitnessPlanModel item) =>
                <String, Object?>{'id': item.id, 'name': item.name}),
        _fitnessPlanModelDeletionAdapter = DeletionAdapter(
            database,
            'fitness_plan',
            ['id'],
            (FitnessPlanModel item) =>
                <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FitnessPlanModel> _fitnessPlanModelInsertionAdapter;

  final UpdateAdapter<FitnessPlanModel> _fitnessPlanModelUpdateAdapter;

  final DeletionAdapter<FitnessPlanModel> _fitnessPlanModelDeletionAdapter;

  @override
  Future<List<FitnessPlanModel>> selectAllFitnessPlan() async {
    return _queryAdapter.queryList('SELECT * FROM fitness_plan',
        mapper: (Map<String, Object?> row) => FitnessPlanModel(
            id: row['id'] as int?, name: row['name'] as String?));
  }

  @override
  Future<List<FitnessPlanModel>> searchFitnessPlan(String name) async {
    return _queryAdapter.queryList(
        'SELECT * FROM fitness_plan WHERE name LIKE %?1%',
        mapper: (Map<String, Object?> row) => FitnessPlanModel(
            id: row['id'] as int?, name: row['name'] as String?),
        arguments: [name]);
  }

  @override
  Future<FitnessPlanModel?> selectFitnessPlanById(int id) async {
    return _queryAdapter.query('SELECT * FROM fitness_plan WHERE id = ?1',
        mapper: (Map<String, Object?> row) => FitnessPlanModel(
            id: row['id'] as int?, name: row['name'] as String?),
        arguments: [id]);
  }

  @override
  Future<int> insertFitnessPlan(FitnessPlanModel fitnessPlanModel) {
    return _fitnessPlanModelInsertionAdapter.insertAndReturnId(
        fitnessPlanModel, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateFitnessPlan(FitnessPlanModel fitnessPlanModel) {
    return _fitnessPlanModelUpdateAdapter.updateAndReturnChangedRows(
        fitnessPlanModel, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteFitnessPlan(FitnessPlanModel fitnessPlanModel) async {
    await _fitnessPlanModelDeletionAdapter.delete(fitnessPlanModel);
  }
}

class _$DayExerciseDao extends DayExerciseDao {
  _$DayExerciseDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _dayExerciseModelInsertionAdapter = InsertionAdapter(
            database,
            'day',
            (DayExerciseModel item) => <String, Object?>{
                  'id': item.id,
                  'fitness_plan_id': item.fitnessPlanId,
                  'day_name': item.dayName,
                  'name': item.name
                }),
        _dayExerciseModelUpdateAdapter = UpdateAdapter(
            database,
            'day',
            ['id'],
            (DayExerciseModel item) => <String, Object?>{
                  'id': item.id,
                  'fitness_plan_id': item.fitnessPlanId,
                  'day_name': item.dayName,
                  'name': item.name
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<DayExerciseModel> _dayExerciseModelInsertionAdapter;

  final UpdateAdapter<DayExerciseModel> _dayExerciseModelUpdateAdapter;

  @override
  Future<void> deleteExerciseById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM day WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<List<DayExerciseModel>> selectAllDay(int planId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM day WHERE fitness_plan_id = ?1',
        mapper: (Map<String, Object?> row) => DayExerciseModel(
            id: row['id'] as int?,
            fitnessPlanId: row['fitness_plan_id'] as int?,
            dayName: row['day_name'] as String?,
            name: row['name'] as String?),
        arguments: [planId]);
  }

  @override
  Future<int> insertDay(DayExerciseModel dayExerciseModel) {
    return _dayExerciseModelInsertionAdapter.insertAndReturnId(
        dayExerciseModel, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateDay(DayExerciseModel dayExerciseModel) {
    return _dayExerciseModelUpdateAdapter.updateAndReturnChangedRows(
        dayExerciseModel, OnConflictStrategy.abort);
  }
}

class _$ExerciseDao extends ExerciseDao {
  _$ExerciseDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _exerciseModelInsertionAdapter = InsertionAdapter(
            database,
            'exercise',
            (ExerciseModel item) => <String, Object?>{
                  'id': item.id,
                  'day_id': item.dayId,
                  'name': item.name
                }),
        _exerciseModelUpdateAdapter = UpdateAdapter(
            database,
            'exercise',
            ['id'],
            (ExerciseModel item) => <String, Object?>{
                  'id': item.id,
                  'day_id': item.dayId,
                  'name': item.name
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ExerciseModel> _exerciseModelInsertionAdapter;

  final UpdateAdapter<ExerciseModel> _exerciseModelUpdateAdapter;

  @override
  Future<void> deleteExerciseById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM exercise WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<List<ExerciseModel>> selectAllExercise(int dayId) async {
    return _queryAdapter.queryList('SELECT * FROM exercise WHERE day_id = ?1',
        mapper: (Map<String, Object?> row) => ExerciseModel(
            id: row['id'] as int?,
            dayId: row['day_id'] as int?,
            name: row['name'] as String?),
        arguments: [dayId]);
  }

  @override
  Future<int> insertExercise(ExerciseModel exerciseModel) {
    return _exerciseModelInsertionAdapter.insertAndReturnId(
        exerciseModel, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateExercise(ExerciseModel exerciseModel) {
    return _exerciseModelUpdateAdapter.updateAndReturnChangedRows(
        exerciseModel, OnConflictStrategy.abort);
  }
}

class _$TrialDao extends TrialDao {
  _$TrialDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _trialModelInsertionAdapter = InsertionAdapter(
            database,
            'trial',
            (TrialModel item) => <String, Object?>{
                  'id': item.id,
                  'exercise_id': item.exerciseId,
                  'repeats': item.repeats,
                  'weight': item.weight,
                  'restInMin': item.restInMin
                }),
        _trialModelUpdateAdapter = UpdateAdapter(
            database,
            'trial',
            ['id'],
            (TrialModel item) => <String, Object?>{
                  'id': item.id,
                  'exercise_id': item.exerciseId,
                  'repeats': item.repeats,
                  'weight': item.weight,
                  'restInMin': item.restInMin
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TrialModel> _trialModelInsertionAdapter;

  final UpdateAdapter<TrialModel> _trialModelUpdateAdapter;

  @override
  Future<void> deleteTrialById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM trial WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<List<TrialModel>> selectAllTrials(int exerciseId) async {
    return _queryAdapter.queryList('SELECT * FROM trial WHERE exercise_id =?1',
        mapper: (Map<String, Object?> row) => TrialModel(
            id: row['id'] as int?,
            exerciseId: row['exercise_id'] as int?,
            repeats: row['repeats'] as int?,
            weight: row['weight'] as double?,
            restInMin: row['restInMin'] as int?),
        arguments: [exerciseId]);
  }

  @override
  Future<int> insertTrial(TrialModel trialModel) {
    return _trialModelInsertionAdapter.insertAndReturnId(
        trialModel, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateTrial(TrialModel trialModel) {
    return _trialModelUpdateAdapter.updateAndReturnChangedRows(
        trialModel, OnConflictStrategy.abort);
  }
}
