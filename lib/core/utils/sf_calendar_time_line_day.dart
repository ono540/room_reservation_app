import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../constants/meeting_room_constants.dart';

/// **会議室のリソースビュー設定**
ResourceViewSettings buildResourceViewSettings() {
  return ResourceViewSettings(
    visibleResourceCount: MeetingRoomData.allMeetingRoomResources().length,
    showAvatar: false,
    size: 150,
    displayNameTextStyle: const TextStyle(
      fontSize: 12,
      color: Color(0xFFFFFFFF), // Colors.white の代わり
      overflow: TextOverflow.visible,
    ),
  );
}

/// **タイムスロットの設定**
TimeSlotViewSettings buildTimeSlotViewSettings() {
  return const TimeSlotViewSettings(
    startHour: 8,
    endHour: 22,
    timeInterval: Duration(minutes: 60),
    timeFormat: 'HH:mm',
    timeTextStyle: TextStyle(fontSize: 12, color: Colors.grey),
    timeIntervalWidth: 100,
  );
}
