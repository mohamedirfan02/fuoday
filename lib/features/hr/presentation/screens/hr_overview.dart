import 'package:flutter/material.dart';
import 'package:fuoday/features/hr/domain/entities/hr_overview_entity.dart';
import 'package:fuoday/features/hr/presentation/provider/hr_overview_provider.dart';
import 'package:fuoday/features/hr/presentation/widgets/hr_card.dart';
import 'package:provider/provider.dart';

class HROverviewWidget extends StatelessWidget {
  const HROverviewWidget({super.key, required HROverviewEntity hrOverview});

  @override
  Widget build(BuildContext context) {
    final stats = context.watch<HROverviewProvider>().hrOverview!.stats;

    final cardData = [
      {
        'count': stats.totalEmployees.toString(),
        'description': 'Total Employees',
        'filter': 'this week',
        'icon': Icons.person,
      },
      {
        'count': stats.totalLeaveRequests.toString(),
        'description': 'Total Leave Requests',
        'filter': 'this month',
        'icon': Icons.work,
      },
      {
        'count': stats.totalAttendance.toString(),
        'description': 'Total Attendance',
        'filter': 'today',
        'icon': Icons.check_circle,
      },
      {
        'count': stats.totalPermissions.toString(),
        'description': 'Permissions',
        'filter': 'this week',
        'icon': Icons.rate_review,
      },
      {
        'count': stats.totalLateArrival.toString(),
        'description': 'Late Arrival',
        'filter': 'today',
        'icon': Icons.access_time,
      },
      {
        'count': stats.totalAudits.toString(),
        'description': 'Total Audits',
        'filter': 'this week',
        'icon': Icons.analytics,
      },
      {
        'count': stats.totalEmployees.toString(),
        'description': 'Total Employee Payroll',
        'filter': 'this week',
        'icon': Icons.person_2_outlined,
      },
      {
        'count': (stats.totalRegulationApproval ?? 0).toString(),
        'description': 'Regulation Approval',
        'filter': 'this week',
        'icon': Icons.person_2_outlined,
      },
      // Add more cards if needed
    ];

    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: cardData.length,
      itemBuilder: (context, index) {
        return HRCard(
          totalEmployeesCount: cardData[index]['count'] as String,
          description: cardData[index]['description'] as String,
          filterByHR: cardData[index]['filter'] as String,
          hrCardIcon: cardData[index]['icon'] as IconData,
        );
      },
    );
  }
}

