import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_bar.dart';
import 'package:fuoday/commons/widgets/k_circular_cache_image.dart';
import 'package:fuoday/commons/widgets/k_data_table.dart';
import 'package:fuoday/commons/widgets/k_tab_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/management/presentation/screens/management_overview.dart';
import 'package:fuoday/features/management/presentation/screens/management_view_open_positions.dart';
import 'package:fuoday/features/management/presentation/screens/management_view_projects.dart';
import 'package:fuoday/features/management/presentation/screens/management_view_recent_employees.dart';
import 'package:go_router/go_router.dart';

class ManagementScreen extends StatefulWidget {
  const ManagementScreen({super.key});

  @override
  State<ManagementScreen> createState() => _ManagementScreenState();
}

class _ManagementScreenState extends State<ManagementScreen> {
  // Dummy Data
  final columns = [
    'S.No',
    'Date',
    'Day',
    'Log on',
    'Log off',
    'Worked hours',
    'Status',
  ];

  // Employee Attendance Data
  final data = [
    {
      'S.No': '1',
      'Date': '2025-07-01',
      'Day': 'Monday',
      'Log on': '09:00 AM',
      'Log off': '06:00 PM',
      'Worked hours': '9h',
      'Status': 'Present',
    },
    {
      'S.No': '2',
      'Date': '2025-07-02',
      'Day': 'Tuesday',
      'Log on': '09:15 AM',
      'Log off': '06:10 PM',
      'Worked hours': '8h 55m',
      'Status': 'Present',
    },
    {
      'S.No': '3',
      'Date': '2025-07-03',
      'Day': 'Wednesday',
      'Log on': 'Absent',
      'Log off': '-',
      'Worked hours': '0h',
      'Status': 'Absent',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: KAppBar(
          title: "Management Dashboard",
          centerTitle: true,
          leadingIcon: Icons.arrow_back,
          onLeadingIconPress: () {
            GoRouter.of(context).pop();
          },
        ),

        bottomSheet: Container(
          height: 60.h,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          margin: EdgeInsets.symmetric(vertical: 10.h),
          child: Center(
            child: KAuthFilledBtn(
              backgroundColor: AppColors.primaryColor,
              height: 24.h,
              width: double.infinity,
              text: "View Audit Process",
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.r),
                    ),
                  ),
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 20.w,
                        right: 20.w,
                        bottom:
                            MediaQuery.of(context).viewInsets.bottom +
                            20.h, // keyboard aware
                        top: 10.h,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Drag handle
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 2.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: AppColors.greyColor,
                                ),
                              ),
                            ),

                            KVerticalSpacer(height: 20.h),

                            // Person name
                            KText(
                              text: "Krishnakanth ST",
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              color: AppColors.primaryColor,
                            ),

                            KVerticalSpacer(height: 20.h),

                            // Table
                            SizedBox(
                              height: 200.h,
                              child: KDataTable(
                                columnTitles: columns,
                                rowData: data,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              fontSize: 11.sp,
            ),
          ),
        ),

        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Profile Image
              KCircularCachedImage(
                size: 90.h,
                imageUrl:
                    "https://images.unsplash.com/photo-1499996860823-5214fcc65f8f?q=80&w=2566&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
              ),

              KVerticalSpacer(height: 24.h),

              // person Card
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.w,
                    color: AppColors.greyColor.withOpacity(0.3),
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: AppColors.cardGradientColor,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // name
                    KText(
                      text: "Mohammed Irfan",
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: AppColors.titleColor,
                    ),

                    KVerticalSpacer(height: 6.h),

                    // emp Id
                    KText(
                      text: "Employee ID: 1043",
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: AppColors.greyColor,
                    ),

                    KVerticalSpacer(height: 3.h),

                    // Phone No
                    KText(
                      text: "Flutter Developer",
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: AppColors.greyColor,
                    ),
                  ],
                ),
              ),

              KVerticalSpacer(height: 30.h),

              KTabBar(
                tabs: [
                  // OverView
                  Tab(text: "Overview"),

                  // Projects
                  Tab(text: "Projects"),

                  // Recent Employees
                  Tab(text: "Recent Employees"),

                  // Open Positions
                  Tab(text: "Open Positions"),
                ],
              ),

              KVerticalSpacer(height: 20.h),

              Expanded(
                child: TabBarView(
                  children: [
                    // Overview
                    ManagementOverview(),

                    // Projects
                    ManagementViewProjects(),

                    // Recent Employees
                    ManagementViewRecentEmployees(),

                    // Open Positions
                    ManagementViewOpenPositions(),
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
