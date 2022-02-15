import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itmo_second_multimedia_lab/assets/json_resources.dart';

final assetsProvider = Provider<Map<String, String>>((ref) {
  return jsonResources;
});
