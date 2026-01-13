/// Session status enum for workout sessions
enum SessionStatus {
  /// Session is currently active
  active,

  /// Session was completed successfully
  completed,

  /// Session was abandoned/cancelled
  abandoned;

  /// Convert enum to string for database storage
  String toDatabase() {
    return name;
  }

  /// Create enum from database string
  static SessionStatus fromDatabase(String value) {
    return SessionStatus.values.firstWhere(
      (status) => status.name == value,
      orElse: () => SessionStatus.abandoned,
    );
  }
}
