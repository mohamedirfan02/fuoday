import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_bar.dart';
import 'package:fuoday/commons/widgets/k_tab_bar.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/features/performance/presentation/screens/performance_audit_form.dart';
import 'package:fuoday/features/performance/presentation/screens/performance_employee_audit_form.dart';
import 'package:fuoday/features/performance/presentation/screens/performance_summary.dart';
import 'package:go_router/go_router.dart';

class PerformanceScreen extends StatelessWidget {
  const PerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: KAppBar(
          title: "Performance",
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
              // Tab Bar
              KTabBar(
                tabs: [
                  Tab(text: "Performance Summary"),

                  Tab(text: "Audit Form"),

                  Tab(text: "Employee Audit Form"),
                ],
              ),

              KVerticalSpacer(height: 20.h),

              Expanded(
                child: TabBarView(
                  children: [
                    // Performance Summary
                    PerformanceSummary(),

                    // Audit Form
                    PerformanceAuditForm(),

                    // Employee Audit Form
                    PerformanceEmployeeAuditForm(),
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
