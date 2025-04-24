import 'package:intl/intl.dart';

String formatDateTime(String dateTime) {
  try {
    DateTime parsedDate = DateTime.parse(dateTime);
    return DateFormat('dd-MM-yyyy').format(parsedDate);
  } catch (e) {
    return 'Invalid date';
  }
}
