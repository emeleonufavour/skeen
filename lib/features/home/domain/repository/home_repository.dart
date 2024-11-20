import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/features.dart';

final homeRepositoryProvider = Provider<HomeRepository>(
  (ref) => HomeRepoImpl(
    homeDatasource: ref.read(homeDatasourceProvider),
  ),
);

abstract class HomeRepository {
  Future<Either<Failure, UserEntity?>> getUser();
  Future<Either<Failure, List<TipsAndTricksEntity>?>> getTipsAndTricks();
}
