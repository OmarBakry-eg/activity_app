import 'package:activity_app/src/features/home/domain/entities/activity_entity.dart';
import 'package:flutter/material.dart';

class ActivityModel extends ActivityEntity {
  const ActivityModel({
    super.activity,
    super.accessibility,
    super.type,
    super.participants,
    super.price,
    super.link,
    super.key,
    super.priorityColor,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json,
          {Color? priorityColor}) =>
      ActivityModel(
        activity: json["activity"],
        accessibility: json["accessibility"]?.toDouble(),
        type: json["type"],
        participants: json["participants"],
        price: json["price"]?.toDouble(),
        link: json["link"],
        key: json["key"],
        priorityColor: priorityColor,
      );

  factory ActivityModel.fromAnotherObjectOrFromDataOnly(
          {ActivityEntity? activityEntity,
          String? activity,
          num? accessibility,
          num? participants,
          num? price,
          String? type,
          String? link,
          String? key,
          Color? priorityColor}) =>
      ActivityModel(
          activity: activity ?? activityEntity?.activity,
          accessibility: accessibility ?? activityEntity?.accessibility,
          type: type ?? activityEntity?.type,
          participants: participants ?? activityEntity?.participants,
          price: price ?? activityEntity?.price,
          link: link ?? activityEntity?.link,
          key: key ?? activityEntity?.key,
          priorityColor: priorityColor ?? activityEntity?.priorityColor);
}
