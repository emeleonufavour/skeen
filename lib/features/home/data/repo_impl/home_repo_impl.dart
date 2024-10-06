import 'package:fpdart/fpdart.dart';

import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/features.dart';

class HomeRepoImpl extends HomeRepository with RepositoryErrorHandler {
  final HomeDatasource _homeDatasource;

  HomeRepoImpl({
    required HomeDatasource homeDatasource,
  }) : _homeDatasource = homeDatasource;

  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    return callAction(() => _homeDatasource.getUser());
  }

  @override
  Future<Either<Failure, List<TipsAndTricksEntity>>> getTipsAndTricks() async {
    return callAction(() => _homeDatasource.getTipsAndTricks());
  }
}
