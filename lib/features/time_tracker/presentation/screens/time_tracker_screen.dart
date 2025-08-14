import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_bar.dart';
import 'package:fuoday/commons/widgets/k_tab_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/time_tracker/presentation/provider/time_tracker_provider.dart';
import 'package:fuoday/features/time_tracker/presentation/screens/time_tracker_overview.dart';
import 'package:fuoday/features/time_tracker/presentation/screens/time_tracker_project_management.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TimeTrackerScreen extends StatefulWidget {
  const TimeTrackerScreen({Key? key}) : super(key: key);

  @override
  State<TimeTrackerScreen> createState() => _TimeTrackerScreenState();
}

class _TimeTrackerScreenState extends State<TimeTrackerScreen> {
  late final String? webUserId;

  @override
  void initState() {
    super.initState();
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;
    webUserId = employeeDetails?['web_user_id']?.toString();

    if (webUserId != null) {
      Future.microtask(() {
        context.read<TimeTrackerProvider>().load(webUserId!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TimeTrackerProvider>(builder: (context, provider, _) {
      final data = provider.entity;

      if (data == null || provider.error != null) {
        return Scaffold(
          appBar: KAppBar(
            title: "Time Tracker",
            centerTitle: true,
            leadingIcon: Icons.arrow_back,
            onLeadingIconPress: () => GoRouter.of(context).pop(),
          ),
          body: const Center(child: Text("No data available")),
        );
      }

          //final data = provider.entity!;

          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: KAppBar(
                title: "Time Tracker",
                centerTitle: true,
                leadingIcon: Icons.arrow_back,
                onLeadingIconPress: () {
                  GoRouter.of(context).pop();
                },
              ),
              body: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: "Good Morning",
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),

                        Row(
                          spacing: 4.w,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Clock icon
                            Icon(Icons.lock_clock, color: AppColors.greyColor),

                            // Time
                            KText(
                              text: "11:53 AM",
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                            ),
                          ],
                        ),
                      ],
                    ),

                    KVerticalSpacer(height: 20.h),

                    // Tab Bar
                    KTabBar(
                      tabs: [
                        Tab(text: "Overview"),
                        Tab(text: "Project Management"),
                      ],
                    ),

                    KVerticalSpacer(height: 20.h),

                    Expanded(
                      child: TabBarView(
                        children: [
                          // OverView
                          TimeTrackerOverview(data: data.attendances),

                          //  Project Management
                          TimeTrackerProjectManagement(data: data.projects),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }); }
}
