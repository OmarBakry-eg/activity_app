import 'dart:math';
import 'package:activity_app/src/core/dio/dio_client.dart';
import 'package:activity_app/src/core/dio/result.dart';
import 'package:activity_app/src/core/errors/exceptions.dart';
import 'package:activity_app/src/features/home/data/models/activity_model.dart';
import '../../../../utils/ui/my_colors.dart';

abstract class HomeRemoteActivites {
  Future<List<ActivityModel>> getRandomActivites();
}

class HomeRemoteActivitesImpl implements HomeRemoteActivites {
  final DioClient dioClient;

  const HomeRemoteActivitesImpl(this.dioClient);

  @override
  Future<List<ActivityModel>> getRandomActivites() async {
    List<ActivityModel> activites = [];
    List<Result> res =  await Future.wait([
      dioClient.get(),
      dioClient.get(),
      dioClient.get(),
      dioClient.get(),
      dioClient.get()
    ]);
    for (Result result in res) {
      if (result is SuccessState) {
        final ActivityModel activityModel = ActivityModel.fromJson(result.value,
            priorityColor: MyColors.priorityColors[
                Random().nextInt(MyColors.priorityColors.length)]);
        activites.add(activityModel);
      } else if (result is ErrorState) {
        throw ServerException(message: result.msg.toString());
      } else {
        throw ServerException();
      }
    }
    return activites;
  }
}
