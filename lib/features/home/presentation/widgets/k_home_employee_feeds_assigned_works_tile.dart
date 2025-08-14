import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class KHomeEmployeeFeedsAssignedWorksTile extends StatelessWidget {
  final Color leadingVerticalDividerColor;
  final String assignedWorksTitle;
  final String assignedWorkSubTitle;
  final String assignedWorkDeadLine;
  final String assignedBy;
  final String assignedTo;
  final String date;
  final String progress;
  final String deadline;

  const KHomeEmployeeFeedsAssignedWorksTile({
    super.key,
    required this.leadingVerticalDividerColor,
    required this.assignedWorksTitle,
    required this.assignedWorkSubTitle,
    required this.assignedWorkDeadLine,
    required this.assignedBy,
    required this.assignedTo,
    required this.date,
    required this.progress,
    required this.deadline,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: ListTile(
        // Leading
        leading: Container(
          width: 3.w,
          decoration: BoxDecoration(
            color: leadingVerticalDividerColor,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),

        // Title
        title: Text(assignedWorksTitle),
        titleTextStyle: GoogleFonts.sora(
          fontWeight: FontWeight.w600,
          color: AppColors.titleColor,
          fontSize: 12.sp,
        ),

        // SubTitle
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Description: $assignedWorkSubTitle", style: GoogleFonts.sora(fontSize: 10.sp)),
            Text("Assigned By: $assignedBy", style: GoogleFonts.sora(fontSize: 10.sp)),
            Text("Assigned To: $assignedTo", style: GoogleFonts.sora(fontSize: 10.sp)),
            Text("Date: $date", style: GoogleFonts.sora(fontSize: 10.sp)),
            Text("Progress: $progress", style: GoogleFonts.sora(fontSize: 10.sp)),
            Text("Deadline: $deadline", style: GoogleFonts.sora(fontSize: 10.sp)),
          ],
        ),
      ),
    );
  }
}
