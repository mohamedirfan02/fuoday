class LeaveReportModel {
  final String date;
  final String type;
  final String from;
  final String to;
  final String days;
  final String reason;
  final String status;

  LeaveReportModel({
    required this.date,
    required this.type,
    required this.from,
    required this.to,
    required this.days,
    required this.reason,
    required this.status,
  });

  factory LeaveReportModel.fromJson(Map<String, dynamic> json) {
    return LeaveReportModel(
      date: json['date'],
      type: json['type'],
      from: json['from'],
      to: json['to'],
      days: json['days'],
      reason: json['reason'],
      status: json['status'],
    );
  }
}
