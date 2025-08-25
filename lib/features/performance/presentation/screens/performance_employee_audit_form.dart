import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:provider/provider.dart';
import 'package:fuoday/commons/widgets/k_data_table.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/performance/presentation/providers/audit_reporting_team_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PerformanceEmployeeAuditForm extends StatefulWidget {
  const PerformanceEmployeeAuditForm({super.key});

  @override
  State<PerformanceEmployeeAuditForm> createState() =>
      _PerformanceEmployeeAuditFormState();
}

class _PerformanceEmployeeAuditFormState
    extends State<PerformanceEmployeeAuditForm> {
  // Columns
  final columns = [
    'S.No',
    'Employee ID',
    'Name',
    'Self status',
    'Preview Audit Form',
  ];

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final employeeDetails = await HiveStorageService().employeeDetails;
      final webUserId =
          int.tryParse(employeeDetails?['web_user_id']?.toString() ?? '') ?? 0;

      if (webUserId != 0) {
        context.read<AuditReportingTeamProvider>().fetchAuditReportingTeam(webUserId);
      } else {
        debugPrint("❌ No valid webUserId found in Hive");
      }
    });
  }

  Future<void> _launchManagementDashboard() async {
    final url = Uri.parse("https://fuoday.com/login");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not launch $url");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<AuditReportingTeamProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.error != null) {
          return Center(
            child: Text(
              "Error: ${provider.error}",
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        // Map provider.team to KDataTable expected format
        final data = provider.team.asMap().entries.map((entry) {
          final index = entry.key + 1;
          final member = entry.value;
          return {
            'S.No': index.toString(),
            'Employee ID': member.empId,
            'Name': member.empName,
            'Self status': member.status,
            'Preview Audit Form': ElevatedButton(
              onPressed: _launchManagementDashboard,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                textStyle: TextStyle(fontSize: 10.sp),
              ),
              child:  KText(text: 'View', fontWeight: FontWeight.w500,color: AppColors.secondaryColor,  fontSize: 14.sp,),
            ),
          };
        }).toList();

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Column(
            spacing: 14.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title
              KText(
                text: "Employee Audit Form Update",
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                color: AppColors.primaryColor,
              ),

              KVerticalSpacer(height: 6.h),

              SizedBox(
                height: 600.h,
                child: KDataTable(columnTitles: columns, rowData: data),
              ),
            ],
          ),
        );
      },
    );
  }
}
