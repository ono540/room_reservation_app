import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

TimeOfDay? stringToTimeOfDay(String? timeString) {
  if (timeString == null) return null;
  final timeParts = timeString.split(':');
  if (timeParts.length != 2) return null;
  try {
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  } catch (e) {
    return null;
  }
}

/// **`"YYYY-MM-DD HH:mm"` の `String` を `DateTime` に変換**
DateTime stringToDateTime(String date, String time) {
  try {
    final dateTimeStr = "$date $time";
    return DateTime.parse(dateTimeStr);
  } catch (e) {
    print("Error parsing DateTime: $e");
    return DateTime.now(); // エラーハンドリング（デフォルトで現在時刻）
  }
}

String toYyyyMmDdString(DateTime date) {
  return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
}

String formatTimeOfDay(TimeOfDay time) {
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  return "$hour:$minute";
}

DateTime? combineDateAndTime(String dateStr, TimeOfDay? time) {
  if (time == null) return null;

  String formattedTime =
      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

  String dateTimeStr = "$dateStr $formattedTime";

  try {
    DateTime dateTime = DateTime.parse(dateTimeStr);
    String formattedDateTime =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
    debugPrint("Formatted DateTime: $formattedDateTime");
    return dateTime;
  } catch (e) {
    debugPrint("Error parsing datetime: $e");
    return null;
  }
}

/// **15分単位に丸める**　8時-21時内
DateTime roundToNearest15Minutes(DateTime time) {
  final int minute = time.minute;
  final int remainder = minute % 15;
  int roundedMinute =
      remainder < 8 ? minute - remainder : minute + (15 - remainder);
  int extraHour = roundedMinute == 60 ? 1 : 0; // 60分なら次の時間に繰り上げ

  DateTime roundedTime = DateTime(
    time.year,
    time.month,
    time.day,
    time.hour + extraHour,
    roundedMinute % 60,
  );

  // 8時未満なら8時ちょうどに
  if (roundedTime.hour < 8) {
    return DateTime(time.year, time.month, time.day, 8, 0);
  }

  // 21時を超えたら21時ちょうどに
  if (roundedTime.hour >= 21) {
    return DateTime(time.year, time.month, time.day, 21, 0);
  }

  return roundedTime;
}

/// **指定の時間範囲に収まっているか判定**
bool isTimeInRange(int hour) {
  return hour >= 8 && hour < 21;
}

bool isSameDay(DateTime? date1, DateTime? date2) {
  if (date1 == null || date2 == null) return false;
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

//DateTime を TimeOfDay に変換するメソッド
TimeOfDay dateTimeToTimeOfDay(DateTime dateTime) {
  return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
}

String getDayOfWeekInBrackets(String dateString) {
  DateTime date = DateTime.parse(dateString);
  String dayOfWeek = DateFormat('EEEE', 'ja_JP').format(date);
  return '(${dayOfWeek.substring(0, 1)})';
}
