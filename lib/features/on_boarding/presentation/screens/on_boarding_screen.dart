import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_linear_gradient_bg.dart';
import 'package:fuoday/commons/widgets/k_svg.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/assets/app_assets_constants.dart';
import 'package:fuoday/core/constants/router/app_route_constants.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/on_boarding/widgets/on_boarding_btn.dart';
import 'package:go_router/go_router.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KLinearGradientBg(
        gradientColor: AppColors.employeeGradientColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),

            Center(
              child: Image.asset(
                AppAssetsConstants.logo,
                height: 200.h,
                width: 200.w,
                fit: BoxFit.cover,
              ),
            ),

            const Spacer(),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 26.w),
              child: Column(
                spacing: 20.h,
                children: [
                  // SubTitle
                  KText(
                    textAlign: TextAlign.center,
                    text:
                        "Welcome to FUODay! Streamline your day and track everything in one place.",
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp,
                    color: AppColors.secondaryColor,
                  ),

                  // Get Stated Btn
                  OnBoardingBtn(
                    btnText: "Get Started",
                    btnTextFontSize: 13.sp,
                    bgColor: AppColors.onBoardingBgColor,
                    textColor: AppColors.onBoardingTextColor,
                    onTap: () async {
                      // Set onboarding status to true
                      await HiveStorageService().setOnBoardingIn(true);

                      // Log onboarding status
                      final status = HiveStorageService().isOnBoardingInStatus;
                      AppLoggerHelper.logInfo('Onboarding status: $status');

                      // Navigate to Login screen
                      GoRouter.of(
                        context,
                      ).pushReplacementNamed(AppRouteConstants.login);
                    },

                    btnHeight: 36.h,
                    btnWidth: double.infinity,
                    borderRadius: 12.r,
                  ),

                  KVerticalSpacer(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
