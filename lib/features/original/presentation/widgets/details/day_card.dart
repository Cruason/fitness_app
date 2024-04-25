import 'package:fitness_app/features/original/presentation/widgets/edit_plan/day_edit.dart';
import 'package:fitness_app/features/original/presentation/widgets/options/open_dialog.dart';
import 'package:fitness_app/features/original/presentation/widgets/options/options_pop_down.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';
import '../../../domain/entity/day_entity.dart';

class DayCard extends StatelessWidget {
  final Color backgroundColor;
  final Function() deleteDay;
  final Function(DayExercisesEntity) updateDay;

  final DayExercisesEntity dayExercisesEntity;

  const DayCard(
      {super.key,
      required this.dayExercisesEntity,
      required this.backgroundColor,
      required this.deleteDay,
      required this.updateDay});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        color: backgroundColor,
        elevation: 3,
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
              (dayExercisesEntity.dayName != null)?dayExercisesEntity.dayName
                  .toString()
                  .toUpperCase(): "None",
                    style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                        height: 1),
                  ),
                  OptionsPopDown(
                      onSelect: (option) {
                        switch (option) {
                          case Options.edit:
                            showDialog(
                                context: context,
                                builder: (context) {
                                  var newDay = dayExercisesEntity;
                                  return OpenCustomDialog(
                                      widget: DayEdit(
                                        dayEdited: (day) {
                                          newDay = day;
                                        },
                                        dayExercisesEntity: newDay,
                                        index: 0, deleteDay: ( ) {
                                          Navigator.pop(context);
                                      },
                                      ),
                                      onConfirm: () {
                                        updateDay(newDay);
                                      });
                                });
                            break;
                          case Options.delete:
                            deleteDay();
                            break;
                          default:
                            break;
                        }
                      },
                      options: const [
                        Options.edit,
                        Options.delete,
                      ],
                      color: Colors.white)
                ],
              ),
              Center(
                child: Text(
                  (dayExercisesEntity.name!= null)? '${dayExercisesEntity.name}':"none",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(height: 1),
                ),
              ),
              const SizedBox(
                height: 25,
              )
            ],
          ),
        ),
      ),
    );
  }
}
