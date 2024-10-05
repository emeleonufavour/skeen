import 'package:myskin_flutterbytes/src/features/onboarding/onboarding.dart';

final homeDatasourceProvider =
    Provider<HomeDatasource>((_) => HomeDatasourceImpl());

abstract class HomeDatasource {}

class HomeDatasourceImpl extends HomeDatasource {}
