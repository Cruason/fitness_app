import 'package:fitness_app/features/original/presentation/widgets/plan_list/plan_card.dart';
import 'package:fitness_app/features/original/presentation/widgets/plan_list/list_bar.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';
import '../../../domain/entity/fitness_plan_entity.dart';

class PlanList extends StatelessWidget {
  final Function() refreshList;
  final Function() onAdd;
  final Function(FitnessPlanEntity) deletePlan;
  final List<FitnessPlanEntity> fitnessPlanList;
  final Function(FitnessPlanEntity) goDetailsPage;

  const PlanList(
      {super.key,
      required this.fitnessPlanList,
      required this.goDetailsPage,
      required this.refreshList,
      required this.deletePlan, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListBar(
            planAmount: fitnessPlanList.length,
            onAdd: () async {
              onAdd();
            },
          ),
          Divider(
            thickness: 2,
            color: CustomColors.orangeF08700.color,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                refreshList();
              },
              child: ListView.builder(
                itemCount: fitnessPlanList.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PlanCard(
                        fitnessPlanEntity: fitnessPlanList[index],
                        goDetailsPage: (fitnessPlanEntity) {
                          goDetailsPage(fitnessPlanEntity);
                        },
                        deletePlan: (fitnessPlanEntity) {
                          deletePlan(fitnessPlanEntity);
                        },
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
