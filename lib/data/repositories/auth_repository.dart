import 'package:get/get.dart';

import '../models/user_model.dart';

/// Auth-related data: login, logout, refresh token, get profile.
class AuthRepository extends GetxService {
  Future<UserModel?> getCurrentUser() async => null;
  // TODO: login, logout, register
}
