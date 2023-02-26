import 'package:activity_app/src/features/activites/presentation/cubit/activity_cubit.dart';
import 'package:activity_app/src/features/home/domain/entities/activity_entity.dart';
import 'package:activity_app/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'activity_button.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.homeCubit,
    required this.activityEntity,
    required this.activityCubit,
  });

  final HomeCubit homeCubit;
  final ActivityEntity? activityEntity;
  final ActivityCubit activityCubit;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<HomeCubit, HomeState>(
        bloc: homeCubit,
        builder: (context, state) {
          return ActivityButton(
            title: activityEntity == null ? "Add" : "Update",
            onTap: () async => await activityCubit.submitFunc(activityEntity,homeCubit),
          );
        },
      ),
    );
  }
}
