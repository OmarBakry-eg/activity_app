import 'package:activity_app/src/features/home/domain/entities/activity_entity.dart';
import 'package:activity_app/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:activity_app/src/utils/ui/consts.dart';
import 'package:activity_app/src/utils/ui/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/logger.dart';

part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  ActivityCubit() : super(ActivityInitial());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController activityQuoteTextController = TextEditingController(),
      activityTypeTextController = TextEditingController();
  int? selectedActivityColor;

  void initCubit(ActivityEntity? activityEntity) {
    logInfo("INIT CUBIT CALLED");
    if (activityEntity?.priorityColor != null) {
      selectedActivityColor =
          MyColors.priorityColors.indexOf(activityEntity!.priorityColor!);
      emit(ActivityColorChanged());
    }
  }

  void selectPriority(int i) {
    emit(ActivityInitial());
    selectedActivityColor = i;
    logInfo("selectedActivityColor index $selectedActivityColor");
    emit(ActivityColorChanged());
  }

  void clearData() {
    activityQuoteTextController.clear();
    activityTypeTextController.clear();
    selectedActivityColor = null;
  }

  Future<void> submitFunc(ActivityEntity? activityEntity,HomeCubit homeCubit) async {
    if (formKey.currentState!.validate()) {
      if (selectedActivityColor == null) {
        return await _priorityErrorMessage();
      }
      if (activityEntity != null) {
        return await _updateActivityLogic(activityEntity,homeCubit);
      }
      return await _addActivityLogic(homeCubit);
    }
  }

  //~ PRIVATE

  Future<void> _updateActivityLogic(ActivityEntity activityEntity,HomeCubit homeCubit) async {
    await homeCubit.updateActivity(activityEntity,
        activity: activityQuoteTextController.text,
        type: activityTypeTextController.text,
        color: MyColors.priorityColors[selectedActivityColor!]);
  }

  Future<void> _addActivityLogic(HomeCubit homeCubit) async {
    await homeCubit.addActivity(
        activity: activityQuoteTextController.text,
        type: activityTypeTextController.text,
        color: MyColors.priorityColors[selectedActivityColor!]);
  }

  Future<dynamic> _priorityErrorMessage() async {
    return await Constants.showMessage(
        description: 'Please select the priority for this activity');
  }
}
