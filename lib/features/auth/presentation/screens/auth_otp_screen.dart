import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_linear_gradient_bg.dart';
import 'package:fuoday/commons/widgets/k_svg.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/assets/app_assets_constants.dart';
import 'package:fuoday/core/constants/router/app_route_constants.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_btn.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class AuthOtpScreen extends StatelessWidget {
  const AuthOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: KLinearGradientBg(
        gradientColor: AppColors.employeeGradientColor,
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        SizedBox(height: 40.h),

                        // App Logo
                        KSvg(
                          svgPath: AppAssetsConstants.splashLogo,
                          height: 100.h,
                          width: 100.w,
                          boxFit: BoxFit.cover,
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.authBgColor,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30.r),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              KVerticalSpacer(height: 30.h),

                              KText(
                                text: "Start Your Experience",
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                              ),

                              KVerticalSpacer(height: 10.h),

                              KText(
                                text: "Login Now",
                                fontWeight: FontWeight.w500,
                                color: AppColors.subTitleColor,
                                fontSize: 14.sp,
                              ),

                              KVerticalSpacer(height: 20.h),

                              KSvg(
                                svgPath: AppAssetsConstants.otpImg,
                                height: 0.2.sh,
                                boxFit: BoxFit.contain,
                              ),

                              KVerticalSpacer(height: 30.h),

                              KText(
                                text: "Enter Verification Code",
                                fontWeight: FontWeight.w600,
                                color: AppColors.titleColor,
                                fontSize: 16.sp,
                              ),

                              KVerticalSpacer(height: 20.h),

                              KText(
                                text: "We Sent a code to yoga******@gmail.com",
                                fontWeight: FontWeight.w400,
                                color: AppColors.titleColor,
                                fontSize: 12.sp,
                              ),

                              KVerticalSpacer(height: 20.h),

                              Pinput(
                                length: 6,
                                keyboardType: TextInputType.number,
                                autofocus: true,
                                obscureText: true,
                                defaultPinTheme: PinTheme(
                                  width: 56,
                                  height: 56,
                                  textStyle: GoogleFonts.sora(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    border: Border.all(
                                      color: Colors.grey[300]!,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),

                              KVerticalSpacer(height: 20.h),

                              KAuthFilledBtn(
                                backgroundColor: AppColors.primaryColor,
                                fontSize: 10.sp,
                                text: "Verify",
                                onPressed: () {
                                  GoRouter.of(
                                    context,
                                  ).pushNamed(AppRouteConstants.login);
                                },
                                height: 22.h,
                                width: double.infinity,
                              ),

                              KVerticalSpacer(height: 20.h),

                              KText(
                                text: "Don’t receive OTP code ?",
                                fontWeight: FontWeight.w500,
                                fontSize: 10.sp,
                                color: AppColors.textBtnColor,
                              ),

                              KAuthTextBtn(
                                onTap: () {},
                                text: "Resend code now",
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                                textAlign: TextAlign.center,
                                textColor: AppColors.textBtnColor,
                                showUnderline: true,
                              ),

                              KVerticalSpacer(height: 20.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
