String formatDateToString(String date) {
  DateTime parsedDate = DateTime.parse(date);
  String formattedDate =
      "${parsedDate.day}/${parsedDate.month}/${parsedDate.year}";
  return formattedDate;
}

DateTime formatStringToDateTime(String date) {
  DateTime parsedDate = DateTime.parse(date);
  return parsedDate;
}
 /// Parses duration string (e.g., "3 days", "1 week") to Duration
  Duration parseDuration(String time) {
    final parts = time.trim().split(' ');
    if (parts.isEmpty) return const Duration(days: 1);

    final value = int.tryParse(parts[0]) ?? 1;
    final unit = parts.length > 1 ? parts[1].toLowerCase() : 'day';

    switch (unit) {
      case 'day':
      case 'days':
        return Duration(days: value);
      case 'week':
      case 'weeks':
        return Duration(days: value * 7);
      case 'month':
      case 'months':
        return Duration(days: value * 30); // Approximate
      default:
        return const Duration(days: 1);
    }
  } 