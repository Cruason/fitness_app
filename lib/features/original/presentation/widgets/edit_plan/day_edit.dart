import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';
import '../../../domain/entity/day_entity.dart';

class DayEdit extends StatefulWidget {
  final int index;
  final DayExercisesEntity dayExercisesEntity;
  final Function(DayExercisesEntity) dayEdited;
  final Function() deleteDay;
  final ScrollController? scrollController;

  const DayEdit(
      {super.key,
      required this.index,
      this.scrollController,
      required this.dayExercisesEntity,
      required this.dayEdited,
      required this.deleteDay});

  @override
  State<DayEdit> createState() => _DayEditState();
}

class _DayEditState extends State<DayEdit> {
  Icon dropDownIcon = const Icon(
    Icons.arrow_drop_down,
    color: Colors.black,
  );
  Icon dropUpIcon = const Icon(Icons.arrow_drop_up, color: Colors.black);
  bool isOpen = false;
  late DayExercisesEntity dayExercisesEntity;

  @override
  void initState() {
    dayExercisesEntity = widget.dayExercisesEntity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController dayNameController =
        TextEditingController(text: dayExercisesEntity.name);
    dayNameController.selection = TextSelection.fromPosition(
        TextPosition(offset: dayNameController.text.length));

    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "${widget.index + 1} ) ",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.black, fontSize: 20),
              ),
              buildDropDown(
                  selectedDay: dayExercisesEntity.dayName,
                  onChange: (day) {
                    setState(() {
                      dayExercisesEntity =
                          dayExercisesEntity.copyWith(dayName: day);
                      widget.dayEdited(dayExercisesEntity);
                    });
                  },
                  days: [
                    Days.monday,
                    Days.tuesday,
                    Days.wednesday,
                    Days.thursday,
                    Days.friday,
                    Days.saturday,
                    Days.sunday
                  ]),
              const Expanded(
                child: SizedBox(),
              ),
              InkWell(
                onTap: () {
                  widget.deleteDay();
                },
                borderRadius: BorderRadius.circular(28),
                child: Container(
                  padding: const EdgeInsets.all(6),
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
          TextField(
            onChanged: (val) {
              Timer(const Duration(milliseconds: 500), () {
                if (val == dayNameController.text) {
                  dayExercisesEntity = dayExercisesEntity.copyWith(name: val);
                  widget.dayEdited(dayExercisesEntity);
                }
              });
            },
            controller: dayNameController,
            decoration: InputDecoration(
              border: const UnderlineInputBorder(),
              hintText: 'Введите название дня',
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
        ],
      ),
    ));
  }

  String capitalizeFirst(String? input) {
    if (input == null) {
      return "Выберите день";
    }
    return input[0].toUpperCase() + input.substring(1);
  }

  buildDropDown(
      {String? selectedDay,
      required Function(String) onChange,
      required List<String> days}) {
    return DropdownButton(
      icon: isOpen ? dropUpIcon : dropDownIcon,
      value: selectedDay,
      // Use the selectedDay value here
      hint: Text("Выберите день"),
      isDense: true,
      onTap: () {
        isOpen = !isOpen;
      },
      items: days.map((day) {
        return DropdownMenuItem<String>(
          value: day,
          child: Text(
            capitalizeFirst(day),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedDay = value; // Update the selectedDay variable
          isOpen = false;
          onChange(selectedDay!);
        });
      },
    );
  }
}
