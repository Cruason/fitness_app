import 'package:fitness_app/core/resources/data_state.dart';
import 'package:fitness_app/features/original/domain/repository/fitness_plan_repo.dart';
import 'package:fitness_app/features/original/domain/usecase/usecase.dart';

class UpdateFitnessPlanUseCase extends UseCase<DataState<void>, (dynamic, int)>{
  final FitnessPlanRepository fitnessPlanRepository;

  UpdateFitnessPlanUseCase(this.fitnessPlanRepository);
  @override
  Future<DataState<void>> call({dynamic params, int? id}) {
    return fitnessPlanRepository.updateFitnessEntity(params, id);
  }

}