
import 'package:equatable/equatable.dart';

class HROverviewEntity extends Equatable {
  final HRStats stats;
  final List<RecentEmployee> recentEmployees;
  final List<OpenPosition> openPositions;

  const HROverviewEntity({
    required this.stats,
    required this.recentEmployees,
    required this.openPositions,
  });

  @override
  List<Object?> get props => [stats, recentEmployees, openPositions];
}

class HRStats extends Equatable {
  final int totalEmployees;
  final int totalLeaveRequests;
  final int totalPermissions;
  final int totalAttendance;
  final int totalLateArrival;
  final int totalEvent;
  final int totalAudits;
  final int totalRegulationApproval;

  const HRStats({
    required this.totalEmployees,
    required this.totalLeaveRequests,
    required this.totalPermissions,
    required this.totalAttendance,
    required this.totalLateArrival,
    required this.totalEvent,
    required this.totalAudits,
    required this.totalRegulationApproval,
  });

  @override
  List<Object?> get props => [
    totalEmployees,
    totalLeaveRequests,
    totalPermissions,
    totalAttendance,
    totalLateArrival,
    totalEvent,
    totalAudits,
    totalRegulationApproval
  ];
}

class RecentEmployee extends Equatable {
  final int id;
  final String name;
  final String role;
  final String empId;
  final String? profilePhoto;
  final String dateOfJoining;

  const RecentEmployee({
    required this.id,
    required this.name,
    required this.role,
    required this.empId,
    required this.profilePhoto,
    required this.dateOfJoining,
  });

  @override
  List<Object?> get props => [id, name, role, empId, profilePhoto, dateOfJoining];
}

class OpenPosition extends Equatable {
  final String title;
  final String postedAt;
  final String noOfOpenings;

  const OpenPosition({
    required this.title,
    required this.postedAt,
    required this.noOfOpenings,
  });

  @override
  List<Object?> get props => [title, postedAt, noOfOpenings];
}
