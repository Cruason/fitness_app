import 'package:fitness_app/features/original/domain/entity/exercise.dart';
import 'package:fitness_app/features/original/domain/entity/fitness_plan_entity.dart';
import 'package:fitness_app/features/original/domain/entity/trial.dart';
import 'package:fitness_app/features/original/presentation/bloc/details/details_bloc.dart';
import 'package:fitness_app/features/original/presentation/bloc/details/details_event.dart';
import 'package:fitness_app/features/original/presentation/bloc/details/details_state.dart';
import 'package:fitness_app/features/original/presentation/bloc/update_plan/update_bloc.dart';
import 'package:fitness_app/features/original/presentation/bloc/update_plan/update_event.dart';
import 'package:fitness_app/features/original/presentation/bloc/update_plan/update_state.dart';
import 'package:fitness_app/features/original/presentation/pages/detail/no_details_selected_page.dart';
import 'package:fitness_app/features/original/presentation/pages/error/error_page.dart';
import 'package:fitness_app/features/original/presentation/widgets/details/day_list.dart';
import 'package:fitness_app/features/original/presentation/widgets/details/details_bar.dart';
import 'package:fitness_app/features/original/presentation/widgets/details/exercise_list.dart';
import 'package:fitness_app/features/original/presentation/widgets/edit_plan/exercise_edit.dart';
import 'package:fitness_app/features/original/presentation/widgets/options/open_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';

class PlanDetailPage extends StatefulWidget {
  final DetailsBloc detailsBloc;
  final UpdatePlanBloc updatePlanBloc;
  final Function() goToPlanList;
  final Function() updated;

  const PlanDetailPage({
    Key? key,
    required this.goToPlanList,
    required this.detailsBloc,
    required this.updatePlanBloc,
    required this.updated,
  }) : super(key: key);

  @override
  State<PlanDetailPage> createState() => _PlanDetailPageState();
}

class _PlanDetailPageState extends State<PlanDetailPage> {


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => widget.detailsBloc,
        ),
        BlocProvider(
          create: (BuildContext context) =>  widget.updatePlanBloc,
        )
      ],
      child: BlocBuilder<DetailsBloc, PlanDetailsState>(
        bloc:  widget.detailsBloc,
        builder: (context, state) {
          if (state is PlanDetailsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PlanDetailsEmptyState) {
            return NoDetailsSelectedPage(
              goToPlanList: () {
                widget.goToPlanList();
              },
            );
          }
          if (state is PlanDetailsErrorState) {
            return ErrorPage(
                errorMessage: state.error,
                onRefresh: () {
                  widget.goToPlanList();
                });
          }
          if (state is PlanDetailsSuccessState) {
            if (state.entity is FitnessPlanEntity) {
                widget.detailsBloc.planId = state.entity.id;
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DetailsBar(
                      planName: state.entity.name ?? "",
                      updateName: (name) {
                        widget.updatePlanBloc.add(UpdateEntityEvent(
                            entity: state.entity.copyWith(name: name)));
                      },
                      addDay: (dayExercisesEntity) {
                        widget.updatePlanBloc.add(AddEntityEvent(
                            entity: dayExercisesEntity,
                            parentId: state.entity.id));
                      },
                    ),
                    Divider(
                      thickness: 2,
                      color: CustomColors.orangeF08700.color,
                    ),
                    Expanded(
                            child: DayList(
                              dayExercisesList: state.entity.days!,
                              deleteDay: (dayExercisesEntity) {
                                widget.updatePlanBloc.add(DeleteEntityEvent(
                                    entity: dayExercisesEntity));
                              },
                              updateDay: (dayExercisesEntity) {
                                widget.updatePlanBloc.add(UpdateEntityEvent(
                                    entity: dayExercisesEntity,
                                    parentId: state.entity.id));
                              },
                              goToExerciseList: (day) {
                                widget.detailsBloc
                                    .add(GetExercisesDetailsEvent(id: day.id!));
                                  widget.detailsBloc.selectedDay = day;
                              }, addDay: (dayExercisesEntity ) {
                              widget.updatePlanBloc.add(AddEntityEvent(entity: dayExercisesEntity, parentId: state.entity.id));
                            },
                            ),
                          ),
                    BlocBuilder<UpdatePlanBloc, UpdateState>(
                      bloc:  widget.updatePlanBloc,
                      builder: (BuildContext context, state) {
                        if (state is UpdateSuccessState) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            widget.detailsBloc.add(GetPlanDetailsEvent(id: widget.detailsBloc.planId!));
                            widget.updatePlanBloc.add(const UpdatingFinishedEvent());
                            widget.updated();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text(state.message ?? "Неизвестная ошибка"),
                              ),
                            );
                          });
                        }
                        return const SizedBox();
                      },
                    )
                  ]);
            }
            if (state.entity is List<ExerciseEntity>) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              widget.detailsBloc.add(GetPlanDetailsEvent(id: widget.detailsBloc.planId!));
                            },
                            icon: const Icon(
                              Icons.arrow_left_sharp,
                              size: 40,
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Дни",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: Colors.black),
                        ),
                        const Expanded(child: SizedBox()),
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: CustomColors.green73D13D
                                .color, // Set button background color
                          ),
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    var newExercise = const ExerciseEntity(
                                        name: "", trials: [TrialEntity()]);
                                    return OpenCustomDialog(
                                        widget: ExerciseEdit(
                                            index: 0,
                                            exerciseEntity: newExercise,
                                            exerciseEdited: (exerciseEdited) {
                                              newExercise = exerciseEdited;
                                            },
                                            deleteExercise: () {
                                              Navigator.pop(context);
                                            }),
                                        onConfirm: () {
                                          widget.updatePlanBloc.add(AddEntityEvent(
                                              entity: newExercise,
                                              parentId: widget.detailsBloc.selectedDay?.id!));
                                        });
                                  });
                            },
                            borderRadius: BorderRadius.circular(28),
                            child: const Icon(
                              Icons.add,
                              color: Colors.black, // Set icon color
                            ),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: ExerciseList(
                        exerciseList: state.entity,
                        updateExercise: (exercise) {
                          widget.updatePlanBloc.add(UpdateEntityEvent(
                              entity: exercise, parentId: widget.detailsBloc.selectedDay!.id!));
                        },
                        deleteExercise: (deleteExercise) {
                          widget.updatePlanBloc
                              .add(DeleteEntityEvent(entity: deleteExercise));
                        },
                        addTrial: (addTrial, parentId) {
                          widget.updatePlanBloc.add(AddEntityEvent(
                              entity: addTrial, parentId: parentId));
                        },
                        editTrial: (editTrial, parentId) {
                          widget.updatePlanBloc.add(UpdateEntityEvent(
                              entity: editTrial, parentId: parentId));
                        },
                        deleteTrial: (deleteTrial) {
                          widget.updatePlanBloc
                              .add(DeleteEntityEvent(entity: deleteTrial));
                        },
                      ),
                    ),
                    BlocBuilder<UpdatePlanBloc, UpdateState>(
                      bloc:  widget.updatePlanBloc,
                      builder: (BuildContext context, state) {
                        if (state is UpdateSuccessState) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            widget.detailsBloc.add(
                                GetExercisesDetailsEvent(id: widget.detailsBloc.selectedDay!.id!));
                            widget.updatePlanBloc.add(const UpdatingFinishedEvent());
                            widget.updated();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text(state.message ?? "Неизвестная ошибка"),
                              ),
                            );
                          });
                        }
                        return const SizedBox();
                      },
                    )
                  ],
                ),
              );
            }
          }
          return const SizedBox();
        },
      ),
    );
  }
}
