import 'dart:async';

import 'package:fitness_app/core/constants/constants.dart';
import 'package:flutter/material.dart';

import '../../../domain/entity/fitness_plan_entity.dart';

class PlanEdit extends StatefulWidget {
  final FitnessPlanEntity fitnessPlanEntity;
  final Function(FitnessPlanEntity) planEdited;

  const PlanEdit(
      {super.key, required this.fitnessPlanEntity, required this.planEdited});

  @override
  State<PlanEdit> createState() => _PlanEditState();
}

class _PlanEditState extends State<PlanEdit> {
  late FitnessPlanEntity fitnessPlanEntity;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    fitnessPlanEntity = widget.fitnessPlanEntity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController fitnessPlanNameController =
        TextEditingController(text: fitnessPlanEntity.name);

    fitnessPlanNameController.selection = TextSelection.fromPosition(
        TextPosition(offset: fitnessPlanNameController.text.length));

    return TextField(
      onChanged: (val) {
        Timer(const Duration(milliseconds: 500), () {
          if (val == fitnessPlanNameController.text) {
            fitnessPlanEntity = fitnessPlanEntity.copyWith(name: val);
            widget.planEdited(fitnessPlanEntity);
          }
        });
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
