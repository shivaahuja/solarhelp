import 'package:flutter_test/flutter_test.dart';
import 'package:solarhelp/src/screens/home_page.dart';

class Calculator {
  // ignore: no_leading_underscores_for_local_identifiers
  int add(int _x, int _y) => _x + _y;
}

void main() {
  test('Example Test ', () {
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
  test('Total Cost of Solar Panels', () {
    final double result = calcSolar('100', '32', 1)[1];
    expect(result, 10000);
  });

  test('Break even point', () {
    final double result = calcSolar('100', '32', 1)[2];
    final resultInDec = result.toStringAsFixed(2);
    expect(resultInDec, '12.50');
  });

  test('Net profit after 40 years', () {
    final double result = calcSolar('100', '32', 40)[3];
    final resultInDec = result.toStringAsFixed(2);
    expect(resultInDec, '22000.00');
  });
}
