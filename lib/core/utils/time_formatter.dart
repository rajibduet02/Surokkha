/// Date/time formatting utilities (relative time, display format).
abstract class TimeFormatter {
  TimeFormatter._();

  // TODO: Add formatDateTime, timeAgo, etc.
  static String format(DateTime dateTime) => dateTime.toIso8601String();
}
