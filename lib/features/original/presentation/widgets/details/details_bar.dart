import 'package:fitness_app/features/original/domain/entity/exercise.dart';
import 'package:fitness_app/features/original/domain/entity/trial.dart';
import 'package:fitness_app/features/original/presentation/widgets/options/open_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/features/original/presentation/widgets/edit_plan/day_edit.dart';

import '../../../../../core/constants/constants.dart';
import '../../../domain/entity/day_entity.dart';
import '../options/options_pop_down.dart';

class DetailsBar extends StatelessWidget {
  final String planName;
  final Function(String) updateName;
  final Function(DayExercisesEntity) addDay;

  const DetailsBar(
      {super.key,
      required this.planName,
      required this.updateName,
      required this.addDay});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            planName,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.black, height: 1),
          ),
          OptionsPopDown(
              color: Colors.black,
              onSelect: (option) {
                switch (option) {
                  case Options.edit:
                    var newName = planName;
                    showDialog(
                        context: context,
                        builder: (context) {
                          return OpenCustomDialog(
                              widget: buildUpdateTextField(
                                  context: context,
                                  onChange: (val) {
                                    newName = val;
                                  }),
                              onConfirm: () {
                                updateName(newName);
                              });
                        });
                    break;
                  case Options.add:
                    DayExercisesEntity newDay =
                        const DayExercisesEntity();
                    showDialog(
                        context: context,
                        builder: (context) {
                          return OpenCustomDialog(
                              widget: DayEdit(
                                  index: 0,
                                  dayExercisesEntity: newDay,
                                  dayEdited: (editedDay) {
                                    newDay = editedDay;
                                  },
                                  deleteDay: () {
                                    Navigator.of(context).pop();
                                  }),
                              onConfirm: () {
                                addDay(newDay);
                              });
                        });
                    break;
                  default:
                    break;
                }
              },
              options: const [Options.edit, Options.add])
        ],
      ),
    );
  }

  buildUpdateTextField(
      {required BuildContext context, required Function(String) onChange}) {
    TextEditingController fitnessPlanNameController =
        TextEditingController(text: planName);

    return TextField(
      onChanged: (val) {
        fitnessPlanNameController.text = val;
        onChange(val);
      },
      controller: fitnessPlanNameController,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        hintText: 'Введите название плана',
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
