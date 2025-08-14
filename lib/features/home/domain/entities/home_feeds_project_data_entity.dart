class HomeFeedsProjectDataEntity {
  final List<HomeFeedEntity> assigned;
  final List<HomeFeedEntity> pending;

  HomeFeedsProjectDataEntity({
    required this.assigned,
    required this.pending,
  });
}

class HomeFeedEntity {
  final String date;
  final String description;
  final String assignedBy;
  final String assignedTo;
  final String projectName;
  final String progress;
  final String deadline;

  HomeFeedEntity({
    required this.date,
    required this.description,
    required this.assignedBy,
    required this.assignedTo,
    required this.projectName,
    required this.progress,
    required this.deadline,
  });
}
