
import 'package:floor/floor.dart';

import '../../domain/entity/fitness_plan_entity.dart';


@Entity(tableName: 'fitness_plan')
class FitnessPlanModel {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String? name;

  FitnessPlanModel({this.id, this.name});

  factory FitnessPlanModel.fromEntity(FitnessPlanEntity entity){
    return FitnessPlanModel(
        id:entity.id,
        name:entity.name,
    );
  }
}