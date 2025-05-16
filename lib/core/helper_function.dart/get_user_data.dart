import 'dart:convert';

import '../../features/auth/data/models/user_model.dart';
import 'cache_helper.dart';

UserModel getUserData() {
  final cachedData = CacheHelper.getData(key: 'kSaveUserDataKey');

  if (cachedData == null) {
    throw Exception("No user data found in cache");
  }

  if (cachedData is! String) {
    throw FormatException("Cached data is not a valid JSON string");
  }

  try {
    return UserModel.fromJson(jsonDecode(cachedData));
  } catch (e) {
    throw FormatException("Failed to decode cached user data: $e");
  }
}