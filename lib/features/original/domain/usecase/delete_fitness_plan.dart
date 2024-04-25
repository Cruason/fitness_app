import 'package:fitness_app/core/resources/data_state.dart';
import 'package:fitness_app/features/original/domain/repository/fitness_plan_repo.dart';
import 'package:fitness_app/features/original/domain/usecase/usecase.dart';


class DeleteFitnessPlanUseCase extends UseCase<DataState<void>, dynamic>{
  final FitnessPlanRepository fitnessPlanRepository;

  DeleteFitnessPlanUseCase(this.fitnessPlanRepository);
  @override
  Future<DataState<void>> call({dynamic params}) {
    return fitnessPlanRepository.deleteFitnessEntity(params);
  }

}