import 'package:apis_app/blocs/waitingListBloc.dart';
import 'package:apis_app/ui/waitingList/components/date_callback.dart';
import 'package:apis_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class TableBasicsExample extends StatefulWidget {
  @override
  _TableBasicsExampleState createState() => _TableBasicsExampleState();
}

class _TableBasicsExampleState extends State<TableBasicsExample>
    implements ADateSelected {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;

  WaitingListBloc _waitingListBloc;

  @override
  void initState() {
    _waitingListBloc = WaitingListBloc();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: kFirstDay,
      lastDay: kLastDay,
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          setState(() {
            var formatter = new DateFormat('yyyy-MM-dd');
            String formattedDate = formatter.format(selectedDay);
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
            _waitingListBloc.fetchWaitingList(formattedDate);
            onDateSelected(formattedDate);
          });
        }
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        // No need to call `setState()` here
        _focusedDay = focusedDay;
      },
    );
  }

  @override
  void onDateSelected(String str) {
    // TODO: implement onDateSelected
  }
}
