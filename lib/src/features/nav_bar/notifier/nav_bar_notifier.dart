import 'package:flutter_riverpod/flutter_riverpod.dart';

final navNotifier =
    NotifierProvider<NavBarNotifier, int>(NavBarNotifier.new);

class NavBarNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void setNavBarIndex(int index) {
    state = index;
  }
}
