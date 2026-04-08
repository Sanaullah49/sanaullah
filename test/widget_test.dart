import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sanaullah/app.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  testWidgets('portfolio home renders key sections', (
    WidgetTester tester,
  ) async {
    VisibilityDetectorController.instance.updateInterval = Duration.zero;

    await tester.pumpWidget(const ProviderScope(child: Sanaullah()));
    await tester.pump(const Duration(milliseconds: 200));

    expect(
      find.text('Flutter apps that feel production-ready, not templated.'),
      findsOneWidget,
    );
    expect(find.text('Projects that show how I think'), findsOneWidget);
    expect(
      find.text("Let's talk about the product, not just the stack"),
      findsOneWidget,
    );
    expect(
      find.text('Real contributions, not a fake GitHub heatmap'),
      findsOneWidget,
    );

    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('portfolio home renders on mobile without layout exceptions', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    VisibilityDetectorController.instance.updateInterval = Duration.zero;

    await tester.pumpWidget(const ProviderScope(child: Sanaullah()));
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text('Work Experience'), findsOneWidget);
    expect(
      find.text('Real contributions, not a fake GitHub heatmap'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);

    await tester.pumpWidget(const SizedBox.shrink());
  });
}
