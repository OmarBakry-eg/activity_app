import 'package:activity_app/src/core/errors/failures.dart';
import 'package:activity_app/src/features/home/domain/entities/activity_entity.dart';
import 'package:activity_app/src/features/home/domain/usecases/get_random_activites.dart';
import 'package:activity_app/src/utils/ui/consts.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:activity_app/src/features/home/data/models/activity_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetRandomActivites getRandomActivites;
  HomeCubit({required this.getRandomActivites}) : super(HomeInitial());
  List<ActivityEntity> _activities = [];

  String get welcomeTimeMessage {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }

  Future callGetRandomActivites() async {
    emit(HomeLoading());
    final Either<Failure, List<ActivityEntity>> res =
        await getRandomActivites();
    emit(_emitFailureOrActivites(res));
  }

  void deleteActivity(ActivityEntity activityEntity) {
    emit(HomeInitial());
    _activities.remove(activityEntity);
    emit(HomeLoaded(activites: _activities));
  }

  Future<void> updateActivity(ActivityEntity? activityEntity,
      {String? activity, String? type, Color? color}) async {
    return await _updateOrAddActivityDialog(true,
        activity: activity,
        activityEntity: activityEntity,
        type: type,
        color: color);
  }

  Future<void> addActivity(
      {String? activity, String? type, Color? color}) async {
    return await _updateOrAddActivityDialog(false,
        activity: activity, activityEntity: null, type: type, color: color);
  }

  //~ PRIVATE

  Future<dynamic> _updateOrAddActivityDialog(bool update,
      {ActivityEntity? activityEntity,
      String? activity,
      String? type,
      Color? color}) async {
    return await Constants.showMessage(
        description:
            _dialogDesc(update),
        onPressed: () async {
          Constants.unFocusFunc();
          if (activityEntity == null && update) {
            return;
          }
          ActivityEntity finalActivityEntity = _createNewActivityObject(update,
              activity: activity,
              activityEntity: activityEntity,
              type: type,
              color: color);
          update
              ? _updateActivity(finalActivityEntity)
              : _addActivity(finalActivityEntity);
          Constants.hideLoading();
          _showingFinalMessageToast(update);
        });
  }
  
  String _dialogDesc(bool update)=> 'Are you sure you want to ${update ? 'update' : 'add'} this activity ?';

  Future<bool?> _showingFinalMessageToast(bool update) =>
      Fluttertoast.showToast(
          msg: "Activity ${update ? 'Updated' : 'Added'} !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);

  ActivityEntity _createNewActivityObject(bool update,
          {ActivityEntity? activityEntity,
          String? activity,
          String? type,
          Color? color}) =>
      ActivityModel.fromAnotherObjectOrFromDataOnly(
          activityEntity: activityEntity,
          activity: activity == null || activity.isEmpty
              ? activityEntity?.activity
              : activity,
          type: type == null || type.isEmpty ? activityEntity?.type : type,
          key: update
              ? activityEntity!.key
              : DateTime.now().millisecond.toStringAsFixed(4),
          priorityColor: color ?? activityEntity!.priorityColor);

  void _addActivity(ActivityEntity activityEntity) {
    emit(HomeInitial());
    _activities.add(activityEntity);
    emit(HomeLoaded(activites: _activities));
  }

  void _updateActivity(ActivityEntity activityEntity) {
    emit(HomeInitial());
    _activities[_activities.indexWhere((e) => e.key == activityEntity.key)] =
        activityEntity;
    emit(HomeLoaded(activites: _activities));
  }

  HomeState _emitFailureOrActivites(Either<Failure, List<ActivityEntity>> res) {
    return res.fold((failure) {
      Constants.showMessage(description: failure.message);
      return ErrorHomeState(message: failure.message);
    }, (activities) {
      _activities = activities;
      return HomeLoaded(activites: activities);
    });
  }
}
