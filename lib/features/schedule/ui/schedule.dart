import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_tuition_tracker/features/schedule/bloc/schedule_bloc.dart';
import 'package:smart_tuition_tracker/features/schedule/ui/schedule_tile.dart';
import 'package:table_calendar/table_calendar.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  final ScheduleBloc _scheduleBloc = ScheduleBloc();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  DateTime today = DateTime.now();
  Map<DateTime, List<String>> markedDates = {
    DateTime.utc(2025, 5, 5): ['Event 1'],
    DateTime.utc(2025, 5, 10): ['Meeting'],
  };

  @override
  void initState() {
    super.initState();
    _scheduleBloc.add(ScheduleInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScheduleBloc, ScheduleState>(
      bloc: _scheduleBloc,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case ScheduleLoadingState:
            return Center(child: CircularProgressIndicator());
          case ScheduleLoadedState:
            print((state as ScheduleLoadedState).schedules);
            return ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, size: 20),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        isDense: true, // reduces height a bit more
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: TableCalendar(
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      selectedTextStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    calendarFormat: CalendarFormat.twoWeeks,
                    availableCalendarFormats: const {
                      CalendarFormat.twoWeeks: 'Two Weeks',
                    },
                    onFormatChanged: (_) {},
                    headerStyle: HeaderStyle(titleCentered: true),
                    onPageChanged: (focusedDay) {
                      today = focusedDay;
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                      print(_selectedDay?.weekday);
                      print(_focusedDay.weekday);
                      _scheduleBloc.add(
                        ScheduleDateClickEvent(weekDay: _selectedDay!.weekday),
                      );
                    },

                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    focusedDay: _focusedDay,

                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    startingDayOfWeek: StartingDayOfWeek.saturday,
                    eventLoader: (day) {
                      if ((state).weekDay.contains(
                        day.weekday,
                      )) {
                        return ['Marked'];
                      }
                      return [];
                    },
                    calendarBuilders: CalendarBuilders(
                      markerBuilder: (context, date, events) {
                        if (events.isNotEmpty) {
                          return Positioned(
                            bottom: 1,
                            child: Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                            ),
                          );
                        }
                        return SizedBox();
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                if (state.schedules.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.schedules.length,
                      itemBuilder: (context, index) {
                        return ScheduleTile(
                          studentSchedule: state.schedules[index],
                        );
                      },
                    ),
                  ),
              ],
            );
          default:
            return Center(child: Text('Unknown State'));
        }
      },
    );
  }
}
