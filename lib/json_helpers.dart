import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<Map<String, dynamic>> loadJsonData() async {
  String jsonString = await rootBundle.loadString('assets/output.json');
  Map<String, dynamic> jsonData = jsonDecode(jsonString);
  return jsonData.map((key, value) => MapEntry(key, Map<String, dynamic>.from(value as Map)));
}
