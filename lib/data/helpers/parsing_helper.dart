String parseString(dynamic data) {
  if (data == null){
    return '';
  }
  if (data is String) {
    return data;
  } else if (data is int || data is double || data is bool || data is List || data is Map) {
    return data.toString();
  } else {
    throw ArgumentError('Invaldata type for data: ${data.runtimeType}');
  }
 
}

 bool parseBool(dynamic value) => value is bool ? value : false;