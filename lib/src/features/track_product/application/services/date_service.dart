import '../../domain/models/validation_result.dart';

class DateService {
  bool isDateInFuture(DateTime date) {
    return date.isAfter(DateTime.now());
  }

  ValidationResult checkDateDifference(
      DateTime targetDate, int daysDifference) {
    DateTime currentDate = DateTime.now();
    int differenceInDays = targetDate.difference(currentDate).inDays;

    if (differenceInDays <= daysDifference) {
      return ValidationResult.invalid(
        'Reminder is less than ${daysDifference ~/ 7} week(s) before the expiry date.',
      );
    }
    return ValidationResult.valid();
  }
}
