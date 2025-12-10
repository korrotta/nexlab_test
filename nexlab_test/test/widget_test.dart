import 'package:flutter_test/flutter_test.dart';
import 'package:nexlab_test/main.dart';

void main() {
  testWidgets('App builds and shows login page', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify that login page is displayed
    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Login to continue'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
  });
}
