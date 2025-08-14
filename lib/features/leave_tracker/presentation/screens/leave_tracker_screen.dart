import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_%20bar_with_drawer.dart';
import 'package:fuoday/commons/widgets/k_drawer.dart';
import 'package:fuoday/commons/widgets/k_tab_bar.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/features/leave_tracker/presentation/screens/leave_balance.dart';
import 'package:fuoday/features/leave_tracker/presentation/screens/leave_reports.dart';
import 'package:fuoday/features/leave_tracker/presentation/screens/leave_request.dart';

class LeaveTrackerScreen extends StatefulWidget {
  const LeaveTrackerScreen({super.key});

  @override
  State<LeaveTrackerScreen> createState() => _LeaveTrackerScreenState();
}

class _LeaveTrackerScreenState extends State<LeaveTrackerScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    // Get employee details from Hive with error handling
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;

    // Safe extraction of employee details
    final name = employeeDetails?['name'] ?? "No Name";
    final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    final designation = employeeDetails?['designation'] ?? "No Designation";
    final email = employeeDetails?['email'] ?? "No email";

    return DefaultTabController(
      length: 3,
      child: Scaffold(
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

        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Tab bar
              KTabBar(
                tabs: [
                  // Leave Balanced
                  Tab(text: "Leave Balance"),
                  // Leave Reports
                  Tab(text: "Leave Reports"),
                  // Request Leave
                  Tab(text: "Leave Requests"),
                ],
              ),

              KVerticalSpacer(height: 20.h),

              Expanded(
                child: TabBarView(
                  children: [
                    // Leave Balance
                    LeaveBalance(),

                    // Leave Reports
                    LeaveReports(attendanceValues: [], months: [],),

                    // Leave Request
                    LeaveRequest(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
