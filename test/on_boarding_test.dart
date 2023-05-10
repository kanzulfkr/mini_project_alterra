import 'package:bahanku/view/onboarding/login_new.dart';
import 'package:bahanku/view/onboarding/on_boarding.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  group(
    'On Boarding Widget test',
    () {
      testWidgets(
        'Find class',
        (WidgetTester tester) async {
          await tester.pumpWidget(const MaterialApp(home: OnBoarding()));
          expect(find.byType(OnBoarding), findsOneWidget);
          expect(find.byType(LoginPage), findsOneWidget);
        },
      );
      testWidgets('Find text', (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: OnBoarding()));
        expect(find.text('Sign In'), findsNWidgets(3));
        expect(find.text('Sign Up'), findsOneWidget);
        expect(find.text('Email'), findsOneWidget);
        expect(find.text('Password'), findsOneWidget);
        expect(find.text('Forgot password'), findsOneWidget);
        expect(find.text('Not me'), findsOneWidget);
      });
      testWidgets(
        'Find widget',
        (WidgetTester tester) async {
          await tester.pumpWidget(const MaterialApp(home: OnBoarding()));
          expect(find.byType(TextFormField), findsNWidgets(2));
          expect(find.byType(Form), findsOneWidget);
          expect(find.byType(Row), findsOneWidget);
          expect(find.byType(Container), findsNWidgets(4));
          expect(find.byType(Tab), findsNWidgets(3));
        },
      );
      testWidgets(
        'Find text Style Not me',
        (WidgetTester tester) async {
          await tester.pumpWidget(const MaterialApp(home: OnBoarding()));
          final text = tester.widget<Text>(find.text('Not me'));
          expect(text.style!.color, Colors.grey);
          expect(text.style!.fontSize, 15);
        },
      );
      testWidgets(
        'Find text Style Forgot password',
        (WidgetTester tester) async {
          await tester.pumpWidget(const MaterialApp(home: OnBoarding()));
          final text = tester.widget<Text>(find.text('Forgot password'));
          expect(text.style!.color, Colors.blueAccent);
          expect(text.style!.fontSize, 15);
        },
      );
    },
  );
}
