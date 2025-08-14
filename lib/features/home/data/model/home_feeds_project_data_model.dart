class HomeFeedsProjectDataModel {
  final List<HomeFeedItem> assigned;
  final List<HomeFeedItem> pending;

  HomeFeedsProjectDataModel({
    required this.assigned,
    required this.pending,
  });

  factory HomeFeedsProjectDataModel.fromJson(Map<String, dynamic> json) {
    return HomeFeedsProjectDataModel(
      assigned: List<HomeFeedItem>.from(
        (json['assigned'] ?? []).map((e) => HomeFeedItem.fromJson(e)),
      ),
      pending: List<HomeFeedItem>.from(
        (json['pending'] ?? []).map((e) => HomeFeedItem.fromJson(e)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'assigned': assigned.map((e) => e.toJson()).toList(),
      'pending': pending.map((e) => e.toJson()).toList(),
    };
  }
}

class HomeFeedItem {
  final String date;
  final String description;
  final String assignedBy;
  final String assignedTo;
  final String projectName;
  final String progress;
  final String deadline;

  HomeFeedItem({
    required this.date,
    required this.description,
    required this.assignedBy,
    required this.assignedTo,
    required this.projectName,
    required this.progress,
    required this.deadline,
  });

  factory HomeFeedItem.fromJson(Map<String, dynamic> json) {
    return HomeFeedItem(
      date: json['date'] ?? '',
      description: json['description'] ?? '',
      assignedBy: json['assigned_by'] ?? '',
      assignedTo: json['assigned_to'] ?? '',
      projectName: json['project_name'] ?? '',
      progress: json['progress'] ?? '',
      deadline: json['deadline'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'description': description,
      'assigned_by': assignedBy,
      'assigned_to': assignedTo,
      'project_name': projectName,
      'progress': progress,
      'deadline': deadline,
    };
  }
}

