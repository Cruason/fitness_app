import 'package:fitness_app/features/original/domain/usecase/usecase.dart';

import '../../../../core/resources/data_state.dart';
import '../entity/fitness_plan_entity.dart';
import '../repository/fitness_plan_repo.dart';

class GetFitnessPlanByIdUseCase extends UseCase<DataState<FitnessPlanEntity?>, int>{
  final FitnessPlanRepository fitnessPlanRepository;

  GetFitnessPlanByIdUseCase(this.fitnessPlanRepository);
  @override
  Future<DataState<FitnessPlanEntity?>> call({required int params}){
    return fitnessPlanRepository.getFitnessPlanById(params);
  }
}