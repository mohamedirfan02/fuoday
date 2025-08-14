class EmployeeModel {
  final int webUserId;
  final String empName;
  final String empId;

  EmployeeModel({
    required this.webUserId,
    required this.empName,
    required this.empId,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      webUserId: json['web_user_id'],
      empName: json['emp_name'],
      empId: json['emp_id'],
    );
  }
}
