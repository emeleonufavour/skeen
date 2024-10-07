import '../../domain/entities/expiry_reminder.dart';
import '../../domain/models/validation_result.dart';
import 'date_service.dart';

class ValidationService {
  final DateService _dateService;

  ValidationService(this._dateService);

  ValidationResult validateProductName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return ValidationResult.invalid('Product name is required');
    }
    return ValidationResult.valid();
  }

  ValidationResult validateExpiryDate(DateTime? date) {
    if (date == null) {
      return ValidationResult.invalid('Expiry date is required');
    }
    if (!_dateService.isDateInFuture(date)) {
      return ValidationResult.invalid('Expiry date must be in the future');
    }
    return ValidationResult.valid();
  }

  ValidationResult validateExpiryReminder(
    ExpiryReminder? reminder,
    DateTime? targetDate,
  ) {
    if (reminder == null) {
      return ValidationResult.invalid('Please set a reminder');
    }
    if (targetDate == null) {
      return ValidationResult.invalid('Please set an expiry date first');
    }

    final daysMap = {
      ExpiryReminder.oneWeekBefore: 7,
      ExpiryReminder.twoWeeksBefore: 14,
      ExpiryReminder.oneMonthBefore: 30,
    };

    return _dateService.checkDateDifference(targetDate, daysMap[reminder]!);
  }
}
