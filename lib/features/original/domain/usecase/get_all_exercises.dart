import 'package:fitness_app/features/original/domain/entity/exercise.dart';
import 'package:fitness_app/features/original/domain/usecase/usecase.dart';

import '../../../../core/resources/data_state.dart';
import '../repository/fitness_plan_repo.dart';

class GetAllExercisesUseCase extends UseCase<DataState<List<ExerciseEntity>>, int>{
  final FitnessPlanRepository fitnessPlanRepository;

  GetAllExercisesUseCase(this.fitnessPlanRepository);
  @override
  Future<DataState<List<ExerciseEntity>>> call({required int params}){
    return fitnessPlanRepository.getFitnessExercises(params);
  }

}