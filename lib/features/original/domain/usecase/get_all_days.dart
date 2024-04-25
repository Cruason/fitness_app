import 'package:fitness_app/features/original/domain/entity/day_entity.dart';
import 'package:fitness_app/features/original/domain/usecase/usecase.dart';

import '../../../../core/resources/data_state.dart';
import '../repository/fitness_plan_repo.dart';

class GetAllDaysUseCase extends UseCase<DataState<List<DayExercisesEntity>>, int>{
  final FitnessPlanRepository fitnessPlanRepository;

  GetAllDaysUseCase(this.fitnessPlanRepository);
  @override
  Future<DataState<List<DayExercisesEntity>>> call({required int params}){
    return fitnessPlanRepository.getFitnessDays(params);
  }

}