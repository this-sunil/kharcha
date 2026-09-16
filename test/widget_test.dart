import 'package:flutter_test/flutter_test.dart';

import 'package:kharcha/main.dart';


void main() {
  group('MyApp Widget Test', () {
    testWidgets('MyApp builds successfully', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
    });
  });
}
