import 'package:flutter/material.dart';

List<TimeType> timeType = [
  TimeType('会議', 'conference', Colors.deepPurple[800]),
  TimeType('ミーティング', 'meeting', Colors.indigo[800]),
  TimeType('面談', 'interview', Colors.blue[800]),
  TimeType('オンライン', 'online', Colors.cyan[800]),
  TimeType('来社', 'visit', Colors.teal[800]),
  TimeType('その他', 'etc', Colors.grey[800])
];

class TimeType {
  TimeType(this.ja, this.en, this.color);
  final String ja;
  final String en;
  Color? color;
}

/// **`timeType` に対応する `Color` を取得**
Color getColorForTimeType(String? timeTypeKey) {
  if (timeTypeKey == null) {
    return Colors.grey[800]!; // `null` の場合はデフォルト色
  }
  return timeType
      .firstWhere(
        (type) => type.en == timeTypeKey, // 一致する `TimeType` を検索
        orElse: () => TimeType('その他', 'etc', Colors.grey[800]!), // デフォルト（灰色）
      )
      .color!;
}

TimeType getTimeTypeByKey(String? timeTypeKey) {
  return timeType.firstWhere(
    (type) => type.en == timeTypeKey,
    orElse: () => TimeType('未定', 'undefined', Colors.grey[800]!),
  );
}
