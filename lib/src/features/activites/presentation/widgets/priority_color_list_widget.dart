
import 'package:activity_app/src/features/activites/presentation/cubit/activity_cubit.dart';
import 'package:activity_app/src/utils/ui/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PriorityColorListWidget extends StatelessWidget {
  const PriorityColorListWidget({
    super.key,
    required this.activityCubit,
  });

  final ActivityCubit activityCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border:
                  Border.all(width: 2.0, color: MyColors.borderColor),
              boxShadow: const [
                BoxShadow(
                  color: MyColors.shadowColor,
                  offset: Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
            ),
            child: ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (c, i) =>
                    BlocBuilder<ActivityCubit, ActivityState>(
                      bloc: activityCubit,
                      builder: (context, state) {
                        return InkWell(
                          onTap: () {
                            activityCubit.selectPriority(i);
                          },
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              border:
                                  activityCubit.selectedActivityColor !=
                                          i
                                      ? null
                                      : Border.all(
                                          color: Colors.black45,
                                          width: 2),
                              color: MyColors.priorityColors[i],
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      },
                    ),
                separatorBuilder: (c, i) => const SizedBox(
                      width: 20,
                    ),
                itemCount: MyColors.priorityColors.length)));
  }
}