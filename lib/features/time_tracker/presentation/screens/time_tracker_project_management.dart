import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_data_table.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/time_tracker/domain/entities/time_tracker_entity.dart';

class TimeTrackerProjectManagement extends StatelessWidget {
  final List<Project> data;

  const TimeTrackerProjectManagement({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final columns = [
      'S.No',
      'Daily work progress',
      'Team Members',
      'Deadline',
    ];

    final rowData = data.asMap().entries.map((entry) {
      final i = entry.key;
      final project = entry.value;
      return {
        'S.No': '${i + 1}',
        'Daily work progress': project.progress,
        'Team Members': project.teamInitials.join(','),
        'Deadline': project.deadline,
      };
    }).toList();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KText(
            text: "Project Management",
            fontWeight: FontWeight.w600,
            fontSize: 13.sp,
            color: AppColors.titleColor,
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 600.h,
            child: KDataTable(columnTitles: columns, rowData: rowData),
          ),
        ],
      ),
    );
  }
}
