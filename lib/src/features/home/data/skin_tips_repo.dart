import '../../../cores/cores.dart';
import 'model/skin_tip_model.dart';

class SkinTipsRepository {
  List<SkinTip> getSkinTips() {
    return [
      SkinTip(
        id: '1',
        title: 'Hydration is Key',
        description: 'Drink 8 glasses of water daily for healthy, glowing skin',
        iconAsset: Assets.manDrinking,
      ),
      SkinTip(
        id: '2',
        title: 'Sun Protection',
        description: 'Always apply SPF, even on cloudy days',
        iconAsset: Assets.womanSun,
      ),
      SkinTip(
        id: '3',
        title: 'Night Routine',
        description: 'Never skip your nighttime skincare routine',
        iconAsset: Assets.woman,
      ),
    ];
  }
}
