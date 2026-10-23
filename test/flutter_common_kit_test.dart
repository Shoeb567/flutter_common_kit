import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_common_kit/flutter_common_kit.dart';

void main() {
  group('Validators Tests', () {
    test('required validator', () {
      expect(Validators.required(null), isNotNull);
      expect(Validators.required(''), isNotNull);
      expect(Validators.required('   '), isNotNull);
      expect(Validators.required('hello'), isNull);
    });

    test('email validator', () {
      expect(Validators.email('test@example.com'), isNull);
      expect(Validators.email('invalid-email'), isNotNull);
      expect(Validators.email('user@domain'), isNotNull);
      expect(Validators.email(null), isNull); // empty allowed if not marked required
    });

    test('phone validator', () {
      expect(Validators.phone('+1234567890'), isNull);
      expect(Validators.phone('1234567890'), isNull);
      expect(Validators.phone('123'), isNotNull);
      expect(Validators.phone('abc'), isNotNull);
    });

    test('minLength and maxLength validators', () {
      expect(Validators.minLength('ab', 3), isNotNull);
      expect(Validators.minLength('abc', 3), isNull);
      expect(Validators.maxLength('abcd', 3), isNotNull);
      expect(Validators.maxLength('abc', 3), isNull);
    });

    test('password validator', () {
      expect(Validators.password('weak'), isNotNull);
      expect(Validators.password('StrongPass123'), isNull);
      expect(Validators.password('alllowercase1', requireUppercase: true), isNotNull);
      expect(Validators.password('NoDigitPass', requireDigit: true), isNotNull);
    });

    test('confirmPassword validator', () {
      expect(Validators.confirmPassword('pass', 'pass'), isNull);
      expect(Validators.confirmPassword('pass1', 'pass2'), isNotNull);
    });

    test('compose validator', () {
      final composed = Validators.compose([
        Validators.required,
        Validators.email,
      ]);

      expect(composed(''), 'This field is required.');
      expect(composed('invalid'), 'Please enter a valid email address.');
      expect(composed('valid@test.com'), isNull);
    });
  });

  group('JsonUtils Tests', () {
    test('safe conversions', () {
      expect(JsonUtils.safeString(123), '123');
      expect(JsonUtils.safeString(null, 'default'), 'default');

      expect(JsonUtils.safeInt('42'), 42);
      expect(JsonUtils.safeInt(null, 10), 10);
      expect(JsonUtils.safeInt('not_int', 5), 5);

      expect(JsonUtils.safeDouble('3.14'), 3.14);
      expect(JsonUtils.safeDouble(null, 1.0), 1.0);

      expect(JsonUtils.safeBool('true'), true);
      expect(JsonUtils.safeBool('1'), true);
      expect(JsonUtils.safeBool('false'), false);
      expect(JsonUtils.safeBool(null, true), true);

      expect(JsonUtils.safeList<String>(['a', 'b']), ['a', 'b']);
      expect(JsonUtils.safeMap({'key': 'val'}), {'key': 'val'});
    });
  });

  group('DateTimeUtils & CurrencyUtils Tests', () {
    test('DateTime formatting', () {
      final date = DateTime(2025, 1, 15, 10, 30);
      expect(DateTimeUtils.format(date, format: 'yyyy-MM-dd'), '2025-01-15');
      expect(DateTimeUtils.isSameDay(date, DateTime(2025, 1, 15, 23, 59)), isTrue);
      expect(DateTimeUtils.isSameDay(date, DateTime(2025, 1, 16)), isFalse);
    });

    test('Currency formatting', () {
      final formatted = CurrencyUtils.format(1500.50, symbol: '\$');
      expect(formatted, '\$1,500.50');
      expect(CurrencyUtils.formatCompact(1500), '1.5K');
    });
  });

  group('Models & Result Tests', () {
    test('ApiResponse success and failure', () {
      final success = ApiResponse<String>.success(data: 'data', message: 'ok');
      expect(success.isSuccess, isTrue);
      expect(success.data, 'data');

      final failure = ApiResponse<String>.failure(message: 'error', statusCode: 404);
      expect(failure.isSuccess, isFalse);
      expect(failure.statusCode, 404);
    });

    test('ApiResult pattern matching', () {
      const ApiResult<int> successResult = Success(100);
      final val = successResult.when(
        success: (d) => d * 2,
        failure: (e) => 0,
      );
      expect(val, 200);

      const ApiResult<int> failureResult = Failure(
        AppError(message: 'Failed', type: ErrorType.badRequest),
      );
      expect(failureResult.isFailure, isTrue);
      expect(failureResult.errorOrNull?.message, 'Failed');
    });

    test('PaginationModel parsing', () {
      final json = {
        'items': ['one', 'two'],
        'page': 1,
        'total': 10,
        'limit': 2,
        'total_pages': 5,
      };
      final pagination = PaginationModel<String>.fromJson(
        json: json,
        fromItemJson: (item) => item.toString(),
      );
      expect(pagination.items.length, 2);
      expect(pagination.hasMore, isTrue);
      expect(pagination.totalPages, 5);
    });
  });

  group('Widget Tests', () {
    testWidgets('CommonButton displays text and handles tap', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommonButton(
              text: 'Click Me',
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );

      expect(find.text('Click Me'), findsOneWidget);
      await tester.tap(find.text('Click Me'));
      await tester.pump();
      expect(tapped, isTrue);
    });

    testWidgets('CommonButton displays loading spinner when isLoading=true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommonButton(
              text: 'Loading',
              isLoading: true,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading'), findsNothing);
    });

    testWidgets('CommonTextField enters text and validates', (tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommonTextField(
              controller: controller,
              label: 'Username',
              hint: 'Enter username',
            ),
          ),
        ),
      );

      expect(find.text('Username'), findsOneWidget);
      expect(find.text('Enter username'), findsOneWidget);

      await tester.enterText(find.byType(CommonTextField), 'JohnDoe');
      expect(controller.text, 'JohnDoe');
    });

    testWidgets('CommonLoader displays message', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CommonLoader(message: 'Please wait...'),
          ),
        ),
      );

      expect(find.text('Please wait...'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('CommonErrorWidget displays message and triggers retry', (tester) async {
      bool retried = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommonErrorWidget(
              message: 'Failed to load',
              onRetry: () => retried = true,
            ),
          ),
        ),
      );

      expect(find.text('Failed to load'), findsOneWidget);
      await tester.tap(find.text('Try Again'));
      await tester.pump();
      expect(retried, isTrue);
    });

    testWidgets('CommonEmptyWidget displays title and message', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CommonEmptyWidget(
              title: 'Empty List',
              message: 'No items currently',
            ),
          ),
        ),
      );

      expect(find.text('Empty List'), findsOneWidget);
      expect(find.text('No items currently'), findsOneWidget);
    });

    testWidgets('NoInternetWidget renders and triggers retry', (tester) async {
      bool checked = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NoInternetWidget(
              onRetry: () => checked = true,
            ),
          ),
        ),
      );

      expect(find.text('No Internet Connection'), findsOneWidget);
      await tester.tap(find.text('Check Again'));
      await tester.pump();
      expect(checked, isTrue);
    });
  });
}
