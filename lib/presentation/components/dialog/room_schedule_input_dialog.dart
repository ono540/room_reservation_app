import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_reservation_app/core/utils/time_utils.dart';
import 'package:room_reservation_app/presentation/components/drop_down/room_start_time_dropdown.dart';
import 'package:room_reservation_app/presentation/components/drop_down/rooms_dropdown.dart';
import 'package:room_reservation_app/presentation/providers/time_schedule_provider.dart';

import '../../../../core/enums/registration_type.dart';
import '../../providers/schedule_list_provider.dart';
import '../chice_chip/time_type_choice_chip.dart';
import '../drop_down/end_time_dropdown.dart';

class RoomScheduleInputDialog extends StatefulWidget {
  const RoomScheduleInputDialog({
    super.key,
    required this.width,
    required this.height,
    required this.registrationDate,
    required this.registrationType,
    //  required this.controller,
  });
  final double width;
  final double height;
  // final TimeSchedule schedule;
  final String registrationDate;
  final String registrationType;
  // final TextEditingController controller;

  @override
  State<RoomScheduleInputDialog> createState() =>
      _RoomScheduleInputDialogState();
}

class _RoomScheduleInputDialogState extends State<RoomScheduleInputDialog> {
  final List<TimeOfDay> _timeSlots = [];
  String? selectedRoom;

  @override
  void initState() {
    super.initState();
    _generateTimeSlots();
  }

  void _generateTimeSlots() {
    _timeSlots.clear();
    for (int hour = 8;
        hour <= 21;
        // int hour = widget.schedule.startTime;
        // hour <= widget.schedule.endTime;

        hour++) {
      for (int minute = 0; minute < 60; minute += 15) {
        if (hour == 21 && minute > 0) {
          break; // 終了時間が00分以外の場合は終了
        }
        _timeSlots.add(TimeOfDay(hour: hour, minute: minute));
      }
    }
  }

  bool _isAddButtonEnabled({
    String? startTime,
    String? selectedTimeType,
    String? content,
    int? meetingRoomId,
    String? endTime,
  }) {
    return startTime != null &&
        selectedTimeType != null &&
        content!.trim().isNotEmpty &&
        meetingRoomId != null &&
        endTime != null;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 4.0,
        child: Container(
          width: widget.width,
          height: widget.height,
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '${widget.registrationDate}${getDayOfWeekInBrackets(widget.registrationDate)}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const Text((' / ')),
                  // Text(
                  //   widget.schedule.ja,
                  //   style: const TextStyle(
                  //       fontSize: 14, fontWeight: FontWeight.bold),
                  // ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    RoomStartTimeDropdown(
                      //   timeSlots: _timeSlots,
                      registrationDate: widget.registrationDate,
                      // schedule: widget.schedule,
                      // screenType: ScreenType.setting.name,
                    ),
                    const Text(('　-　')),
                    EndTimeDropdown(
                      timeSlots: _timeSlots,
                    )
                  ],
                ),
              ),
              const RoomsDropdown(),
              // const Padding(
              //   padding: EdgeInsets.only(
              //     top: 8,
              //   ),
              //   child: ReservationVisibilitySelector(),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: TimeTypeChoiceChip(),
              ),
              Expanded(
                child: Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    final content = ref.watch(timeScheduleNotifierProvider
                        .select((s) => s.scheduleState.content));
                    return TextFormField(
                      initialValue: content,
                      // controller: widget.controller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '入力してください',
                        hintStyle: TextStyle(fontSize: 12),
                      ),
                      maxLines: null, // 複数行入力可能にする
                      expands: true, // 残りのスペースを全て使用
                      textAlignVertical: TextAlignVertical.top,
                      // テキストの垂直位置を上部に設定
                      onChanged: (text) {
                        ref
                            .read(timeScheduleNotifierProvider.notifier)
                            .updateSchedule(content: text);
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Consumer(
                      builder:
                          (BuildContext context, WidgetRef ref, Widget? child) {
                        final timeSchedule =
                            ref.watch(timeScheduleNotifierProvider);

                        void insertSchedule() {
                          ref
                              .read(scheduleListNotifierProvider.notifier)
                              .insert(timeSchedule.scheduleState);
                        }

                        void updateSchedule() {
                          ref
                              .read(scheduleListNotifierProvider.notifier)
                              .update(timeSchedule.scheduleState);
                        }

                        void handleButtonPressed() {
                          if (widget.registrationType ==
                              RegistrationType.newEntry.name) {
                            insertSchedule();
                          } else if (widget.registrationType ==
                              RegistrationType.edit.name) {
                            updateSchedule();
                          }
                          ref
                              .read(timeScheduleNotifierProvider.notifier)
                              .reset();
                          Navigator.of(context).pop();
                        }

                        final isEnabled = _isAddButtonEnabled(
                          startTime: timeSchedule.scheduleState.startTime,
                          selectedTimeType: timeSchedule.scheduleState.timeType,
                          content: timeSchedule.scheduleState.content,
                          meetingRoomId:
                              timeSchedule.scheduleState.meetingRoomId,
                          endTime: timeSchedule.scheduleState.endTime,
                        );

                        return ElevatedButton(
                          onPressed: isEnabled ? handleButtonPressed : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isEnabled
                                ? Colors.blue
                                : Colors
                                    .grey, // Change color based on enabled state
                          ),
                          child: Text('Add'),
                        );
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                    ),
                    Consumer(
                      builder:
                          (BuildContext context, WidgetRef ref, Widget? child) {
                        return ElevatedButton(
                          onPressed: () {
                            ref
                                .read(timeScheduleNotifierProvider.notifier)
                                .reset();
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
