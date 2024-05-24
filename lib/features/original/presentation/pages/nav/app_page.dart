import 'package:fitness_app/core/constants/constants.dart';
import 'package:fitness_app/features/original/di/injection_container.dart';
import 'package:fitness_app/features/original/presentation/bloc/details/details_bloc.dart';
import 'package:fitness_app/features/original/presentation/bloc/details/details_event.dart';
import 'package:fitness_app/features/original/presentation/bloc/edit_plan/edit_plan_bloc.dart';
import 'package:fitness_app/features/original/presentation/bloc/edit_plan/edit_plan_event.dart';
import 'package:fitness_app/features/original/presentation/bloc/news/newsBloc.dart';
import 'package:fitness_app/features/original/presentation/bloc/plan_list//fitness_plan_bloc.dart';
import 'package:fitness_app/features/original/presentation/bloc/plan_list//fitness_plan_event.dart';
import 'package:fitness_app/features/original/presentation/bloc/update_plan/update_bloc.dart';
import 'package:fitness_app/features/original/presentation/pages/auth/login_page.dart';
import 'package:fitness_app/features/original/presentation/pages/detail/plan_detail_page.dart';
import 'package:fitness_app/features/original/presentation/pages/plan_list/plan_list.dart';
import 'package:fitness_app/features/original/presentation/widgets/nav/bottom_nav.dart';
import 'package:flutter/material.dart';

import '../news/newsPage.dart';

class AppPage extends StatefulWidget {
  AppPage({super.key});

  final FitnessPlanBloc fitnessPlanBloc = di()
    ..add(const GetFitnessPlanEvent());
  final DetailsBloc detailsBloc = di();
  final EditPlanBloc editPlanBlocAddPage = di()
    ..add(const EditEmptyPlanEvent());
  final UpdatePlanBloc updatePlanBloc = di();
  final NewsBloc newsBloc = di();

  final String route = Pages.homePage.route;

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  late String route;

  @override
  void initState() {
    // TODO: implement initState
    route = widget.route;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FPLAN",
          style: Theme.of(context).textTheme.headlineLarge!,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: (route == Pages.homePage.route)
          ? NewsPage(
              newsBloc: widget.newsBloc,
            )
          : (route == Pages.planListPage.route)
              ? PlanListPage(
                  goDetailsPage: (fitnessPlanEntity) {
                    setState(() {
                      widget.detailsBloc
                          .add(GetPlanDetailsEvent(id: fitnessPlanEntity.id!));
                      route = Pages.detailPlanPage.route;
                    });
                  },
                  fitnessPlanBloc: widget.fitnessPlanBloc,
                  deleteFromDetails: (fitnessPlanEntity) {
                    widget.detailsBloc
                        .add(GetPlanDetailsEvent(id: fitnessPlanEntity.id!));
                  },
                )
              : (route == Pages.detailPlanPage.route)
                  ? PlanDetailPage(
                      goToPlanList: () {
                        setState(() {
                          route = Pages.planListPage.route;
                        });
                      },
                      detailsBloc: widget.detailsBloc,
                      updatePlanBloc: widget.updatePlanBloc,
                      updated: () {
                        widget.fitnessPlanBloc.add(const GetFitnessPlanEvent());
                      },
                    )
                  : (route == Pages.profilePage.route)
                      ? AuthPage()
                      : SizedBox(),
      bottomNavigationBar: CustomBottomNavigation(
        route: route,
        navChanged: (String value) {
          setState(() {
            route = value;
          });
        },
      ),
    );
  }
}
