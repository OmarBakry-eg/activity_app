import 'package:activity_app/src/core/errors/failures.dart';
import 'package:activity_app/src/features/home/domain/entities/activity_entity.dart';
import 'package:activity_app/src/features/home/domain/repo/repo.dart';
import 'package:dartz/dartz.dart';

class GetRandomActivites {
  final HomeActivityRepo repo;
  const GetRandomActivites(this.repo);

  Future<Either<Failure, List<ActivityEntity>>> call() async =>
      await repo.getRandomActivites();
}
