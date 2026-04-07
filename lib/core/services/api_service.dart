import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';

/// Outcome of a sign-in request (OTP send / account lookup).
class SignInResult {
  const SignInResult._({
    required this.success,
    this.statusCode,
    this.message,
    this.body,
  });

  final bool success;
  final int? statusCode;
  final String? message;
  final Map<String, dynamic>? body;

  factory SignInResult.ok(Map<String, dynamic>? body) =>
      SignInResult._(success: true, body: body);

  factory SignInResult.fail(int? statusCode, String message) =>
      SignInResult._(success: false, statusCode: statusCode, message: message);
}

/// Outcome of verify-OTP (session + profile hints).
class VerifyOtpResult {
  const VerifyOtpResult._({
    required this.success,
    this.statusCode,
    this.message,
    this.token,
    this.needsAccountType = true,
    this.body,
  });

  final bool success;
  final int? statusCode;
  final String? message;
  final String? token;
  /// When true, send user to account-type onboarding; when false, go to main app.
  final bool needsAccountType;
  final Map<String, dynamic>? body;

  factory VerifyOtpResult.ok({
    required String? token,
    required bool needsAccountType,
    Map<String, dynamic>? body,
  }) =>
      VerifyOtpResult._(
        success: true,
        token: token,
        needsAccountType: needsAccountType,
        body: body,
      );

  factory VerifyOtpResult.fail(int? statusCode, String message) =>
      VerifyOtpResult._(
        success: false,
        statusCode: statusCode,
        message: message,
      );
}

/// HTTP client for Shurokkha API.
class ApiService extends GetxService {
  Uri _uri(String path) {
    final base = ApiConstants.baseUrl.replaceAll(RegExp(r'/+$'), '');
    final p = path.startsWith('/') ? path : '/$path';
    return Uri.parse('$base$p');
  }

  static String _messageFromBody(Map<String, dynamic>? json) {
    if (json == null) return 'Something went wrong. Please try again.';
    for (final key in ['message', 'error', 'detail', 'msg']) {
      final v = json[key];
      if (v is String && v.isNotEmpty) return v;
    }
    return 'Something went wrong. Please try again.';
  }

  /// API returns `{ "status": true|false, "message": "...", "data": ... }`.
  static bool _envelopeOk(Map<String, dynamic>? decoded) {
    if (decoded == null) return true;
    if (!decoded.containsKey('status')) return true;
    return decoded['status'] == true;
  }

  static Map<String, dynamic>? _dataMap(Map<String, dynamic>? decoded) {
    final d = decoded?['data'];
    return d is Map<String, dynamic> ? d : null;
  }

  static String? _tokenFromData(Map<String, dynamic>? data) {
    if (data == null) return null;
    final t = data['token'];
    if (t is String && t.isNotEmpty) return t;
    final user = data['user'];
    if (user is Map<String, dynamic>) {
      final api = user['api_token'];
      if (api is String && api.isNotEmpty) return api;
    }
    return null;
  }

  static bool _needsAccountTypeFromData(Map<String, dynamic>? data) {
    if (data == null) return true;
    final n = data['needs_account_type'];
    if (n is bool) return n;
    return true;
  }

  /// POST `/signin` with `{ "phone_no": "<digits>" }`.
  Future<SignInResult> signIn(String phoneNo) async {
    final uri = _uri(ApiConstants.signInPath);
    final payload = jsonEncode({'phone_no': phoneNo});
    debugPrint('[ApiService.signIn] POST $uri');
    debugPrint('[ApiService.signIn] body: $payload');
    try {
      final response = await http
          .post(
            uri,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: payload,
          )
          .timeout(const Duration(seconds: 30));

      debugPrint(
        '[ApiService.signIn] response status=${response.statusCode} body=${response.body}',
      );

      Map<String, dynamic>? decoded;
      if (response.body.isNotEmpty) {
        try {
          final raw = jsonDecode(response.body);
          if (raw is Map<String, dynamic>) decoded = raw;
        } catch (_) {
          /* non-JSON body */
        }
      }

      if (response.statusCode < 200 || response.statusCode >= 300) {
        return SignInResult.fail(
          response.statusCode,
          _messageFromBody(decoded),
        );
      }

      if (!_envelopeOk(decoded)) {
        return SignInResult.fail(
          response.statusCode,
          _messageFromBody(decoded),
        );
      }

      return SignInResult.ok(decoded);
    } on http.ClientException catch (e) {
      debugPrint('[ApiService.signIn] ClientException: ${e.message}');
      return SignInResult.fail(null, e.message);
    } catch (e, st) {
      debugPrint('[ApiService.signIn] error: $e\n$st');
      return SignInResult.fail(null, e.toString());
    }
  }

  /// POST `/verify-otp` with `{ "phone_no": "...", "otp": "123456" }`.
  Future<VerifyOtpResult> verifyOtp(String phoneNo, String otp) async {
    final uri = _uri(ApiConstants.verifyOtpPath);
    final payload = jsonEncode({'phone_no': phoneNo, 'otp': otp});
    debugPrint('[ApiService.verifyOtp] POST $uri');
    debugPrint('[ApiService.verifyOtp] body: $payload');
    try {
      final response = await http
          .post(
            uri,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: payload,
          )
          .timeout(const Duration(seconds: 30));

      debugPrint(
        '[ApiService.verifyOtp] response status=${response.statusCode} body=${response.body}',
      );

      Map<String, dynamic>? decoded;
      if (response.body.isNotEmpty) {
        try {
          final raw = jsonDecode(response.body);
          if (raw is Map<String, dynamic>) decoded = raw;
        } catch (_) {
          /* non-JSON body */
        }
      }

      if (response.statusCode < 200 || response.statusCode >= 300) {
        return VerifyOtpResult.fail(
          response.statusCode,
          _messageFromBody(decoded),
        );
      }

      if (!_envelopeOk(decoded)) {
        return VerifyOtpResult.fail(
          response.statusCode,
          _messageFromBody(decoded),
        );
      }

      final data = _dataMap(decoded);
      return VerifyOtpResult.ok(
        token: _tokenFromData(data),
        needsAccountType: _needsAccountTypeFromData(data),
        body: decoded,
      );
    } on http.ClientException catch (e) {
      debugPrint('[ApiService.verifyOtp] ClientException: ${e.message}');
      return VerifyOtpResult.fail(null, e.message);
    } catch (e, st) {
      debugPrint('[ApiService.verifyOtp] error: $e\n$st');
      return VerifyOtpResult.fail(null, e.toString());
    }
  }
}
