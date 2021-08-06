DateTime? getDateValueFS(Map<String, dynamic> json, String key) {
  if (!json.containsKey(key)) {
    return null;
  }

  Map<String, dynamic> _final = json;
  return _final.containsKey(key) ? DateTime.parse(_final[key] as String) : null;
}

double? getDoubleValueFS(Map<String, dynamic> json, String key) {
  if (!json.containsKey('fields')) {
    return null;
  }

  Map<String, dynamic> _final = json['fields'];
  return _final.containsKey(key)
      ? double.parse(_final[key]['intValue'] as String)
      : null;
}

int? getIntValueFS(Map<String, dynamic> json, String key) {
  if (!json.containsKey('fields')) {
    return null;
  }
  Map<String, dynamic> _final = json['fields'];
  return _final.containsKey(key) ? int.parse(_final[key]['intValue']) : null;
}

String? getStringValueFS(Map<String, dynamic> json, String key) {
  if (!json.containsKey('fields')) {
    return json.toString();
  }
  Map<String, dynamic> _final = json['fields'];
  return _final.containsKey(key) ? _final[key]['stringValue'] : null;
}

Map<String, dynamic> getMapFS(Map<String, dynamic> json, String key) {
  if (!json.containsKey('fields')) {
    return json;
  }

  Map<String, dynamic> _final = json['fields'];
  return _final.containsKey(key) ? _final[key]['mapValue'] : _final;
}

String? getIdFS(Map<String, dynamic> json) {
  return json.containsKey('name')
      ? json['name'].toString().split('/').last
      : null;
}
