import 'package:skeen/cores/cores.dart';

/// WIDGET EXTENSIONS
extension WidgetsList on List<Widget> {
  List<Widget> separate(Widget separator) {
    List<Widget> separatedList = [];
    for (var i = 0; i < length; i++) {
      separatedList.add(this[i]);
      if (i < length - 1) {
        separatedList.add(separator);
      }
    }
    return separatedList;
  }
}

extension WidgetExtension on Widget {
  Widget expand({int? flex}) {
    return Expanded(
      flex: flex ?? 1,
      child: this,
    );
  }

  Widget padding({
    double? all,
    double? horizontal,
    double? vertical,
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    EdgeInsets edgeInsets;

    if (all != null) {
      edgeInsets = EdgeInsets.all(all);
    } else if (horizontal != null || vertical != null) {
      edgeInsets = EdgeInsets.symmetric(
        horizontal: horizontal ?? 0.0,
        vertical: vertical ?? 0.0,
      );
    } else {
      edgeInsets = EdgeInsets.only(
        left: left ?? 0.0,
        top: top ?? 0.0,
        right: right ?? 0.0,
        bottom: bottom ?? 0.0,
      );
    }

    return Padding(
      padding: edgeInsets,
      child: this,
    );
  }
}

extension NameInitials on String {
  String get initials {
    final name = trim().toLowerCase();

    final parts = name.split(RegExp(r'[\s-]+'));

    final filteredParts = parts.where((part) {
      final commonPrefixes = [
        'de',
        'van',
        'von',
        'der',
        'den',
        'le',
        'la',
        'du',
        'di'
      ];
      final commonSuffixes = ['jr', 'sr', 'ii', 'iii', 'iv', 'v'];
      return part.isNotEmpty &&
          !commonPrefixes.contains(part) &&
          !commonSuffixes.contains(part);
    }).toList();

    if (filteredParts.isEmpty) {
      return '';
    }

    String initials = filteredParts.map((part) => part[0].toUpperCase()).join();

    if (initials.length == 1 && filteredParts[0].length > 1) {
      initials += filteredParts[0][1].toUpperCase();
    }

    return initials.substring(0, initials.length.clamp(0, 3));
  }

  String get toTitleCase {
    return split(' ')
        .map((word) => word.isNotEmpty
            ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
            : '')
        .join(' ');
  }
}

extension ValidatingExtensions on String {
  String? validateAnyField({String? field}) {
    if (trim().isEmpty) {
      return '${field ?? "This"} field is required';
    }
    return null;
  }

  String? get validatePhoneNumber {
    if (trim().isEmpty) {
      return 'Phone number is required';
    }

    // Supports international format with or without '+' prefix
    // Minimum 8 digits, maximum 15 digits (international standard)
    final pattern = RegExp(r'^\+?[0-9]{8,15}$');

    if (!pattern.hasMatch(this)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? get validateFullName {
    if (trim().isEmpty) {
      return 'Full Name is required';
    }

    final RegExp pattern = RegExp(r"^[A-Za-z\'\-]{2,}(?: [A-Za-z\'\-]{2,})+$");

    if (!pattern.hasMatch(this)) {
      return 'Please enter your full name (first & last name)';
    }
    return null;
  }

  String? get validateEmail {
    if (trim().isEmpty) {
      return 'Email is required';
    }

    // RFC 5322 compliant email regex
    final pattern = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
    );

    if (!pattern.hasMatch(this)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword() {
    if (trim().isEmpty) {
      return 'Password is required';
    }

    if (length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (!contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    if (!contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    return null;
  }
}

bool isDateInFuture(DateTime date) {
  DateTime currentDate = DateTime.now();

  return date.isAfter(currentDate);
}
