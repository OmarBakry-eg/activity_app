import 'package:activity_app/src/features/home/domain/entities/activity_entity.dart';
import 'package:activity_app/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:activity_app/src/utils/ui/consts.dart';
import 'package:activity_app/src/utils/ui/routing/route_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;
import 'slidable_home_widget.dart';

class ActivityWidget extends StatelessWidget {
  final ActivityEntity activityEntity;
  const ActivityWidget({super.key, required this.activityEntity});

  @override
  Widget build(BuildContext context) {
    final HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
    return SlidableWidget(
      onDeletePressed: (c) {
        homeCubit.deleteActivity(activityEntity);
      },
      onEditPressed: (c) {
        Constants.navigateTo(RouteStrings.activityPageString,
            extra: activityEntity);
      },
      child: ListTile(
        onTap: () => Constants.navigateTo(RouteStrings.activityPageString,
            extra: activityEntity),
        trailing: SizedBox(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  activityEntity.type ?? "",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  color: activityEntity.priorityColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
        leading: Text(
          activityEntity.key ?? intl.DateFormat.yMd().format(DateTime.now()),
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 15,
            color: Color(0xde172735),
            fontWeight: FontWeight.w500,
          ),
          softWrap: false,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              activityEntity.activity ?? "",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              activityEntity.link ?? activityEntity.price?.toString() ?? "",
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
