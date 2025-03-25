import 'package:flutter/material.dart';
import 'package:room_reservation_app/core/utils/string_utils.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

/// **会議室データを管理するクラス**
class MeetingRoomData {
  /// **全ての会議室（画面A用）**
  static final List<Map<String, dynamic>> allRooms = [
    {'id': 1, 'name': '応接室2A(9人席)', },
    {'id': 2, 'name': '応接室2B(4人席)', },
    {
      'id': 3,
      'name': '応接室3A(来客優先・ソファー席7人)',
    },
    {'id': 4, 'name': '応接室3B(8人席)', },
    {'id': 5, 'name': '3階研修室', },
    {'id': 6, 'name': 'オンラインブース1', },
    {'id': 7, 'name': 'オンラインブース2', },
    {'id': 8, 'name': 'オンラインブース3', },

  ];

  /// **利用可能な会議室のみ取得**
  static List<Map<String, dynamic>> getMainScreenMeetingRoomResources() {
    return allRooms
        .where((room) => room['isVisibleForFilteredScreen'] == true)
        .toList();
  }

  /// **会議室名を取得（IDが見つからない場合は`null`）**
  static String? getRoomName(int? id) {
    return allRooms.firstWhere(
      (room) => room['id'] == id,
      orElse: () => {'name': null},
    )['name'];
  }

  /// **全ての会議室の `CalendarResource` を取得**
  static List<CalendarResource> allMeetingRoomResources() {
    return allRooms.map((room) {
      return CalendarResource(
        id: room['id'],
        displayName: room['name'],
        color: Colors.transparent,
      );
    }).toList();
  }

}
