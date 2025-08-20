import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String get yyyyMMdd => DateFormat('yyyy-MM-dd').format(this);

  DateTime addYearsToDate(int years) {
    return DateTime(year + years, month, day);
  }

  DateTime firstDateOfYear() {
    return DateUtils.addMonthsToMonthDate(this, -(month - 1));
  }

  DateTime lastDateOfYear() {
    return DateUtils.addMonthsToMonthDate(
      this,
      12 - (month - 1),
    ).subtract(const Duration(days: 1));
  }
}
