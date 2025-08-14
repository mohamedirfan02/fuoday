import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_data_table.dart';
import 'package:fuoday/commons/widgets/k_horizontal_spacer.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/time_tracker/domain/entities/time_tracker_entity.dart';
import 'package:fuoday/features/time_tracker/presentation/widgets/time_tracker_overview_card.dart';
import 'package:intl/intl.dart';

class TimeTrackerOverview extends StatelessWidget {
  final List<Attendance> data;

  const TimeTrackerOverview({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final columns = [
      'S.No',
      'Date',
      'Log on',
      'Log off',
      'Worked hours',
    ];

    final rowData = data.asMap().entries.map((entry) {
      final i = entry.key;
      final attendance = entry.value;
      final dateTime = DateTime.tryParse(attendance.date);
      final dayName = dateTime != null ? DateFormat('EEEE').format(dateTime) : '-';
      return {
        'S.No': '${i + 1}',
        'Date': attendance.date,
        //'Day': dayName,
        'Log on': attendance.firstLogin,
        'Log off': attendance.lastLogout,
        'Worked hours': attendance.totalHours,
      };
    }).toList();

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 0.2.sh,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return TimeTrackerOverviewCard(
                  iconData: Icons.lock_clock,
                  timeTrackerOverviewCardTitle: "Weekly Working Hours",
                  timeTrackerOverviewCardWorkingHours: "48 Hours",
                );
              },
              separatorBuilder: (context, index) => KHorizontalSpacer(width: 10.w),
              itemCount: 3,
            ),
          ),
          KVerticalSpacer(height: 20.h),
          KText(
            text: "Time Management",
            fontWeight: FontWeight.w600,
            fontSize: 13.sp,
            color: AppColors.titleColor,
          ),
          KVerticalSpacer(height: 10.h),
          SizedBox(
            height: 200.h,
            child: KDataTable(columnTitles: columns, rowData: rowData),
          ),
        ],
      ),
    );
  }
}
