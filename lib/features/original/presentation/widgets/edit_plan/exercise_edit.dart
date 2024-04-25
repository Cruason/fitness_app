import 'dart:async';

import 'package:fitness_app/core/constants/constants.dart';
import 'package:fitness_app/features/original/domain/entity/exercise.dart';
import 'package:fitness_app/features/original/domain/entity/trial.dart';
import 'package:fitness_app/features/original/presentation/widgets/edit_plan/trial_edit.dart';
import 'package:flutter/material.dart';



class ExerciseEdit extends StatefulWidget {
  final ExerciseEntity exerciseEntity;
  final int index;
  final Function(ExerciseEntity) exerciseEdited;
  final Function() deleteExercise;

  const ExerciseEdit({
    required this.index,
    super.key,
    required this.exerciseEntity,
    required this.exerciseEdited,
    required this.deleteExercise,
  });


  @override
  State<ExerciseEdit> createState() => _ExerciseEditState();
}

class _ExerciseEditState extends State<ExerciseEdit> {
  late ExerciseEntity exerciseEntity;
  @override
  void initState() {
    exerciseEntity = widget.exerciseEntity;
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    int exerciseIndex = widget.index;
    final TextEditingController exerciseNameController =
        TextEditingController(text: exerciseEntity.name);
    exerciseNameController.selection = TextSelection.fromPosition(
        TextPosition(offset: exerciseEntity.name?.length ?? 0));

    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (val) {
                      Timer(const Duration(milliseconds: 500), () {
                        if (val == exerciseNameController.text) {
                          setState(() {
                            exerciseEntity = exerciseEntity.copyWith(name: val);
                            widget.exerciseEdited(exerciseEntity);
                          });
                        }
                      });
                    },
                    textAlignVertical: TextAlignVertical.center,
                    controller: exerciseNameController,
                    decoration: InputDecoration(
                      isDense: true,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          "${exerciseIndex + 1} ) ",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      border: const UnderlineInputBorder(),
                      hintText: 'Введите название упражнения',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.black),
                    ),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: CustomColors.orangeF08700.color),
                  ),
                ),
                InkWell(
                  onTap: () {
                    widget.deleteExercise();
                  },
                  borderRadius: BorderRadius.circular(28),
                  // Half of the width/height to make it a perfect circle
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    // Adjust padding as needed
                    decoration: BoxDecoration(
                      color: CustomColors.redFire.color,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: ImageIcon(
                      AssetImage(CustomIcons.deleteIcon.path),
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: exerciseEntity.trials?.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TrialEdit(
                      index: index,
                      trialEntity: exerciseEntity.trials![index],
                      trialEdited: (trialEntity) {
                        setState(() {
                          List<TrialEntity>? trials = List.from(exerciseEntity.trials??[]);
                          trials[index] = trialEntity;
                          exerciseEntity = exerciseEntity.copyWith(trials: trials);
                          widget.exerciseEdited(exerciseEntity);
                        });
                      },
                      deleteTrial: () {
                        setState(() {
                          if (exerciseEntity.trials!.length > 1) {
                            List<TrialEntity>? trials = List.from(exerciseEntity.trials??[]);
                            trials.removeAt(index);
                            exerciseEntity = exerciseEntity.copyWith(trials: trials);
                            widget.exerciseEdited(exerciseEntity);
                          }
                        });
                      }, duplicate: (trialEntity ) {
                      setState(() {
                        List<TrialEntity>? trials = List.from(exerciseEntity.trials??[]);
                        trials.add(trialEntity);
                        exerciseEntity = exerciseEntity.copyWith(trials: trials);
                        widget.exerciseEdited(exerciseEntity);
                      });
                    },
                    ),
                  );
                }),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    List<TrialEntity>? trials = List.from(exerciseEntity.trials??[]);
                    trials.add(const TrialEntity());
                    exerciseEntity = exerciseEntity.copyWith(trials: trials);
                    widget.exerciseEdited(exerciseEntity);
                  });
                },
                child: const Text('Добавить повторение'),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
