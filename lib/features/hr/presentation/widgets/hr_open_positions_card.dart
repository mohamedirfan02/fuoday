import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class HROpenPositionsCard extends StatelessWidget {
  final String openPositonJobDesignation;
  final String openPositionJobDescription;

  const HROpenPositionsCard({
    super.key,
    required this.openPositonJobDesignation,
    required this.openPositionJobDescription,
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
        title: Text(openPositonJobDesignation),
        subtitle: Text(openPositionJobDescription),

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
