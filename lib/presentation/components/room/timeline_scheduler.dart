import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_reservation_app/core/constants/schedule_constants.dart';
import 'package:room_reservation_app/core/enums/registration_type.dart';
import 'package:room_reservation_app/core/utils/int_utils.dart';
import 'package:room_reservation_app/core/utils/string_utils.dart';
import 'package:room_reservation_app/presentation/components/dialog/delete_confirmation_dialog.dart';
import 'package:room_reservation_app/presentation/components/dialog/room_schedule_draggable_dialog.dart';
import 'package:room_reservation_app/presentation/components/room/meeting_data_source.dart';
import 'package:room_reservation_app/presentation/mappers/schedule_appointment_mapper.dart';
import 'package:room_reservation_app/presentation/providers/time_schedule_provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../core/constants/meeting_room_constants.dart';
import '../../../../core/utils/sf_calendar_time_line_day.dart';
import '../../../../core/utils/time_utils.dart';
import '../../../../domain/entities/schedule_entity.dart';
import '../../../core/utils/schedule_entity_serializer.dart';
import '../../providers/schedule_list_provider.dart';
import 'appintment_tile.dart';

class TimelineScheduler extends ConsumerStatefulWidget {
  const TimelineScheduler(
      {super.key,
      // required this.onResizeEnd,
      // required this.onDragEnd,
      // required this.onTap,
      required this.calendarController,
      required this.roomSchedules,
      required this.onDateSelected,
      required this.selectedDate});
  final CalendarController calendarController;
  // final Function(AppointmentResizeEndDetails) onResizeEnd;
  // final Function(AppointmentDragEndDetails) onDragEnd;
  // final Function(CalendarTapDetails) onTap;
  final List<ScheduleEntity> roomSchedules;
  final Function(DateTime) onDateSelected;
  final DateTime selectedDate;

  @override
  TimelineSchedulerState createState() => TimelineSchedulerState();
}

class TimelineSchedulerState extends ConsumerState<TimelineScheduler> {
  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      controller: widget.calendarController,
      view: CalendarView.timelineDay,
      dataSource: MeetingDataSource(mapAppointments(widget.roomSchedules),
          MeetingRoomData.allMeetingRoomResources()),
      resourceViewSettings: buildResourceViewSettings(),
      allowAppointmentResize: true,
      allowDragAndDrop: true,
      timeSlotViewSettings: buildTimeSlotViewSettings(),
      onViewChanged: (ViewChangedDetails details) {
        if (details.visibleDates.isNotEmpty) {
          final newDate = details.visibleDates.first;
          // debugPrint('📅 onViewChanged: $newDate');
          // `widget.selectedDate` と比較して異なるなら更新
          if (!isSameDay(widget.selectedDate, newDate)) {
            widget.onDateSelected(newDate);
            // debugPrint('✅ スクロールで日付変更: $newDate');
          }
        }
      },
      appointmentBuilder: (context, calendarAppointmentDetails) {
        final Appointment appointment =
            calendarAppointmentDetails.appointments.first;
        return AppointmentTile(
          appointment: appointment,
          onDelete: () {
            showDialog(
              context: context,
              builder: (context) => DeleteConfirmationDialog(
                onConfirm: () {
                  // final scheduleData =
                  //     jsonDecode(appointment.notes!) as Map<String, dynamic>;
                  final scheduleData = fromSerializedString(appointment.notes!);

                  ref
                      .read(scheduleListNotifierProvider.notifier)
                      .delete(scheduleData);
                },
                registrationDate: toYyyyMmDdString(widget.selectedDate),
                content: appointment.subject,
              ),
            );
          },
          onEdit: () {
            final scheduleEntity = fromSerializedString(appointment.notes!);
            ref
                .read(timeScheduleNotifierProvider.notifier)
                .updateScheduleEntity(scheduleEntity);
            showDialog(
              context: context,
              builder: (context) => RoomScheduleDraggableDialog(
                  registrationDate: toYyyyMmDdString(widget.selectedDate),
                  registrationType: RegistrationType.edit.name),
            );
          },
        );
      },
      //  onAppointmentResizeStart: _onResizeStart,
      onAppointmentResizeUpdate: _onResizeUpdate,
      onAppointmentResizeEnd: _handleResizeEnd,
      onDragEnd: _handleDragEnd,
      // onTap: _onTap,
    );
  }

  void _onTap(CalendarTapDetails details) {
    final tappedDate = details.date;
    final tappedAppointments = details.appointments;
    final tappedResource = details.resource;

    if (tappedAppointments != null && tappedAppointments.isNotEmpty) {
      for (var appointment in tappedAppointments) {
        //   print('Tapped Appointment: ${appointment.subject}');
      }
    } else if (tappedDate != null) {
      //   print('Tapped Date: $tappedDate');
    }

    if (tappedResource != null) {
      debugPrint('Tapped Resource: ${tappedResource.displayName}');
    }
  }

  // 2. イベントハンドラーを整理
  // void _onResizeStart(AppointmentResizeStartDetails details) {
  //   if (details.appointment == null) {
  //     print('Resize Start: Appointment is null.');
  //     return;
  //   }
  //   // print('Resize Start Triggered: ${details.appointment}');
  // }

  void _onResizeUpdate(AppointmentResizeUpdateDetails details) {
    if (details.appointment == null || details.resizingTime == null) {
      // print('Resize Update: Invalid appointment or null resizing time.');
      return;
    }

    final resizingTime = details.resizingTime!;
    if (isTimeInRange(resizingTime.hour)) {
      //   print('Resize Update: Resizing time is valid: $resizingTime');
    } else {
      //  print('Resize Update: Resizing time is out of bounds.');
    }
  }

  //ドラッグエンド
  void _handleDragEnd(AppointmentDragEndDetails details) {
    if (details.droppingTime != null && details.appointment is Appointment) {
      final droppingTime = details.droppingTime!;
      final appointment = details.appointment as Appointment;
      if (!isTextValid(appointment.notes)) {
        return;
      }
      final moveRoomId = appointment.resourceIds?.first != null
          ? toInt(appointment.resourceIds!.first.toString())
          : null;
      final moveStartTime = roundToNearest15Minutes(appointment.startTime);
      final moveTimeItem = getTimeScheduleKeyFromDateTime(moveStartTime);

      final moveEndTime = roundToNearest15Minutes(appointment.endTime);
      final scheduleEntity = fromSerializedString(appointment.notes!);

      if (_isValidMove(droppingTime.hour, moveRoomId)) {
        ///状態値入れ込み
        ref.read(timeScheduleNotifierProvider.notifier).updateSchedule(
            id: scheduleEntity.id,
            item: moveTimeItem,
            content: scheduleEntity.content,
            meetingRoomId: moveRoomId,
            timeType: scheduleEntity.timeType,
            date: toYyyyMmDdString(moveStartTime),
            roomName: MeetingRoomData.getRoomName(moveRoomId).toString(),
            startTime: dateTimeToTimeOfDay(moveStartTime),
            endTime: dateTimeToTimeOfDay(moveEndTime),
            isVisibleForFilteredScreen:
                scheduleEntity.isVisibleForFilteredScreen,
            scheduleTime: moveStartTime);

        _resetStateAndUpdateDB();
      } else {
        debugPrint('Event outside allowed range. Reverting.');
        _revertAppointment(appointment);
      }
    }
  }

  /// **移動が許可されているかチェック**
  bool _isValidMove(int droppingHour, int? moveRoomId) {
    return isTimeInRange(droppingHour) && isIntValid(moveRoomId);
  }

  /// **状態リセット & DB更新**
  void _resetStateAndUpdateDB() {
    final schedule =
        ref.watch(timeScheduleNotifierProvider.select((s) => s.scheduleState));

    ref.read(scheduleListNotifierProvider.notifier).update(schedule);
    ref.read(timeScheduleNotifierProvider.notifier).reset();
  }

  void _revertAppointment(Appointment appointment) {
    setState(() {
      appointment.startTime = appointment.startTime;
      appointment.endTime = appointment.endTime;
    });
  }

  //リサイズエンド
  void _handleResizeEnd(AppointmentResizeEndDetails details) {
    if (details.appointment is! Appointment) {
      debugPrint('Invalid appointment detected. Skipping resize.');
      return;
    }
    final appointment = details.appointment as Appointment;
    final moveStartTime = roundToNearest15Minutes(appointment.startTime);
    final moveEndTime = roundToNearest15Minutes(appointment.endTime);
    if (!isTextValid(appointment.notes)) {
      return;
    }
    final scheduleEntity = fromSerializedString(appointment.notes!);
    if (isTimeInRange(moveStartTime.hour) && isTimeInRange(moveEndTime.hour)) {
      ///状態値入れ込み
      ref.read(timeScheduleNotifierProvider.notifier).updateSchedule(
          id: scheduleEntity.id,
          item: scheduleEntity.item,
          content: scheduleEntity.content,
          meetingRoomId: scheduleEntity.meetingRoomId,
          timeType: scheduleEntity.timeType,
          date: toYyyyMmDdString(moveStartTime),
          roomName: MeetingRoomData.getRoomName(scheduleEntity.meetingRoomId)
              .toString(),
          startTime: dateTimeToTimeOfDay(moveStartTime),
          endTime: dateTimeToTimeOfDay(moveEndTime),
          scheduleTime: moveStartTime);

      _resetStateAndUpdateDB();
    } else {
      print('Event resized outside allowed range. Reverting.');
      setState(() {
        _revertResize(appointment);
      });
    }
  }

  void _revertResize(Appointment appointment) {
    setState(() {
      appointment.startTime = DateTime(
        appointment.startTime.year,
        appointment.startTime.month,
        appointment.startTime.day,
        appointment.startTime.hour < 8 ? 8 : appointment.startTime.hour,
      );
      appointment.endTime = DateTime(
        appointment.endTime.year,
        appointment.endTime.month,
        appointment.endTime.day,
        appointment.endTime.hour > 21 ? 21 : appointment.endTime.hour,
      );
    });
  }

  List<Appointment> mapAppointments(List<ScheduleEntity> schedules) {
    return schedules
        .map((schedule) => ScheduleAppointmentMapper.toAppointment(schedule))
        .toList();
  }
}
