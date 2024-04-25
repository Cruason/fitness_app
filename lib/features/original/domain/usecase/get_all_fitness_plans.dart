import 'package:fitness_app/core/resources/data_state.dart';
import 'package:fitness_app/features/original/domain/repository/fitness_plan_repo.dart';
import 'package:fitness_app/features/original/domain/usecase/usecase.dart';

import '../entity/fitness_plan_entity.dart';

class GetAllFitnessPlansUseCase extends UseCase<DataState<List<FitnessPlanEntity>>, void>{
  final FitnessPlanRepository fitnessPlanRepository;

  GetAllFitnessPlansUseCase(this.fitnessPlanRepository);
  @override
  Future<DataState<List<FitnessPlanEntity>>> call({void params}){
      return fitnessPlanRepository.getFitnessPlans();
  }

}