import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/features/hr/presentation/widgets/hr_recent_employees_card.dart';

class HRViewRecentEmployees extends StatelessWidget {
  const HRViewRecentEmployees({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) {
        return KVerticalSpacer(height: 10.h);
      },
      itemCount: 10,
      itemBuilder: (context, index) {
        return HRRecentEmployeesCard(
          leadingEmployeeFirstLetter: "I",
          employeeName: "Mohammed Irfan",
          employeeDesignation: "Mobile App Developer",
          employeeJoinDate: "11/11/2024",
        );
      },
    );
  }
}
