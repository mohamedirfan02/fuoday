import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_data_table.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/themes/app_colors.dart';

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

  // Data
  final data = [
    {
      'S.No': '1',
      'Employee ID': 'E001',
      'Name': 'John Doe',
      'Self status': 'Completed',
      'Preview Audit Form': 'View',
    },
    {
      'S.No': '2',
      'Employee ID': 'E002',
      'Name': 'Jane Smith',
      'Self status': 'Pending',
      'Preview Audit Form': 'View',
    },
    {
      'S.No': '3',
      'Employee ID': 'E003',
      'Name': 'Alice Johnson',
      'Self status': 'Completed',
      'Preview Audit Form': 'View',
    },
    {
      'S.No': '4',
      'Employee ID': 'E004',
      'Name': 'Bob Williams',
      'Self status': 'In Progress',
      'Preview Audit Form': 'View',
    },
    {
      'S.No': '5',
      'Employee ID': 'E005',
      'Name': 'Emily Davis',
      'Self status': 'Pending',
      'Preview Audit Form': 'View',
    },
  ];


  @override
  Widget build(BuildContext context) {
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
            height: 400.h,
            child: KDataTable(columnTitles: columns, rowData: data),
          ),
        ],
      ),
    );
  }
}
