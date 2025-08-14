class ShiftScheduleEntity {
  final int id;
  final int webUserId;
  final String empName;
  final String empId;
  final String date;
  final String shiftStart;
  final String shiftEnd;

  ShiftScheduleEntity({
    required this.id,
    required this.webUserId,
    required this.empName,
    required this.empId,
    required this.date,
    required this.shiftStart,
    required this.shiftEnd,
  });
}
