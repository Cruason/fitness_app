import 'package:fitness_app/features/original/presentation/widgets/details/day_card.dart';
import 'package:fitness_app/features/original/presentation/widgets/edit_plan/day_edit.dart';
import 'package:fitness_app/features/original/presentation/widgets/options/open_dialog.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';
import '../../../domain/entity/day_entity.dart';

class DayList extends StatefulWidget {
  final List<DayExercisesEntity> dayExercisesList;
  final Function(DayExercisesEntity) goToExerciseList;
  final Function(DayExercisesEntity) deleteDay;
  final Function(DayExercisesEntity) updateDay;
  final Function(DayExercisesEntity) addDay;

  const DayList({
    Key? key,
    required this.dayExercisesList,
    required this.deleteDay,
    required this.updateDay,
    required this.goToExerciseList,
    required this.addDay,
  }) : super(key: key);

  @override
  State<DayList> createState() => _DayListState();
}

class _DayListState extends State<DayList> {
  int selectedIndex = 0;
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    if(widget.dayExercisesList.isEmpty)
      {
        return Center(
          child: ElevatedButton(
            onPressed: () async {
              DayExercisesEntity newDay = const DayExercisesEntity();
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
                          widget.addDay(newDay);
                        });
                  });
            },
            style: ButtonStyle(
                shape: const MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5)))),
                backgroundColor: MaterialStatePropertyAll(
                    CustomColors.green73D13D.color)),
            child: const Text(
              "Добавить день",
              style: TextStyle(color: Colors.black),
            ),
          ),
        );
      }else{
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.dayExercisesList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    widget.goToExerciseList(widget.dayExercisesList[index]);
                  },
                  child: DayCard(
                    dayExercisesEntity: widget.dayExercisesList[index],
                    backgroundColor: (index.isEven)
                        ? CustomColors.green73D13D.color
                        : CustomColors.orangeF08700.color,
                    deleteDay: () {
                      widget.deleteDay(widget.dayExercisesList[index]);
                    },
                    updateDay: (dayExercisesEntity) {
                      widget.updateDay(dayExercisesEntity);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      );
    }
  }
}
