import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'Note.dart';

class Calendar extends StatefulWidget {
  Calendar({super.key});
  State<Calendar> createState() => CalendarState();
}

class CalendarState extends State<Calendar> {
  Widget build(context) {
    return Card(
      child: SfCalendar(
        selectionDecoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.blue, width: 1),
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(4))),
        onSelectionChanged: (calendarSelectionDetails) {
          print(calendarSelectionDetails.date);
        },
        showDatePickerButton: true,
        view: CalendarView.month,
        dataSource: MeetingDataSource(_getDataSource()),
        // by default the month appointment display mode set as Indicator, we can
        // change the display mode as appointment using the appointment display
        // mode property
        monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
            showAgenda: true),
        blackoutDates: [
          // DateTime.now().subtract(Duration(hours: 48)),
          // DateTime.now().subtract(Duration(hours: 24)),
        ],
      ),
    );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    // List<List<String>> taskDetails = [];
    Note.myList.forEach((category) {
      category.values.forEach((tasks) {
        tasks.forEach((task) {
          task.forEach((name, details) {
            var starttime = DateTime.parse('${details[0]} ${details[1]}')
                // .subtract(Duration(days: 1))
                ;
            var Tnewmeet = Meeting(
                '${name}',
                starttime,
                starttime.add(const Duration(minutes: 10)),
                Colors.green,
                false);
            // print(Tnewmeet.from);
            meetings.add(Tnewmeet);
            // taskDetails.add(taskDetail);
          });
        });
      });
    });
    // DateTime.parse('2000-01-01T00:00:00Z');
    // final DateTime today = DateTime.now();
    // final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    // final DateTime endTime = startTime.add(const Duration(hours: 2));
    // var newmeet = Meeting('kittiwat', startTime, endTime, Colors.green, false);
    // var newmeet2 = Meeting('kittiwat', startTime, endTime, Colors.green, false);
    // print("${newmeet.from} check check");
    // meetings.add(newmeet);
    // meetings.add(newmeet2);

    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}
