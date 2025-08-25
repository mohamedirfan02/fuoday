import 'package:flutter/material.dart';
import 'package:fuoday/commons/widgets/k_app_ bar_with_drawer.dart';
import 'package:fuoday/commons/widgets/k_drawer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late String selectedMonth;
  DateTime? _currentViewDate;

  DateTime parseShiftDate(String date, String time) {
    // Ensure time has seconds
    final normalizedTime = time.length == 5 ? '$time:00' : time;
    try {
      return DateTime.parse('$date $normalizedTime');
    } catch (_) {
      // fallback if parsing fails
      return DateTime.now();
    }
  }


  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    selectedMonth = DateFormat('yyyy-MM').format(now);
    _currentViewDate = now;

    WidgetsBinding.instance.addPostFrameCallback((_) => _loadShifts());
  }

  void _loadShifts({bool forceRefresh = false}) {
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;
    final webUserId = employeeDetails?['web_user_id']?.toString();

    if (webUserId != null) {
      Future.microtask(() {
        context.shiftScheduleProviderRead.fetchMonthlyShifts(
          webUserId: webUserId,
          month: selectedMonth,
          forceRefresh: forceRefresh,
        );
      });
    }
  }

  void _onViewChanged(ViewChangedDetails details) {
    if (details.visibleDates.isEmpty) return;

    // Use the middle visible date as current view reference
    _currentViewDate = details.visibleDates[details.visibleDates.length ~/ 2];
    final newMonth = DateFormat('yyyy-MM').format(_currentViewDate!);

    if (newMonth != selectedMonth) {
      selectedMonth = newMonth;
      Future.microtask(() => _loadShifts(forceRefresh: true));
    }
  }

  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();

  @override
  Widget build(BuildContext context) {
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;

    final name = employeeDetails?['name'] ?? "No Name";
    final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    final designation = employeeDetails?['designation'] ?? "No Designation";
    final email = employeeDetails?['email'] ?? "No Email";

    final provider = context.shiftScheduleProviderWatch;

    return Scaffold(
      key: _scaffoldKey,
      appBar: KAppBarWithDrawer(
        userName: name,
        cachedNetworkImageUrl: profilePhoto,
        userDesignation: designation,
        showUserInfo: true,
        onDrawerPressed: _openDrawer,
        onNotificationPressed: () {},
      ),
      drawer: KDrawer(
        userName: name,
        userEmail: email,
        profileImageUrl: profilePhoto,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SfCalendar(
                view: CalendarView.month,
                dataSource: ShiftAppointmentDataSource(
                  (provider.shifts ?? []).map((shift) {
                    return Appointment(
                      startTime: parseShiftDate(shift.date, shift.shiftStart),
                      endTime: parseShiftDate(shift.date, shift.shiftEnd),
                      subject: 'Shift',
                      color: AppColors.primaryColor,
                    );
                  }).toList(),
                ),
                initialDisplayDate: _currentViewDate,
                onViewChanged: _onViewChanged,
                showNavigationArrow: true,
                showWeekNumber: true,
                showTodayButton: true,
                showCurrentTimeIndicator: true,
                showDatePickerButton: true,
                todayHighlightColor: AppColors.primaryColor,
                monthViewSettings: const MonthViewSettings(
                  showAgenda: true,
                  appointmentDisplayMode:
                      MonthAppointmentDisplayMode.appointment,
                ),
              ),
      ),
    );
  }
}

class ShiftAppointmentDataSource extends CalendarDataSource {
  ShiftAppointmentDataSource(List<Appointment> appointments) {
    this.appointments = appointments;
  }
}
