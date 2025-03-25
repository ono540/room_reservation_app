import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_reservation_app/core/enums/registration_type.dart';
import 'package:room_reservation_app/core/utils/time_utils.dart';
import 'package:room_reservation_app/presentation/components/dialog/room_schedule_draggable_dialog.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../domain/entities/schedule_entity.dart';
import '../components/button/room_register_button.dart';
import '../components/button/room_reload_button.dart';
import '../components/room/monthly_calendar.dart';
import '../components/room/timeline_scheduler.dart';
import '../components/single_touch.dart';
import '../providers/schedule_list_provider.dart';

@RoutePage()
class RoomManagementScreen extends ConsumerStatefulWidget {
  const RoomManagementScreen({super.key});

  @override
  RoomManagementScreenState createState() => RoomManagementScreenState();
}

class RoomManagementScreenState extends ConsumerState<RoomManagementScreen> {
  DateTime _selectedDate = DateTime.now(); // 選択された日付
  List<ScheduleEntity> roomSchedules = []; // 前回の selectedDate を保持
  final CalendarController _calendarController =
      CalendarController(); // タイムライン用コントローラー

  @override
  void initState() {
    super.initState();
    //_selectedDate = widget.selectedDate ?? DateTime.now();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _loadSchedules();

      //    filterRoomSchedules(_selectedDate, ref.watch(scheduleNotifierProvider));
    });
  }

  /// `widget.selectedDate` や `widget.schedule` が変更されたら実行
  @override
  void didUpdateWidget(covariant RoomManagementScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _showEditDialogAfterBuild();
  }

  /// **ウィジェットツリーの更新後に `showDialog()` を実行**
  void _showEditDialogAfterBuild() {
    Future.microtask(() {
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => RoomScheduleDraggableDialog(
            registrationDate: toYyyyMmDdString(_selectedDate),
            registrationType: RegistrationType.edit.name,
          ),
        );
      }
    });
  }

  Future<void> _loadSchedules() async {
    await ref
        .read(scheduleListNotifierProvider.notifier)
        .loadSchedules(toYyyyMmDdString(_selectedDate));
  }

  /// **日付を選択した際に `roomSchedules` を更新**
  Future<void> _onDateSelected(DateTime selectedDate) async {
    setState(() {
      _selectedDate = selectedDate;
      _calendarController.displayDate = selectedDate; //
    });

    await _loadSchedules();
  }

  @override
  Widget build(BuildContext context) {
    // filterRoomSchedules(_selectedDate, ref.watch(scheduleNotifierProvider));
    return SingleTouch(
      child: Scaffold(
          body: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // 垂直方向をトップ揃えに設定
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                SizedBox(
                    height: 300,
                    child: MonthlyCalendar(
                      key: ValueKey(_selectedDate),
                      onDateSelected: _onDateSelected,
                      // calendarController: _calendarController,
                      selectedDate: _selectedDate,
                    )),
                const Padding(padding: EdgeInsets.only(top: 8)),
                Row(
                  children: [
                    Expanded(
                      child: RoomRegisterButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => RoomScheduleDraggableDialog(
                                registrationDate:
                                    toYyyyMmDdString(_selectedDate),
                                registrationType:
                                    RegistrationType.newEntry.name),
                          );
                        },
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 8)),
                    Expanded(
                      child: RoomReloadButton(
                        onPressed: () async {
                          await _loadSchedules();
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10),
          ),
          // タイムラインビュー（タイムスケジュール表示用）
          Expanded(
            flex: 7,
            child: TimelineScheduler(
              calendarController: _calendarController,
              roomSchedules: ref.watch(scheduleListNotifierProvider
                  .select((v) => v.scheduleListState)),
              onDateSelected: _onDateSelected,
              selectedDate: _selectedDate,
            ),
          ),
          const Expanded(flex: 1, child: SizedBox.shrink())
        ],
      )),
    );
  }
}
