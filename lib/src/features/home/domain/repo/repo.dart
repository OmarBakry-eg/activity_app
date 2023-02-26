import 'package:activity_app/src/core/errors/failures.dart';
import 'package:activity_app/src/features/home/domain/entities/activity_entity.dart';
import 'package:dartz/dartz.dart';

abstract class HomeActivityRepo {
  Future<Either<Failure, List<ActivityEntity>>> getRandomActivites();
}
