import 'package:syncfusion_flutter_calendar/calendar.dart';

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(
      List<Appointment> appointments, List<CalendarResource> resources) {
    this.appointments = appointments;
    this.resources = resources;
  }
}
