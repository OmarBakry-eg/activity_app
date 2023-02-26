import 'package:activity_app/src/features/activites/presentation/cubit/activity_cubit.dart';
import 'package:activity_app/src/features/activites/presentation/widgets/activity_form_widget.dart';
import 'package:activity_app/src/features/activites/presentation/widgets/priority_color_list_widget.dart';
import 'package:activity_app/src/features/activites/presentation/widgets/submit_button.dart';
import 'package:activity_app/src/features/home/domain/entities/activity_entity.dart';
import 'package:activity_app/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:activity_app/src/utils/base/custom_app_bar.dart';
import 'package:activity_app/src/utils/ui/extension.dart';
import 'package:activity_app/src/utils/ui/my_colors.dart';
import 'package:activity_app/src/utils/ui/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:route_detector/route_detector.dart';

class AddOrEditActivityScreen extends StatelessWidget {
  final ActivityEntity? activityEntity;
  const AddOrEditActivityScreen({
    super.key,
    this.activityEntity,
  });

  @override
  Widget build(BuildContext context) {
    final ActivityCubit activityCubit = BlocProvider.of<ActivityCubit>(context);
    final HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);

    return RouteDetector(
      routeObserver: AppRoutes.routeObserver,
      onLeaveScreen: () {
        activityCubit.clearData();
      },
      onShowingScreen: () {
        activityCubit.initCubit(activityEntity);
      },
      child: Scaffold(
        appBar: const HomeAppBar(
          hideAddButton: true,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(width: 2.0, color: MyColors.borderColor),
                  boxShadow: const [
                    BoxShadow(
                      color: MyColors.shadowColor,
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: ActivityFormWidget(
                    activityCubit: activityCubit,
                    activityEntity: activityEntity),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Priority',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  color: Color(0xff172735),
                  fontWeight: FontWeight.w500,
                ),
                softWrap: false,
              ),
            ),
            PriorityColorListWidget(activityCubit: activityCubit),
            const SizedBox(
              height: 20,
            ),
            SubmitButton(
                homeCubit: homeCubit,
                activityEntity: activityEntity,
                activityCubit: activityCubit),
          ],
        )),
      ).removeFocus(context),
    );
  }
}
