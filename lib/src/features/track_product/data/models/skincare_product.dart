import 'package:myskin_flutterbytes/src/features/track_product/scan_product.dart';

class SkinCareProduct {
  String name;
  DateTime expiryDate;
  ExpiryReminder expiryReminder;

  SkinCareProduct(
      {required this.name,
      required this.expiryDate,
      required this.expiryReminder});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'expiryDate': expiryDate.millisecondsSinceEpoch,
      'expiryReminder': expiryReminder.toJson()
    };
  }

  factory SkinCareProduct.fromJson(Map<String, dynamic> json) {
    return SkinCareProduct(
        name: json['name'] as String,
        expiryDate:
            DateTime.fromMillisecondsSinceEpoch(json['expiryDate'] as int),
        expiryReminder: ExpiryReminder.fromJson(json['expiryReminder']));
  }
}
