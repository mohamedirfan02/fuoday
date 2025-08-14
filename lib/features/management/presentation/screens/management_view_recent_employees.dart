import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/features/management/presentation/widgets/management_recent_employees_card.dart';

class ManagementViewRecentEmployees extends StatelessWidget {
  const ManagementViewRecentEmployees({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(bottom: 70.h),
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) {
        return KVerticalSpacer(height: 10.h);
      },
      itemCount: 10,
      itemBuilder: (context, index) {
        return ManagementRecentEmployeesCard(
          leadingEmployeeFirstLetter: "I",
          employeeName: "Mohammed Irfan",
          employeeDesignation: "Mobile App Developer",
          employeeJoinDate: "11/11/2024",
        );
      },
    );
  }
}
