
import 'package:fuoday/features/hr/domain/entities/hr_overview_entity.dart';

class HROverviewModel extends HROverviewEntity {
  HROverviewModel({
    required HRStats stats,
    required List<RecentEmployee> recentEmployees,
    required List<OpenPosition> openPositions,
  }) : super(stats: stats, recentEmployees: recentEmployees, openPositions: openPositions);

  factory HROverviewModel.fromJson(Map<String, dynamic> json) {
    final stats = HRStats(
      totalEmployees: json['stats']['totalEmployees'] ?? 0,
      totalLeaveRequests: json['stats']['totalLeaveRequests'] ?? 0,
      totalPermissions: json['stats']['totalPermissions'] ?? 0,
      totalAttendance: json['stats']['totalAttendance'] ?? 0,
      totalLateArrival: json['stats']['totalLateArrival'] ?? 0,
      totalEvent: json['stats']['totalEvent'] ?? 0,
      totalAudits: json['stats']['totalAudits'] ?? 0,
      totalRegulationApproval: json['stats']['totalRegulationApproval'] ?? 0,
    );

    final recentEmployees = (json['recentEmployees'] as List<dynamic>)
        .map((e) => RecentEmployee(
      id: e['id'],
      name: e['name'],
      role: e['role'],
      empId: e['emp_id'],
      profilePhoto: e['employee_details']['profile_photo'],
      dateOfJoining: e['employee_details']['date_of_joining'],
    ))
        .toList();

    final openPositions = (json['openPositions'] as List<dynamic>)
        .map((e) => OpenPosition(
      title: e['title'],
      postedAt: e['posted_at'],
      noOfOpenings: e['no_of_openings'],
    ))
        .toList();

    return HROverviewModel(
      stats: stats,
      recentEmployees: recentEmployees,
      openPositions: openPositions,
    );
  }
}
