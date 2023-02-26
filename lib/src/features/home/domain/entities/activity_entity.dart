import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ActivityEntity extends Equatable {
  final String? activity, type, link, key;
  final num? price, participants, accessibility;
  final Color? priorityColor;
  const ActivityEntity({
    this.activity,
    this.accessibility,
    this.type,
    this.participants,
    this.price,
    this.link,
    this.key,
    this.priorityColor
  });

  @override
  List<Object?> get props => [
        activity,
        accessibility,
        type,
        participants,
        price,
        link,
        key,
      ];
}
