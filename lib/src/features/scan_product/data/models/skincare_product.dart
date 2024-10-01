class SkinCareProduct {
  String name;
  DateTime expiryDate;

  SkinCareProduct({required this.name, required this.expiryDate});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'expiryDate': expiryDate.millisecondsSinceEpoch,
    };
  }

  factory SkinCareProduct.fromJson(Map<String, dynamic> json) {
    return SkinCareProduct(
      name: json['name'] as String,
      expiryDate:
          DateTime.fromMillisecondsSinceEpoch(json['expiryDate'] as int),
    );
  }
}
