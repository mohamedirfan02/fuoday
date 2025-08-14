import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class KHomeEmployeeFeedsPendingWorksTile extends StatelessWidget {
  final Color pendingVerticalDividerColor;
  final String pendingProjectTitle;
  final String pendingDeadline;
  final String pendingWorkStatus;

  const KHomeEmployeeFeedsPendingWorksTile({
    super.key,
    required this.pendingVerticalDividerColor,
    required this.pendingProjectTitle,
    required this.pendingDeadline,
    required this.pendingWorkStatus,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Padding(
        padding: EdgeInsets.only(left: 10.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Vertical Divider
            Container(
              width: 3.w,
              decoration: BoxDecoration(
                color: pendingVerticalDividerColor,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),

            SizedBox(width: 16.w), // Space between divider and content
            // Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Project Name: $pendingProjectTitle",
                      style: GoogleFonts.sora(
                        fontWeight: FontWeight.w600,
                        color: AppColors.titleColor,
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Deadline: $pendingDeadline",
                      style: GoogleFonts.sora(
                        fontWeight: FontWeight.w500,
                        color: AppColors.greyColor,
                        fontSize: 10.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Project Status: $pendingWorkStatus",
                      style: GoogleFonts.sora(
                        fontWeight: FontWeight.w500,
                        color: AppColors.greyColor,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
