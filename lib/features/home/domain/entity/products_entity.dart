// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:skeen/cores/constants/assets.dart';

class Product {
  final String name;
  final Map<String, int> scores;
  final String imagePath;
  final String url;

  Product(this.name, this.scores, this.imagePath, this.url);

  @override
  String toString() {
    return 'Product(name: $name, scores: $scores, imagePath: $imagePath, url: $url)';
  }
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
      Assets.ceraVeSASmoothingCream,
      "https://africa.cerave.com/en/our-products/moisturizers/sa-smoothing-cream"),
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
      Assets.ceraVeHydratingCleanser,
      "https://www.cerave.com/skincare/cleansers/hydrating-facial-cleanser"),
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
      Assets.ceraVeSASmoothingCleanser,
      "https://africa.cerave.com/en/our-products/cleansers/sa-smoothing-cleanser"),
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
      Assets.ceraVeFacialMoisturising,
      "https://www.cerave.com/skincare/moisturizers/am-facial-moisturizing-lotion-with-sunscreen"),
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
      Assets.niveaRadiantLuminous,
      "https://www.nivea.com.ng/products/perfect-and-radiant-luminous630-anti-dark-marks-serum-60010510044540272.html"),
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
      Assets.drRashel,
      "https://www.drrashelsa.co.za/products/dr-rashel-complete-facial-serum-set-3-pack?srsltid=AfmBOoq4iI41ndoWjOMVMXKvSNgOfGuEiljzpR1QZzbmQ8wdeDRQ7Jcw"),
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
      Assets.bentoniteClay,
      "https://www.jumia.com.ng/royal-glow-bentonite-clay-powder-cosmetics-grade-82142641.html?srsltid=AfmBOopRecziwxvR7v_sBuYZK_yw4T3z--u_uOSHMLArf7TfeKXK4fuL"),
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
      Assets.tiamSnails,
      "https://nectarbeautyhub.com/products/tiam-snail-azulene-water-essence"),
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
      Assets.niveaBodyLotion,
      "https://www.nivea.com.ng/products/nivea-perfect-and-radiant-body-lotion-40059003786060272.html"),
];
