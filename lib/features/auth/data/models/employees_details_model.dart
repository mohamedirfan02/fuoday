import 'package:fuoday/features/auth/domain/entities/employee_auth_entities.dart';

class EmployeeDetailsModel extends EmployeeDetailsEntity {
  EmployeeDetailsModel({
    required super.webUserId,
    required super.profilePhoto,
    required super.designation,
    required super.department,
  });

  factory EmployeeDetailsModel.fromJson(Map<String, dynamic> json) {
    return EmployeeDetailsModel(
      webUserId: json['web_user_id'],
      profilePhoto: json['profile_photo'] as String?,
      designation: json['designation'],
      department: json['department'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'web_user_id': webUserId,
      'profile_photo': profilePhoto,
      'designation': designation,
      'department': department,
    };
  }
}
