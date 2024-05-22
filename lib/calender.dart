import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Calendar {
  final int year;
  final int month;
  final int day;
  final bool isSelect;

  const Calendar({
    required this.year,
    required this.month,
    required this.day,
    this.isSelect = false,
  });

  bool get isSelected {
    return isSelect;
  }

  bool get isToday {
    DateTime today = DateTime.now();
    return today.year == year && today.month == month && today.day == day;
  }
}
