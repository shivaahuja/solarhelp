import 'package:flutter_test/flutter_test.dart';
import 'package:solarhelp/src/screens/home_page.dart';

class Calculator {
  // ignore: no_leading_underscores_for_local_identifiers
  int add(int _x, int _y) => _x + _y;
}

void main() {
  test('Example Test 1', () {
    Calculator calculator = Calculator();

    int result = calculator.add(5, 6);
    expect(result, 11);
  });

  test('savings in 1 year', () {
    final double result = calcSolar('100', '32', 1)[0];
    expect(result, 800);
  });

  test('savings in 10 year', () {
    final double result = calcSolar('100', '32', 10)[0];
    expect(result, 8000);
  });
  test('average cost of electricity(3500kwH)', () {
    final double result = calcSolar('100', '32', 1)[1];
    expect(result, 320);
  });

  test('average energy produced in a day', () {
    final double result = calcSolar('100', '32', 1)[3];
    final resultInDec = result.toStringAsFixed(2);
    expect(resultInDec, '6.85');
  });

  test('average energy produced in a year', () {
    final double result = calcSolar('100', '32', 1)[2];
    final resultInDec = result.toStringAsFixed(2);
    expect(resultInDec, '2500.00');
  });
}
