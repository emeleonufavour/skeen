import 'package:skeen/cores/constants/assets.dart';

class Product {
  final String name;
  final Map<String, int> scores;
  final String imagePath;

  Product(this.name, this.scores, this.imagePath);
}

final List<Product> allProducts = [
  Product(
      'Cerave SA Smoothing Cream',
      {
        'Moisturization': 9,
        'Reduce Acne': 8,
        'Oil control': 7,
        'Sun protection': 0,
        'Exfoliation': 9,
        'Redness reduction': 7,
        'Detoxification': 6,
      },
      Assets.ceraVeSASmoothingCream),
  Product(
      'Cerave Hydrating Cleanser',
      {
        'Moisturization': 8,
        'Reduce Acne': 3,
        'Oil control': 2,
        'Sun protection': 2,
        'Exfoliation': 8,
        'Redness reduction': 4,
        'Detoxification': 4,
      },
      Assets.ceraVeHydratingCleanser),
  Product(
      'Crave SA Smoothing cleanser',
      {
        'Moisturization': 7,
        'Reduce Acne': 8,
        'Oil control': 7,
        'Sun protection': 0,
        'Exfoliation': 7,
        'Redness reduction': 7,
        'Detoxification': 5,
      },
      Assets.ceraVeSASmoothingCleanser),
  Product(
      'CeraVe Facial Moisturising Cream with SPF',
      {
        'Moisturization': 8,
        'Reduce Acne': 3,
        'Oil control': 2,
        'Sun protection': 2,
        'Exfoliation': 8,
        'Redness reduction': 4,
        'Detoxification': 4,
      },
      Assets.ceraVeFacialMoisturising),
  Product(
      'NIVEA Perfect and Radiant Luminous 360 Anti Dark Mark',
      {
        'Moisturization': 6,
        'Reduce Acne': 3,
        'Oil control': 3,
        'Sun protection': 8,
        'Exfoliation': 6,
        'Redness reduction': 4,
        'Detoxification': 5,
      },
      Assets.niveaRadiantLuminous),
  Product(
      'Dr. Rashel 3 in 1 facial serum set',
      {
        'Moisturization': 7,
        'Reduce Acne': 8,
        'Oil control': 5,
        'Sun protection': 0,
        'Exfoliation': 7,
        'Redness reduction': 6,
        'Detoxification': 7,
      },
      Assets.drRashel),
  Product(
      'Royal glow bentonite clay powder',
      {
        'Moisturization': 1,
        'Reduce Acne': 7,
        'Oil control': 8,
        'Sun protection': 0,
        'Exfoliation': 1,
        'Redness reduction': 4,
        'Detoxification': 9,
      },
      Assets.bentoniteClay),
  Product(
      'Tiam slim Azunlene Water Essense',
      {
        'Moisturization': 8,
        'Reduce Acne': 5,
        'Oil control': 3,
        'Sun protection': 0,
        'Exfoliation': 8,
        'Redness reduction': 8,
        'Detoxification': 6,
      },
      Assets.tiamSnails),
  Product(
      'Nivea Perfect and Radiant Body Lotion.',
      {
        'Moisturization': 7,
        'Reduce Acne': 3,
        'Oil control': 3,
        'Sun protection': 6,
        'Exfoliation': 7,
        'Redness reduction': 4,
        'Detoxification': 5,
      },
      Assets.niveaBodyLotion),
];
