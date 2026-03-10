// Basic Flutter widget test for the app shell.
// Use WidgetTester to interact with widgets and verify behavior.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:surokkha_app/main.dart';

void main() {
  testWidgets('App starts with GetMaterialApp', (WidgetTester tester) async {
    await tester.pumpWidget(const SurokkhaApp());
    expect(find.byType(GetMaterialApp), findsOneWidget);
  });
}
