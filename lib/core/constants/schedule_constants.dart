

import 'package:flutter/material.dart';

class TimeSchedule {
  TimeSchedule(
    this.ja,
    this.en,
    this.startTime,
    this.endTime,
    this.isStartOneHour,
  );
  final String ja;
  final String en;
  final int startTime;
  final int endTime;
  final bool isStartOneHour;
}

List<TimeSchedule> timeSchedule = [
  TimeSchedule('0時-8時', 'zeroToEight', 0, 9, false),
  TimeSchedule('9:00', 'nine', 9, 18, true),
  TimeSchedule('10:00', 'ten', 10, 18, true),
  TimeSchedule('11:00', 'eleven', 11, 18, true),
  TimeSchedule('12:00', 'twelve', 12, 18, true),
  TimeSchedule(
    '13:00',
    'thirteen',
    13,
    18,
    true,
  ),
  TimeSchedule(
    '14:00',
    'fourteen',
    14,
    18,
    true,
  ),
  TimeSchedule(
    '15:00',
    'fifteen',
    15,
    18,
    true,
  ),
  TimeSchedule(
    '16:00',
    'sixteen',
    16,
    18,
    true,
  ),
  TimeSchedule(
    '17:00',
    'seventeen',
    17,
    18,
    true,
  ),
  TimeSchedule(
    '18:00',
    'eighteen',
    18,
    19,
    true,
  ),
  TimeSchedule(
    '19時-23時',
    'nineteenToTwentyThree',
    19,
    24,
    false,
  ),
];

/// **指定した `TimeOfDay` から `timeSchedule` の `en` を取得**
String? getTimeScheduleKey(TimeOfDay time) {
  return timeSchedule
      .firstWhere(
        (schedule) =>
            time.hour >= schedule.startTime && time.hour < schedule.endTime,
        orElse: () => TimeSchedule('未定', 'undefined', 0, 0, false), // デフォルト値
      )
      .en;
}

String? getTimeScheduleKeyFromDateTime(DateTime dateTime) {
  return timeSchedule
      .where((schedule) =>
          dateTime.hour >= schedule.startTime &&
          dateTime.hour < schedule.endTime)
      .reduce((bestMatch, current) =>
          current.startTime > bestMatch.startTime ? current : bestMatch)
      .en;
}