import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_bar.dart';
import 'package:fuoday/commons/widgets/k_circular_cache_image.dart';
import 'package:fuoday/commons/widgets/k_tab_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/hr/presentation/screens/hr_overview.dart';
import 'package:fuoday/features/hr/presentation/screens/hr_view_open_positions.dart';
import 'package:fuoday/features/hr/presentation/screens/hr_view_recent_employees.dart';
import 'package:go_router/go_router.dart';

class HRScreen extends StatefulWidget {
  const HRScreen({super.key});

  @override
  State<HRScreen> createState() => _HRScreenState();
}

class _HRScreenState extends State<HRScreen> {
  @override
  Widget build(BuildContext context) {
    // Get employee details from Hive with error handling
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;

    // Safe extraction of employee details
    final name = employeeDetails?['name'] ?? "No Name";
    final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    final empId = employeeDetails?['empId'] ?? "No Employee ID";
    final designation = employeeDetails?['designation'] ?? "No Designation";
    final email = employeeDetails?['email'] ?? "No Email";

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: KAppBar(
          title: "HR Dashboard",
          centerTitle: true,
          leadingIcon: Icons.arrow_back,
          onLeadingIconPress: () {
            GoRouter.of(context).pop();
          },
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Profile Image
              KCircularCachedImage(imageUrl: profilePhoto, size: 80.h),

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
                      text: name,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: AppColors.titleColor,
                    ),
                    KVerticalSpacer(height: 3.h),
                    KText(
                      text: "Designation: $designation",
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                      color: AppColors.titleColor,
                    ),
                    KVerticalSpacer(height: 3.h),
                    KText(
                      text: "Employee id: $empId",
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                      color: AppColors.titleColor,
                    ),

                    KVerticalSpacer(height: 3.h),

                    KText(
                      text: email,
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                      color: AppColors.titleColor,
                    ),

                  ],
                ),
              ),

              KVerticalSpacer(height: 30.h),

              KTabBar(
                tabs: [
                  // OverView
                  Tab(text: "Overview"),

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
                    HROverview(),

                    // Recent Employees
                    HRViewRecentEmployees(),

                    // Open Positions
                    HRViewOpenPositions(),
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
