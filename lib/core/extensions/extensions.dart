import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension ColorExtensions on int {
  MaterialColor toMaterialColor() {
    return MaterialColor(this, <int, Color>{
      50: Color(this),
      100: Color(this),
      200: Color(this),
      300: Color(this),
      400: Color(this),
      500: Color(this),
      600: Color(this),
      700: Color(this),
      800: Color(this),
      900: Color(this),
    });
  }
}

extension SizedBoxExtension on int {
  SizedBox toHeight() {
    switch (this) {
      case 2:
        return const SizedBox(height: 2);
      case 4:
        return const SizedBox(height: 4);
      case 6:
        return const SizedBox(height: 6);
      case 8:
        return const SizedBox(height: 8);
      case 10:
        return const SizedBox(height: 10);
      case 12:
        return const SizedBox(height: 12);
      case 14:
        return const SizedBox(height: 14);
      case 16:
        return const SizedBox(height: 16);
      case 18:
        return const SizedBox(height: 18);
      case 20:
        return const SizedBox(height: 20);
      case 22:
        return const SizedBox(height: 22);
      case 24:
        return const SizedBox(height: 24);
      case 26:
        return const SizedBox(height: 26);
      case 28:
        return const SizedBox(height: 28);
      case 30:
        return const SizedBox(height: 30);
      case 32:
        return const SizedBox(height: 32);
      default:
        return const SizedBox(height: 0);
    }
  }

  SizedBox toWidth() {
    switch (this) {
      case 2:
        return const SizedBox(width: 2);
      case 4:
        return const SizedBox(width: 4);
      case 6:
        return const SizedBox(width: 6);
      case 8:
        return const SizedBox(width: 8);
      case 10:
        return const SizedBox(width: 10);
      case 12:
        return const SizedBox(width: 12);
      case 14:
        return const SizedBox(width: 14);
      case 16:
        return const SizedBox(width: 16);
      case 18:
        return const SizedBox(width: 18);
      case 20:
        return const SizedBox(width: 20);
      case 22:
        return const SizedBox(width: 22);
      case 24:
        return const SizedBox(width: 24);
      case 26:
        return const SizedBox(width: 26);
      case 28:
        return const SizedBox(width: 28);
      case 30:
        return const SizedBox(width: 30);
      case 32:
        return const SizedBox(width: 32);
      case 34:
        return const SizedBox(width: 34);
      default:
        return const SizedBox(width: 0);
    }
  }
}

extension DateExtensions on DateTime {
  String? toStandardDate() {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  String? toSkillDate() {
    return DateFormat('MMM yyyy').format(this);
  }

  String? toSkillDatePayload() {
    return DateFormat('yyyy-MM').format(this);
  }

  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isAfterToday {
    final today = DateTime.now();
    final normalizedToday = DateTime(today.year, today.month, today.day);
    final normalizedSelf = DateTime(year, month, day);
    return normalizedSelf.isAfter(normalizedToday);
  }

  String get toDayMonthYear => DateFormat('dd MMM yyyy').format(this);
  String get toMonthDayYear => DateFormat('MMM dd, yyyy').format(this);

  String toDay() {
    return DateFormat('E').format(this);
  }

  String toDayMonthYearTime() {
    return DateFormat('EEE, dd MMM yyyy, hh:mm aa').format(this);
  }

  String toStartTimeFormat() {
    return DateFormat.jm().format(this);
  }

  String toEndTimeFormat() {
    return DateFormat.jm().format(this);
  }

  String toMMMddyyyy() {
    return DateFormat('MMM dd, yyyy').format(this);
  }

  String toMMMddyyyyWithTime() {
    return DateFormat('MMM dd, yyyy hh:mm aa').format(this);
  }

  String toddMMyyyyWithTime() {
    return DateFormat('dd/MM/yyyy hh:mm').format(this);
  }

  String toyyyymmdd() {
    return DateFormat('yyyy/MM/dd').format(this);
  }

  String toYYYYMMDD() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String toMMMyyyy() {
    return DateFormat('MMM, yyyy').format(this);
  }

  String certificateDateFormat() {
    return DateFormat('MMM yyyy').format(this);
  }
}
