import 'dart:async';

import 'package:fitness_app/features/original/domain/entity/trial.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';

class TrialEdit extends StatefulWidget {
  final int index;
  final TrialEntity trialEntity;
  final Function(TrialEntity) trialEdited;
  final Function() deleteTrial;
  final Function(TrialEntity) duplicate;

  const TrialEdit({
    required this.index,
    super.key,
    required this.trialEntity,
    required this.trialEdited,
    required this.deleteTrial,
    required this.duplicate,
  });

  @override
  State<TrialEdit> createState() => _TrialEditState();
}

class _TrialEditState extends State<TrialEdit> {
  @override
  Widget build(BuildContext context) {
    TrialEntity trialEntity = widget.trialEntity;
    int index = widget.index;

    final TextEditingController trialWeightController = TextEditingController(
        text:
            (trialEntity.weight != null) ? trialEntity.weight.toString() : "");
    final TextEditingController trialRepeatController = TextEditingController(
        text: (trialEntity.repeats != null)
            ? trialEntity.repeats.toString()
            : "");
    final TextEditingController trialRestController = TextEditingController(
        text: (trialEntity.restInMin != null)
            ? trialEntity.restInMin.toString()
            : "");

    trialWeightController.selection = TextSelection.fromPosition(
        TextPosition(offset: trialWeightController.text.length));
    trialRepeatController.selection = TextSelection.fromPosition(
        TextPosition(offset: trialRepeatController.text.length));
    trialRestController.selection = TextSelection.fromPosition(
        TextPosition(offset: trialRestController.text.length));

    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                Text(
                  "${index + 1} ) Подход",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.black, fontSize: 20),
                ),
                const Expanded(child: SizedBox()),
                InkWell(
                  onTap: () {
                    final newTrial = TrialEntity(
                        repeats: trialEntity.repeats,
                        weight: trialEntity.weight,
                        restInMin: trialEntity.restInMin);
                    widget.duplicate(newTrial);
                  },
                  borderRadius: BorderRadius.circular(28),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: CustomColors.green73D13D.color,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: ImageIcon(
                      AssetImage(CustomIcons.duplicateIcon.path),
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    widget.deleteTrial();
                  },
                  borderRadius: BorderRadius.circular(28),
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
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                buildTrialEditField(
                    controller: trialRepeatController,
                    onChanged: (val) {
                      trialEntity =
                          trialEntity.copyWith(repeats: int.tryParse(val));
                      widget.trialEdited(trialEntity);
                    },
                    hint: "Повторения",
                    iconPath: CustomIcons.repeatIcon.path),
                const SizedBox(width: 10),
                buildTrialEditField(
                    controller: trialWeightController,
                    onChanged: (val) {
                      trialEntity = trialEntity.copyWith(
                          weight: double.tryParse(val));
                      widget.trialEdited(trialEntity);
                    },
                    hint: "Вес",
                    iconPath: CustomIcons.weightIcon.path),
                const SizedBox(width: 10),
                buildTrialEditField(
                    controller: trialRestController,
                    onChanged: (val) {
                      trialEntity = trialEntity.copyWith(
                          restInMin: int.tryParse(val));
                      widget.trialEdited(trialEntity);
                    },
                    hint: "Отдых",
                    iconPath: CustomIcons.restIcon.path),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  buildTrialEditField(
      {required TextEditingController controller,
      required Function(String) onChanged,
      required String hint,
      required String iconPath}) {
    return Expanded(
      child: TextField(
        keyboardType: TextInputType.number,
        onChanged: (val) {
          Timer(const Duration(milliseconds: 500), () {
            if (val == controller.text) {
              if(val.isNotEmpty){
                onChanged(val);
              }
            }
          });
        },
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.center,
        controller: controller,
        decoration: InputDecoration(
          suffixIconConstraints:
              const BoxConstraints(maxHeight: 20, maxWidth: 20),
          suffixIcon: ImageIcon(AssetImage(iconPath)),
          border: const UnderlineInputBorder(),
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.bodyMedium,
        ),
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(color: CustomColors.orangeF08700.color),
      ),
    );
  }
}
