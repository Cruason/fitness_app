import 'package:equatable/equatable.dart';
import 'package:fitness_app/features/original/domain/entity/trial.dart';

class ExerciseEntity extends Equatable{
  final int? id;
  final String? name;
  final List<TrialEntity>? trials;

  const ExerciseEntity({this.id, this.name,  this.trials});

  @override
  List<Object?> get props => [
    id,
    name,
    trials
  ];

  ExerciseEntity copyWith({int? id, String? name, List<TrialEntity>? trials}){
    return ExerciseEntity(
      id: id??this.id,
      name: name??this.name,
      trials: trials?? this.trials
    );
  }
}