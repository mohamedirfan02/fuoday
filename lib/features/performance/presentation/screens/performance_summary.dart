import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_data_table.dart';
import 'package:fuoday/commons/widgets/k_download_options_bottom_sheet.dart';
import 'package:fuoday/commons/widgets/k_snack_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/core/service/excel_generator_service.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/service/pdf_generator_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/performance/presentation/widgets/performance_card.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';

class PerformanceSummary extends StatefulWidget {
  const PerformanceSummary({super.key});

  @override
  State<PerformanceSummary> createState() => _PerformanceSummaryState();
}

class _PerformanceSummaryState extends State<PerformanceSummary> {
  // Service
  late final HiveStorageService hiveService;
  late final Map<String, dynamic>? employeeDetails;
  late final String name;
  late final int webUserId;
  final dateFormatter = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    hiveService = getIt<HiveStorageService>();
    employeeDetails = hiveService.employeeDetails;
    name = employeeDetails?['name'] ?? "No Name";
    webUserId =
        int.tryParse(employeeDetails?['web_user_id']?.toString() ?? '') ?? 0;

    Future.microtask(() {
      context.performanceSummaryProviderRead.loadSummary(webUserId);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateTimeProvider = context.dateTimeProviderWatch;
    final provider = context.performanceSummaryProviderWatch;

    // Columns
    final columns = [
      'Date',
      'Task',
      'Assigned By',
      'Deadline',
      'Status',
      'Progress Note',
    ];

    // Combine assigned_by_me and assigned_to_me tasks
    final assignedByMe = provider.summary?.assignedByMe ?? [];
    final assignedToMe = provider.summary?.assignedToMe ?? [];

    // Combine and sort by date (most recent first)
    final allTasks = [...assignedByMe, ...assignedToMe];
    allTasks.sort((a, b) {
      final dateA = a.date ?? DateTime(1970);
      final dateB = b.date ?? DateTime(1970);
      return dateB.compareTo(dateA); // Descending order
    });

    // Map to table data
    final data = allTasks.map((task) {
      return {
        'Date': task.date != null ? dateFormatter.format(task.date!) : '',
        'Task': task.description ?? '',
        'Assigned By': task.assignedBy ?? '',
        'Deadline': task.deadline != null
            ? dateFormatter.format(task.deadline!)
            : '',
        'Status': task.status ?? '',
        'Progress Note': task.progressNote ?? '',
      };
    }).toList();

    // Performance Summary Card
    final performanceSummaryCard = [
      {
        'iconData': Icons.speed,
        'cardTitle': "Performance Score",
        'cardSubTitle':
        provider.summary?.performanceScore?.toString() ?? "0",
      },
      {
        'iconData': Icons.show_chart,
        'cardTitle': "Goal Progress",
        'cardSubTitle':
        "${provider.summary?.goalProgressPercentage?.toStringAsFixed(1) ?? '0'}%",
      },
      {
        'iconData': Icons.star_rate,
        'cardTitle': "Performance Ratings",
        'cardSubTitle':
        "${provider.summary?.performanceRatingOutOf5?.toStringAsFixed(1) ?? '0'}/5",
      },
      {
        'iconData': Icons.calendar_today,
        'cardTitle': "Avg. Monthly Attendance",
        'cardSubTitle':
        "${provider.summary?.averageMonthlyAttendance?.toStringAsFixed(1) ?? '0'}%",
      },
    ];

    // Current Goals Card - Updated to use actual data
    final currentGoalsCard = [
      {
        'iconData': Icons.task_alt,
        'cardTitle': "Completed Tasks",
        'cardSubTitle': provider.summary?.totalCompleted?.toString() ?? "0",
      },
      {
        'iconData': Icons.assignment_turned_in,
        'cardTitle': "Completed Projects",
        'cardSubTitle': provider.summary?.totalCompletedProjects?.toString() ?? "0",
      },
      {
        'iconData': Icons.pending_actions,
        'cardTitle': "Pending Tasks",
        'cardSubTitle': provider.summary?.totalPending?.toString() ?? "0",
      },
      {
        'iconData': Icons.upcoming,
        'cardTitle': "Upcoming Projects",
        'cardSubTitle': provider.summary?.totalUpcomingProjects?.toString() ?? "0",
      },
    ];

    AppLoggerHelper.logInfo(performanceSummaryCard.toString());
    final isTablet = AppResponsive.isTablet(context);
    final isLandscape = AppResponsive.isLandscape(context);

    if (provider.isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: theme.primaryColor),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          KText(
            text: "${dateTimeProvider.greeting}, $name",
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),

          KVerticalSpacer(height: 20.h),

          GridView.builder(
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: isTablet ? (isLandscape ? 4.8 : 2.5) : 1.0,
            ),
            itemCount: performanceSummaryCard.length,
            itemBuilder: (context, index) {
              final data = performanceSummaryCard[index];
              return PerformanceCard(
                iconData: data['iconData'] as IconData,
                cardTitle: data['cardTitle'] as String,
                cardSubTitle: data['cardSubTitle'] as String,
              );
            },
          ),

          KVerticalSpacer(height: 12.h),

          KText(
            text: "Current Goals",
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),

          KVerticalSpacer(height: 20.h),

          GridView.builder(
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: isTablet ? (isLandscape ? 4.8 : 2.5) : 1.0,
            ),
            itemCount: currentGoalsCard.length,
            itemBuilder: (context, index) {
              final data = currentGoalsCard[index];
              return PerformanceCard(
                iconData: data['iconData'] as IconData,
                cardTitle: data['cardTitle'] as String,
                cardSubTitle: data['cardSubTitle'] as String,
              );
            },
          ),

          KVerticalSpacer(height: 12.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              KText(
                text: "All Tasks",
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),

              KText(
                text: "Total: ${allTasks.length}",
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              ),
            ],
          ),

          KVerticalSpacer(height: 20.h),

          // Table
          SizedBox(
            height: data.isEmpty ? 100.h : 400.h,
            child: data.isEmpty
                ? Center(
              child: KText(
                text: "No tasks found",
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            )
                : KDataTable(columnTitles: columns, rowData: data),
          ),

          KVerticalSpacer(height: 20.h),

          // Download Button
          KAuthFilledBtn(
            backgroundColor: theme.primaryColor,
            height: AppResponsive.responsiveBtnHeight(context),
            width: double.infinity,
            text: "Download Tasks",
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                ),
                builder: (context) {
                  return KDownloadOptionsBottomSheet(
                    // onPdfTap: () async {
                    //   Navigator.pop(context); // Close bottom sheet
                    //
                    //   if (data.isEmpty) {
                    //     KSnackBar.failure(context, "No Data Found");
                    //   } else {
                    //     // PDF service
                    //     final pdfService = getIt<PdfGeneratorService>();
                    //
                    //     // Generating
                    //     final pdfFile = await pdfService.generateAndSavePdf(
                    //       data: data,
                    //       columns: columns,
                    //       title: 'All Tasks Report',
                    //     );
                    //
                    //     // Open PDF File
                    //     await OpenFilex.open(pdfFile.path);
                    //   }
                    // },
                    onExcelTap: () async {
                      Navigator.pop(context); // Close bottom sheet

                      if (data.isEmpty) {
                        KSnackBar.failure(context, "No Data Found");
                      } else {
                        // Excel Service
                        final excelService = getIt<ExcelGeneratorService>();
                        filename:
                        'Task${DateTime.now().millisecondsSinceEpoch}.pdf';
                        // Implement Excel logic
                        final excelFile = await excelService.generateAndSaveExcel(
                          data: data,
                          filename: 'All Tasks Report.xlsx',
                          columns: columns,
                        );

                        // Open Excel File
                        await OpenFilex.open(excelFile.path);
                      }
                    },
                  );
                },
              );
            },
            fontSize: 11.sp,
          ),

          KVerticalSpacer(height: 20.h),
        ],
      ),
    );
  }
}