import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/home/domain/entities/home_feeds_project_data_entity.dart';
import 'package:fuoday/features/home/domain/usecases/get_home_feeds_project_data_use_case.dart';
import 'package:fuoday/features/home/presentation/widgets/k_home_employee_feeds_assigned_works_tile.dart';
import 'package:fuoday/features/home/presentation/widgets/k_home_employee_feeds_pending_works_tile.dart';

class HomeEmployeeFeeds extends StatefulWidget {
  const HomeEmployeeFeeds({super.key});

  @override
  State<HomeEmployeeFeeds> createState() => _HomeEmployeeFeedsState();
}

class _HomeEmployeeFeedsState extends State<HomeEmployeeFeeds> {
  late Future<HomeFeedsProjectDataEntity> _homeFeedsFuture;

  @override
  void initState() {
    super.initState();
    final hiveService = getIt<HiveStorageService>();
    final webUserId = hiveService.employeeDetails?['web_user_id']?.toString();

    final useCase = getIt<GetHomeFeedsProjectDataUseCase>();
    _homeFeedsFuture = useCase.call(webUserId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<HomeFeedsProjectDataEntity>(
        future: _homeFeedsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("No data found."));
          }

          final assigned = snapshot.data!.assigned;
          final pending = snapshot.data!.pending;

          return ListView(
            padding: EdgeInsets.all(16),
            children: [
              // Assigned Works
              Container(
                padding: EdgeInsets.only(bottom: 10.h),
                height: 300.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFD1D7E8),
                      Color(0xFFEFF1F7),
                      Colors.white,
                    ],
                  ),
                  border: Border.all(color: AppColors.titleColor, width: 0.2.w),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10.w,
                        top: 10.h,
                        bottom: 10.h,
                      ),
                      child: KText(
                        text: 'Assigned Works By You',
                        fontWeight: FontWeight.w600,
                        color: AppColors.subTitleColor,
                        fontSize: 12.sp,
                      ),
                    ),
                    Expanded(
                      child: assigned.isEmpty
                          ? Center(child: Text("No assigned works"))
                          : ListView.separated(
                              scrollDirection: Axis.vertical,
                              physics: const BouncingScrollPhysics(),
                              itemCount: assigned.length,
                              separatorBuilder: (_, _) =>
                                  KVerticalSpacer(height: 8.h),
                              itemBuilder: (context, index) {
                                final item = assigned[index];
                                return KHomeEmployeeFeedsAssignedWorksTile(
                                  leadingVerticalDividerColor:
                                      AppColors.primaryColor,
                                  assignedWorksTitle: item.projectName,
                                  assignedWorkSubTitle: item.description,
                                  assignedWorkDeadLine: item.deadline,
                                  assignedBy: item.assignedBy,
                                  assignedTo: item.assignedTo,
                                  date: item.date,
                                  progress: item.progress,
                                  deadline: item.deadline,
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),

              KVerticalSpacer(height: 14.h),

              // Pending Works
              Container(
                padding: EdgeInsets.only(bottom: 10.h),
                height: 300.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFD1D7E8),
                      Color(0xFFEFF1F7),
                      Colors.white,
                    ],
                  ),
                  border: Border.all(color: AppColors.titleColor, width: 0.2.w),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10.w,
                        top: 10.h,
                        bottom: 10.h,
                      ),
                      child: KText(
                        text: 'Pending Works',
                        fontWeight: FontWeight.w600,
                        color: AppColors.subTitleColor,
                        fontSize: 12.sp,
                      ),
                    ),
                    Expanded(
                      child: pending.isEmpty
                          ? Center(child: Text("No pending works"))
                          : ListView.separated(
                              scrollDirection: Axis.vertical,
                              physics: const BouncingScrollPhysics(),
                              itemCount: pending.length,
                              separatorBuilder: (_, _) =>
                                  KVerticalSpacer(height: 8.h),
                              itemBuilder: (context, index) {
                                final item = pending[index];
                                return KHomeEmployeeFeedsPendingWorksTile(
                                  pendingVerticalDividerColor:
                                      AppColors.primaryColor,
                                  pendingProjectTitle: item.projectName,
                                  pendingDeadline: item.deadline,
                                  pendingWorkStatus: item.progress,
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),

              KVerticalSpacer(height: 14.h),
            ],
          );
        },
      ),
    );
  }
}
