class NotificationContent {
  static String getTitle(String routineName) => 'Routine: $routineName';

  static String getBody(String routineName, String frequency) {
    switch (frequency.toLowerCase()) {
      case 'daily':
        return 'Time for your daily $routineName routine!';
      case 'weekly':
        return 'It\'s time for your weekly $routineName routine!';
      case 'monthly':
        return 'Monthly reminder: Time for your $routineName routine!';
      default:
        return 'Time for your $routineName routine!';
    }
  }
}
