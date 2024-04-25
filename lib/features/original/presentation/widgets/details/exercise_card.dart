import 'package:fitness_app/core/constants/constants.dart';
import 'package:fitness_app/features/original/domain/entity/exercise.dart';
import 'package:fitness_app/features/original/domain/entity/trial.dart';
import 'package:fitness_app/features/original/presentation/widgets/details/trial_card.dart';
import 'package:fitness_app/features/original/presentation/widgets/edit_plan/trial_edit.dart';
import 'package:fitness_app/features/original/presentation/widgets/options/open_dialog.dart';
import 'package:fitness_app/features/original/presentation/widgets/options/options_pop_down.dart';
import 'package:flutter/material.dart';

class ExerciseCard extends StatelessWidget {
  final int index;
  final ExerciseEntity exerciseEntity;
  final Function(ExerciseEntity) updateExercise;
  final Function(ExerciseEntity) deleteExercise;
  final Function(TrialEntity, int) addTrial;
  final Function(TrialEntity, int) editTrial;
  final Function(TrialEntity) deleteTrial;

  const ExerciseCard(
      {super.key,
      required this.exerciseEntity,
      required this.index,
      required this.updateExercise,
      required this.deleteExercise,
      required this.addTrial,
      required this.editTrial,
      required this.deleteTrial});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ImageIcon(AssetImage(CustomIcons.exerciseIcon.path)),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${index + 1}) ${exerciseEntity.name}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(height: 1),
                  ),
                ],
              ),
              OptionsPopDown(
                  onSelect: (option) {
                    switch (option) {
                      case Options.edit:
                        ExerciseEntity newExerciseEntity = exerciseEntity;
                        showDialog(
                            context: context,
                            builder: (context) {
                              return OpenCustomDialog(
                                widget: buildNameInput(context, (name) {
                                  newExerciseEntity =
                                      newExerciseEntity.copyWith(name: name);
                                }),
                                onConfirm: () {
                                  updateExercise(newExerciseEntity);
                                },
                              );
                            });
                        break;
                      case Options.add:
                        TrialEntity newTrialEntity = const TrialEntity();
                        showDialog(
                            context: context,
                            builder: (context) {
                              return OpenCustomDialog(
                                widget: TrialEdit(
                                  index: 0,
                                  trialEntity: newTrialEntity,
                                  trialEdited: (trialEntity) {
                                    newTrialEntity = trialEntity;
                                  },
                                  deleteTrial: () {
                                    Navigator.pop(context);
                                  }, duplicate: (trialEntity ) {
                                    addTrial(trialEntity, exerciseEntity.id!);
                                    Navigator.pop(context);
                                },
                                ),
                                onConfirm: () {
                                  addTrial(newTrialEntity, exerciseEntity.id!);
                                },
                              );
                            });
                        break;
                      case Options.delete:
                        deleteExercise(exerciseEntity);
                        break;
                      default:
                        break;
                    }
                  },
                  options: const [Options.edit, Options.add, Options.delete],
                  color: Colors.black)
            ],
          ),
          SizedBox(
            height: 60,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: exerciseEntity.trials?.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      TrialCard(
                        count: index + 1,
                        trialEntity: exerciseEntity.trials![index],
                        deleteTrial: (trialEntity) {
                          deleteTrial(trialEntity);
                        },
                        editTrial: (trialEntity) {
                          editTrial(trialEntity, exerciseEntity.id!);
                        }, addTrial: (trialEntity ) {
                          addTrial(trialEntity , exerciseEntity.id!);
                          Navigator.pop(context);
                      },
                      ),
                      (index != exerciseEntity.trials!.length - 1)
                          ? VerticalDivider(
                              thickness: 1,
                              color: CustomColors.lightGray.color,
                            )
                          : const SizedBox()
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }

  buildNameInput(BuildContext context, Function(String) onChange) {
    TextEditingController exerciseNameController =
        TextEditingController(text: exerciseEntity.name);
    return TextField(
      onChanged: (val) {
        exerciseNameController.text = val;
        onChange(val);
      },
      textAlignVertical: TextAlignVertical.center,
      controller: exerciseNameController,
      decoration: InputDecoration(
        isDense: true,
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
    );
  }
}
