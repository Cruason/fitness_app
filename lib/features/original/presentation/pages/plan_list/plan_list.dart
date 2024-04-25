import 'package:fitness_app/features/original/presentation/pages/error/error_page.dart';
import 'package:fitness_app/features/original/presentation/widgets/edit_plan/plan_edit.dart';
import 'package:fitness_app/features/original/presentation/widgets/options/open_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entity/fitness_plan_entity.dart';
import '../../bloc/plan_list//fitness_plan_bloc.dart';
import '../../bloc/plan_list//fitness_plan_event.dart';
import '../../bloc/plan_list//fitness_plan_state.dart';
import '../../widgets/plan_list/plan_list.dart';
import 'empty_list_page.dart';

class PlanListPage extends StatelessWidget {
  final FitnessPlanBloc fitnessPlanBloc;
  final Function(FitnessPlanEntity) goDetailsPage;
  final Function(FitnessPlanEntity) deleteFromDetails;

  const PlanListPage({
    super.key,
    required this.goDetailsPage,
    required this.fitnessPlanBloc,
    required this.deleteFromDetails,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: fitnessPlanBloc,
      child: BlocBuilder<FitnessPlanBloc, FitnessPlanState>(
        builder: (context, state) {
          if (state is FitnessPlanLoadingState) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (state is FitnessPlanSuccessState && state.entity!.isEmpty) {
            return EmptyListPage(
              onAddPage: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      var newFitnessPlan = const FitnessPlanEntity();
                      return OpenCustomDialog(
                          widget: PlanEdit(
                            fitnessPlanEntity: newFitnessPlan,
                            planEdited: (fitnessPlanEntity) {
                              newFitnessPlan = fitnessPlanEntity;
                            },
                          ),
                          onConfirm: () {
                            fitnessPlanBloc
                                .add(AddFitnessPlanEvent(newFitnessPlan));
                          });
                    });
              },
            );
          }
          if (state is FitnessPlanSuccessState && state.entity != null) {
            if (state.entity is List<FitnessPlanEntity>) {
              return PlanList(
                fitnessPlanList: state.entity!,
                goDetailsPage: (fitnessPlanEntity) {
                  goDetailsPage(fitnessPlanEntity);
                },
                refreshList: () {
                  fitnessPlanBloc.add(const GetFitnessPlanEvent());
                },
                deletePlan: (fitnessPlanEntity) {
                  fitnessPlanBloc
                      .add(DeleteFitnessPlanEvent(fitnessPlanEntity));
                },
                onAdd: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        var newFitnessPlan = const FitnessPlanEntity();
                        return OpenCustomDialog(
                            widget: PlanEdit(
                              fitnessPlanEntity: newFitnessPlan,
                              planEdited: (fitnessPlanEntity) {
                                newFitnessPlan = fitnessPlanEntity;
                              },
                            ),
                            onConfirm: () {
                              fitnessPlanBloc
                                  .add(AddFitnessPlanEvent(newFitnessPlan));
                            });
                      });
                },
              );
            }
          }
          if (state is FitnessPlanErrorState) {
            return ErrorPage(
              errorMessage: state.message,
              onRefresh: () => fitnessPlanBloc.add(const GetFitnessPlanEvent()),
            );
          }
          if (state is FitnessPlanCompletedState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              fitnessPlanBloc.add(const GetFitnessPlanEvent());
              deleteFromDetails(state.fitnessPlanEntity);
              ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(
                  content: Text(state.message??"Неизвестная ошибка"),
                ),
              );
            });
          }
          return const SizedBox();
        },
      ),
    );
  }
}
