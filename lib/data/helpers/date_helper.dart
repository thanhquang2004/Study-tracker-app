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
