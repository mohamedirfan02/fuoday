class EmployeeProfileEntity {
  final String firstName;
  final String lastName;
  final String? about;
  final String dob;
  final String? address;
  final String email;
  final String contactNumber;
  final String department;
  final String designation;
  final String dateOfJoining;
  final String? reportingManagerName;  // ✅ Change to nullable
  final String empId;

  EmployeeProfileEntity({
    required this.firstName,
    required this.lastName,
    this.about,
    required this.dob,
    this.address,
    required this.email,
    required this.contactNumber,
    required this.department,
    required this.designation,
    required this.dateOfJoining,
    this.reportingManagerName,  // ✅ Remove 'required'
    required this.empId,
  });
}