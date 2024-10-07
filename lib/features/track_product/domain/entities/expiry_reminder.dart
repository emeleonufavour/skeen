enum ExpiryReminder {
  oneWeekBefore("1 week before"),
  twoWeeksBefore("2 weeks before"),
  oneMonthBefore("1 month before");

  final String value;
  const ExpiryReminder(this.value);

  String toJson() {
    return value;
  }

  static ExpiryReminder fromJson(String jsonValue) {
    return ExpiryReminder.values.firstWhere((e) => e.value == jsonValue,
        orElse: () => throw ArgumentError(
            "Invalid string for ExpiryReminder: $jsonValue"));
  }
}
