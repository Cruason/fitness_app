import 'package:fitness_app/core/constants/constants.dart';
import 'package:fitness_app/features/original/domain/entity/trial.dart';
import 'package:fitness_app/features/original/presentation/widgets/edit_plan/trial_edit.dart';
import 'package:fitness_app/features/original/presentation/widgets/options/open_dialog.dart';
import 'package:flutter/material.dart';

class TrialCard extends StatelessWidget {
  final int count;
  final TrialEntity trialEntity;
  final Function(TrialEntity) deleteTrial;
  final Function(TrialEntity) editTrial;
  final Function(TrialEntity) addTrial;

  const TrialCard(
      {super.key, required this.count, required this.trialEntity, required this.deleteTrial, required this.editTrial, required this.addTrial});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        showDialog(context: context, builder: (context) {
          TrialEntity newTrialEntity = trialEntity;
          return OpenCustomDialog(widget: TrialEdit(index: 0,
              trialEntity: trialEntity,
              trialEdited: (trialEdited) {
                newTrialEntity = trialEdited;
              },
              deleteTrial: () {
                deleteTrial(trialEntity);
                Navigator.pop(context);
              }, duplicate: (trialEntity ) {
                addTrial(trialEntity);
            },),
              onConfirm: () {
                editTrial(newTrialEntity);
              });
        });
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Подход номер  ${count.toString()}",
              style:
              Theme
                  .of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(height: 1),
            ),
          ),
          Row(
            children: [
              buildIcon(context, CustomIcons.repeatIcon.path,
                  trialEntity.repeats.toString()),
              const SizedBox(
                width: 10,
              ),
              buildIcon(context, CustomIcons.weightIcon.path,
                  trialEntity.weight.toString()),
              const SizedBox(
                width: 10,
              ),
              buildIcon(context, CustomIcons.restIcon.path,
                  trialEntity.restInMin.toString())
            ],
          ),
        ],
      ),
    );
  }

  buildIcon(BuildContext context,
      String iconPath,
      String title,) {
    return Row(
      children: [
        ImageIcon(AssetImage(iconPath)),
        const SizedBox(
          width: 5,
        ),
        Text(
          title,
          style: Theme
              .of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(height: 1),
        )
      ],
    );
  }
}
