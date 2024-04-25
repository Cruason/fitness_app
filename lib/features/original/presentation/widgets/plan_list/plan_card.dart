import 'package:fitness_app/features/original/presentation/widgets/options/options_pop_down.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';
import '../../../domain/entity/fitness_plan_entity.dart';

class PlanCard extends StatelessWidget {
  final Function(FitnessPlanEntity) goDetailsPage;
  final Function(FitnessPlanEntity) deletePlan;
  final FitnessPlanEntity fitnessPlanEntity;

  const PlanCard({
    super.key,
    required this.fitnessPlanEntity,
    required this.goDetailsPage,
    required this.deletePlan,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        goDetailsPage(fitnessPlanEntity);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(fitnessPlanEntity.name ?? "",
                      textAlign: TextAlign.left,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(height: 1)),
                  OptionsPopDown(
                    onSelect: (option) {
                      switch (option) {
                        case Options.delete:
                          deletePlan(fitnessPlanEntity);
                          break;
                        case Options.share:
                          break;
                        default:
                          break;
                      }
                    },
                    options: const [Options.share, Options.delete],
                    color: CustomColors.green73D13D.color,
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(
                        (fitnessPlanEntity.days!.length / 2).ceil(),
                        (index) {
                          final dayIndex = index;
                          final day = fitnessPlanEntity.days![dayIndex];
                          return Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              textAlign: TextAlign.left,
                              "${day.dayName.toString().toUpperCase()}: ${day.name}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(height: 1),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                          (fitnessPlanEntity.days!.length / 2).floor(),
                          (index) {
                            final dayIndex =
                                (fitnessPlanEntity.days!.length / 2).ceil() +
                                    index;
                            final day = fitnessPlanEntity.days![dayIndex];
                            return Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                textAlign: TextAlign.left,
                                  "${day.dayName.toString().toUpperCase()}: ${day.name}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(height: 1),
                              ),
                            );
                          },
                        )),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      goDetailsPage(fitnessPlanEntity);
                    },
                    style: ButtonStyle(
                        shape: const MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)))),
                        backgroundColor: MaterialStatePropertyAll(CustomColors
                            .green73D13D.color) // Set button background color
                        ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Вперед',
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_right_sharp, color: Colors.black),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
