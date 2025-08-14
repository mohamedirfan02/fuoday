import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/themes/app_colors.dart';

class ManagementCard extends StatelessWidget {
  final String totalEmployeesCount;
  final String description;
  final String filterByManagement;
  final IconData managementCardIcon;

  const ManagementCard({
    super.key,
    required this.totalEmployeesCount,
    required this.description,
    required this.filterByManagement,
    required this.managementCardIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 0.4.sw,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          decoration: BoxDecoration(
            border: Border.all(width: 0.1.w, color: AppColors.greyColor),
            borderRadius: BorderRadius.circular(8.r),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColors.cardGradientColor,
            ),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // EmployeeCount
              KText(
                text: totalEmployeesCount,
                fontWeight: FontWeight.w700,
                fontSize: 16.sp,
                color: AppColors.titleColor,
              ),

              KVerticalSpacer(height: 8.h),

              // Description
              KText(
                text: description,
                fontWeight: FontWeight.w500,
                fontSize: 10.sp,
                color: AppColors.titleColor,
              ),

              KVerticalSpacer(height: 4.h),

              Row(
                spacing: 4.w,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    radius: 3.r,
                  ),

                  // filter by week
                  KText(
                    text: filterByManagement,
                    fontWeight: FontWeight.w500,
                    fontSize: 10.sp,
                    color: AppColors.greyColor,
                  ),
                ],
              ),
            ],
          ),
        ),

        Positioned(
          top: 10,
          right: 20,
          child: CircleAvatar(
            radius: 14.r,
            backgroundColor: AppColors.secondaryColor,
            child: Icon(managementCardIcon, color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }
}
