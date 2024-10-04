import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/skin_tip_model.dart';
import '../../data/skin_tips_repo.dart';

final skinTipsRepositoryProvider = Provider<SkinTipsRepository>((ref) {
  return SkinTipsRepository();
});

final skinTipsProvider = Provider<List<SkinTip>>((ref) {
  final repository = ref.watch(skinTipsRepositoryProvider);
  return repository.getSkinTips();
});

final currentTipIndexProvider = StateProvider<int>((ref) => 0);
