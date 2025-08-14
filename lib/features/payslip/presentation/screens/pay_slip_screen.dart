import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_bar.dart';
import 'package:fuoday/commons/widgets/k_tab_bar.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/payslip/presentation/screens/pay_roll.dart';
import 'package:fuoday/features/payslip/presentation/screens/payslip_overview.dart';
import 'package:go_router/go_router.dart';

class PaySlipScreen extends StatelessWidget {
  const PaySlipScreen({super.key});

  @override
  Widget build(BuildContext context) {


return DefaultTabController(
        length: 2,
        child: Scaffold(
          bottomSheet: Container(
            height: 60.h,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            margin: EdgeInsets.symmetric(vertical: 10.h),
            child: Center(
              child: KAuthFilledBtn(
                backgroundColor: AppColors.primaryColor,
                height: 24.h,
                width: double.infinity,
                text: "Download Payslip",
                onPressed: () {},
                fontSize: 11.sp,
              ),
            ),
          ),
          appBar: KAppBar(
            title: "PaySlip",
            centerTitle: true,
            leadingIcon: Icons.arrow_back,
            onLeadingIconPress: () {
              GoRouter.of(context).pop();
            },
          ),

          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                KTabBar(
                  tabs: [
                    // PayRoll
                    Tab(text: "PayRoll"),

                    // OverView
                    Tab(text: "Overview"),
                  ],
                ),

                Expanded(
                  child: TabBarView(
                    children: [
                      // Pay Roll
                      PayRoll(),

                      // Pay Slip Overview
                      PayslipOverview(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
);
  }
}
