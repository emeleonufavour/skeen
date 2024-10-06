class BaseEntity {
  final String message;
  final bool isSuccess;
  BaseEntity({
    required this.message,
    required this.isSuccess,
  });

  @override
  String toString() => 'BaseEntity(message: $message, isSuccess: $isSuccess)';
}
