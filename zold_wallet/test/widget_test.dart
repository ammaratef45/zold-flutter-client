import 'package:flutter_test/flutter_test.dart';

import 'package:zold_wallet/main.dart';

void main() {
  testWidgets('Btn Press test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text('Hello world'), findsOneWidget);
    expect(find.text('Hello world!'), findsNothing);

    await tester.tap(find.text('btn'));
    await tester.pump();

    expect(find.text('Hello world'), findsNothing);
    expect(find.text('Hello world!'), findsOneWidget);
  });
}
