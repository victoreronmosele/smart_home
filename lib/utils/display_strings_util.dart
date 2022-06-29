import 'package:flutter/material.dart';

class DisplayStringsUtil {
  /// Returns the [value] with the right decimal places
  ///
  /// If [showDecimal] is `true`, the value is returned as is
  /// If [showDecimal] is `false`, the value is rounded to the nearest integer
  @visibleForTesting
  static num getValueWithCorrectDecimals(
      {required double value, required bool showDecimal}) {
    if (showDecimal) {
      return value;
    } else {
      return value.round();
    }
  }

  /// Returns the [value] with the right unit and value order
  static String getFullUnitAndValue({
    required double value,
    required String unit,
    required bool showUnitFirst,
    required bool showDecimal,
  }) {
    final routineValueToDisplay =
        getValueWithCorrectDecimals(value: value, showDecimal: showDecimal);

    return showUnitFirst
        ? '$unit$routineValueToDisplay'
        : '$routineValueToDisplay$unit';
  }

  /// Returns normal level information as a friendly string
  static String getNormalLevelInformation({
    double? minimum,
    double? maximum,
    required String unit,
    required bool showUnitFirst,
    required bool showDecimal,
  }) {
    if (maximum == null && minimum == null) {
      return '';
    }

    final minimumValueToDisplay = minimum == null
        ? null
        : getFullUnitAndValue(
            value: minimum,
            unit: unit,
            showUnitFirst: showUnitFirst,
            showDecimal: showDecimal);

    final maximumValueToDisplay = maximum == null
        ? null
        : getFullUnitAndValue(
            value: maximum,
            unit: unit,
            showUnitFirst: showUnitFirst,
            showDecimal: showDecimal);

    String stringRepresentation = 'Normal';

    if (maximum == minimum) {
      stringRepresentation += ': $minimumValueToDisplay';
      return stringRepresentation;
    }

    if (maximum == null) {
      stringRepresentation += ' above $minimumValueToDisplay';
      return stringRepresentation;
    }

    if (minimum == null) {
      stringRepresentation += ' below $maximumValueToDisplay';
      return stringRepresentation;
    }

    stringRepresentation +=
        ': $minimumValueToDisplay - $maximumValueToDisplay';
    return stringRepresentation;
  }
}
