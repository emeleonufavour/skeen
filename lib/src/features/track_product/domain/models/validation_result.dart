class ValidationResult {
  final bool isValid;
  final String? errorMessage;

  const ValidationResult({
    required this.isValid,
    this.errorMessage,
  });

  factory ValidationResult.valid() => const ValidationResult(isValid: true);

  factory ValidationResult.invalid(String message) => ValidationResult(
        isValid: false,
        errorMessage: message,
      );
}
