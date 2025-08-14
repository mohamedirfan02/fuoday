import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class KTeamProjectTile extends StatelessWidget {
  final String projectName;
  final String projectDomain;
  final List<String> projectTeamMembers;
  final String projectStartMonthDate;
  final bool projectStatus;
  final String projectReview;

  const KTeamProjectTile({
    super.key,
    required this.projectName,
    required this.projectDomain,
    required this.projectTeamMembers,
    required this.projectStartMonthDate,
    required this.projectStatus,
    required this.projectReview,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        border: Border.all(width: 1.w, color: AppColors.greyColor),
        borderRadius: BorderRadius.circular(8.r),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFD1D7E8), Color(0xFFEFF1F7), Colors.white],
        ),
      ),
      child: Column(
        spacing: 4.h,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Project
          KText(text: "Project", fontWeight: FontWeight.w600, fontSize: 10.sp),

          // Project Name
          KText(
            text: projectName,
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
          ),

          // Domain
          KText(
            text: "Domain: $projectDomain",
            fontWeight: FontWeight.w600,
            fontSize: 10.sp,
            color: AppColors.subTitleColor,
          ),

          // Team Members
          KText(
            text: "Team Members",
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
            color: AppColors.titleColor,
          ),

          // Project Starting Date
          Chip(
            label: Text(projectStartMonthDate),
            backgroundColor: AppColors.chipColor,
            labelStyle: GoogleFonts.sora(
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),

          // Project Status
          // Project Status
          Row(
            spacing: 8.w,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Approved/Pending
              KText(
                text: projectStatus ? "Approved" : "Pending",
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
                color: projectStatus
                    ? AppColors.approvedColor
                    : AppColors.pendingColor,
              ),

              // Icon
              Icon(
                projectStatus ? Icons.verified_user : Icons.pending,
                color: projectStatus
                    ? AppColors.approvedColor
                    : AppColors.pendingColor,
              ),
            ],
          ),

          // Review Message
          KText(
            text: projectReview,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.center,
            fontSize: 12.sp,
            color: AppColors.subTitleColor,
          ),
        ],
      ),
    );
  }
}
