import 'package:activity_app/src/features/home/data/source/remote_source.dart';
import 'package:activity_app/src/features/home/domain/entities/activity_entity.dart';
import 'package:activity_app/src/core/errors/failures.dart';
import 'package:activity_app/src/features/home/domain/repo/repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';

class HomeActivityRepoImpl implements HomeActivityRepo {
  final HomeRemoteActivitesImpl homeRemoteActivitesImpl;
  const HomeActivityRepoImpl({required this.homeRemoteActivitesImpl});
  @override
  Future<Either<Failure, List<ActivityEntity>>> getRandomActivites() async {
    try {
      final List<ActivityEntity> activties =
          await homeRemoteActivitesImpl.getRandomActivites();
      return Right(activties);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on EmptyCacheException catch (e) {
      return Left(EmptyCacheFailure(message: e.message));
    } on OfflineException catch (e) {
      return Left(OfflineFailure(message: e.message));
    }
  }
}
