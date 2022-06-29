import 'package:smart_home/utils/display_strings_util.dart';
import 'package:test/test.dart';

void main() {
  group('DisplayStringsUtil', () {
    group('getValueWithCorrectDecimals', () {
      test('returns the value unchanged if showDecimal is true', () {
        const value = 10.05;
        const showDecimal = true;
        final actual = DisplayStringsUtil.getValueWithCorrectDecimals(
            value: value, showDecimal: showDecimal);
        const expected = value;

        expect(actual, expected);
      });

      test('returns the a rounded value if showDecimal is false', () {
        const value = 10.05;
        const showDecimal = false;
        final actual = DisplayStringsUtil.getValueWithCorrectDecimals(
            value: value, showDecimal: showDecimal);
        const expected = 10;

        expect(actual, expected);
      });
    });

    group('getFullUnitAndValue', () {
      test('shows unit first with showUnitFirst set to true', () {
        const value = 10.05;
        const unit = 'Ch ';
        const showUnitFirst = true;
        const showDecimal = false;

        final actual = DisplayStringsUtil.getFullUnitAndValue(
            value: value,
            unit: unit,
            showUnitFirst: showUnitFirst,
            showDecimal: showDecimal);

        const expected = 'Ch 10';

        expect(actual, expected);
      });

      test('shows value first with showUnitFirst set to false', () {
        const value = 10.05;
        const unit = 'm';
        const showUnitFirst = false;
        const showDecimal = false;

        final actual = DisplayStringsUtil.getFullUnitAndValue(
            value: value,
            unit: unit,
            showUnitFirst: showUnitFirst,
            showDecimal: showDecimal);

        const expected = '10m';

        expect(actual, expected);
      });
    });

    group('getNormalLevelInformation', () {
      test('returns empty string if maximum and minimum are null', () {
        const minimum = null;
        const maximum = null;
        const unit = 'm';
        const showUnitFirst = false;
        const showDecimal = false;

        final actual = DisplayStringsUtil.getNormalLevelInformation(
            minimum: minimum,
            maximum: maximum,
            unit: unit,
            showUnitFirst: showUnitFirst,
            showDecimal: showDecimal);

        const expected = '';

        expect(actual, expected);
      });

      test('returns correct string if maximum and minimum are equal', () {
        const minimum = 10.05;
        const maximum = 10.05;
        const unit = 'm';
        const showUnitFirst = false;
        const showDecimal = false;

        final actual = DisplayStringsUtil.getNormalLevelInformation(
            minimum: minimum,
            maximum: maximum,
            unit: unit,
            showUnitFirst: showUnitFirst,
            showDecimal: showDecimal);

        const expected = 'Normal: 10m';

        expect(actual, expected);
      });

      test('returns correct string if maximum is null and minimum is not null',
          () {
        const minimum = 10.05;
        const maximum = null;
        const unit = 'm';
        const showUnitFirst = false;
        const showDecimal = false;

        final actual = DisplayStringsUtil.getNormalLevelInformation(
            minimum: minimum,
            maximum: maximum,
            unit: unit,
            showUnitFirst: showUnitFirst,
            showDecimal: showDecimal);

        const expected = 'Normal above 10m';

        expect(actual, expected);
      });

      test('returns correct string if minimum is null and maximum is not null',
          () {
        const minimum = null;
        const maximum = 10.05;
        const unit = 'm';
        const showUnitFirst = false;
        const showDecimal = false;

        final actual = DisplayStringsUtil.getNormalLevelInformation(
            minimum: minimum,
            maximum: maximum,
            unit: unit,
            showUnitFirst: showUnitFirst,
            showDecimal: showDecimal);

        const expected = 'Normal below 10m';

        expect(actual, expected);
      });

      test('returns correct string if maximum and minimum are not equal', () {
        const minimum = 10.05;
        const maximum = 20.05;
        const unit = 'm';
        const showUnitFirst = false;
        const showDecimal = false;

        final actual = DisplayStringsUtil.getNormalLevelInformation(
            minimum: minimum,
            maximum: maximum,
            unit: unit,
            showUnitFirst: showUnitFirst,
            showDecimal: showDecimal);

        const expected = 'Normal: 10m - 20m';

        expect(actual, expected);
      });
    });
  });
}
