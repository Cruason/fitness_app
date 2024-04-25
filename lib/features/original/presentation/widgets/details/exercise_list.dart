import 'package:fitness_app/features/original/domain/entity/trial.dart';
import 'package:fitness_app/features/original/presentation/widgets/details/exercise_card.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';
import '../../../domain/entity/exercise.dart';

class ExerciseList extends StatelessWidget {
  final List<ExerciseEntity> exerciseList;
  final Function(ExerciseEntity) updateExercise;
  final Function(ExerciseEntity) deleteExercise;
  final Function(TrialEntity, int) addTrial;
  final Function(TrialEntity, int) editTrial;
  final Function(TrialEntity) deleteTrial;

  const ExerciseList(
      {super.key,
      required this.exerciseList,
      required this.updateExercise,
      required this.deleteExercise,
      required this.addTrial,
      required this.editTrial,
      required this.deleteTrial});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: exerciseList.length,
      itemBuilder: (context, index) {
        return Column(children: [
          ExerciseCard(
            exerciseEntity: (exerciseList[index]),
            index: index,
            updateExercise: (exerciseEntity) {
              updateExercise(exerciseEntity);
            },
            deleteExercise: (exerciseEntity) {
              deleteExercise(exerciseEntity);
            },
            addTrial: (trialEntity, parentId) {
              addTrial(trialEntity, parentId);
            },
            editTrial: (trialEntity, parentId) {
              editTrial(trialEntity, parentId);
            },
            deleteTrial: (trialEntity) {
              deleteTrial(trialEntity);
            },
          ),
          Divider(
            thickness: 1,
            color: CustomColors.lightGray.color,
          )
        ]);
      },
    );
  }
}
