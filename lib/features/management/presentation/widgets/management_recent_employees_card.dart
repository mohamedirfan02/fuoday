import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ManagementRecentEmployeesCard extends StatelessWidget {
  final String leadingEmployeeFirstLetter;
  final String employeeName;
  final String employeeDesignation;
  final String employeeJoinDate;

  const ManagementRecentEmployeesCard({
    super.key,
    required this.leadingEmployeeFirstLetter,
    required this.employeeName,
    required this.employeeDesignation,
    required this.employeeJoinDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        border: Border.all(width: 0.1.w, color: AppColors.greyColor),
        borderRadius: BorderRadius.circular(8.r),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: AppColors.cardGradientColor,
        ),
      ),

      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryColor,
          child: Center(
            child: KText(
              text: leadingEmployeeFirstLetter,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: AppColors.secondaryColor,
            ),
          ),
        ),
        trailing: Column(
          spacing: 2.h,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // employee Join Date
            KText(
              text: "DOJ",
              fontWeight: FontWeight.w600,
              fontSize: 10.sp,
              color: AppColors.titleColor,
            ),

            // employee Join Date
            KText(
              text: employeeJoinDate,
              fontWeight: FontWeight.w600,
              fontSize: 10.sp,
              color: AppColors.primaryColor,
            ),
          ],
        ),

        title: Text(employeeName),
        subtitle: Text(employeeDesignation),

        titleTextStyle: GoogleFonts.sora(
          fontWeight: FontWeight.w600,
          color: AppColors.titleColor,
          fontSize: 13.sp,
        ),
        subtitleTextStyle: GoogleFonts.sora(
          fontWeight: FontWeight.w500,
          color: AppColors.subTitleColor,
          fontSize: 10.sp,
        ),
      ),
    );
  }
}
