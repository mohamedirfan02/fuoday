import 'package:flutter/material.dart';
import 'package:fuoday/commons/widgets/k_app_%20bar_with_drawer.dart';
import 'package:fuoday/commons/widgets/k_drawer.dart';
import 'package:fuoday/core/di/injection.dart' show getIt;
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/features/attendance/domain/entities/total_attendance_details_entity.dart';
import 'package:fuoday/features/attendance/presentation/providers/total_attendance_details_provider.dart';
import 'package:provider/provider.dart';

import 'notification_card.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late AnimationController _headerController;
  late AnimationController _listController;

  late Animation<double> _headerAnimation;
  late Animation<double> _listAnimation;

  late final HiveStorageService hiveService;
  late final Map<String, dynamic>? employeeDetails;
  late final String name;
  late final int webUserId;


  @override
  void initState() {
    super.initState();

    _headerController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _listController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 800));

    _headerAnimation =
        CurvedAnimation(parent: _headerController, curve: Curves.easeOutCubic);
    _listAnimation =
        CurvedAnimation(parent: _listController, curve: Curves.easeOutCubic);

    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 150), _listController.forward);

    hiveService = getIt<HiveStorageService>();
    employeeDetails = hiveService.employeeDetails;
    name = employeeDetails?['name'] ?? "No Name";
    webUserId =
        int.tryParse(employeeDetails?['web_user_id']?.toString() ?? '') ?? 0;


    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TotalAttendanceDetailsProvider>().fetchAttendanceDetails(webUserId);
    });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _listController.dispose();
    super.dispose();
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  List<NotificationItem> _attendanceToNotifications(
      List<DayAttendanceEntity> days) {
    return days.map((day) {
      return NotificationItem(
        id: day.date ?? '',
        title: '${day.day} - Attendance',
        message: '''
Check-in: ${day.checkin ?? '-'}
Check-out: ${day.checkout ?? '-'}
Worked: ${day.workedHours ?? '-'}
Status: ${day.status ?? '-'}
Regulation: ${day.regulationStatus ?? '-'}
''',
        type: NotificationType.announcement,
        timestamp: DateTime.tryParse(day.date ?? '') ?? DateTime.now(),
        isRead: false,
        priority: day.status == 'Absent'
            ? NotificationPriority.high
            : day.status == 'Late'
            ? NotificationPriority.medium
            : NotificationPriority.low,

        avatar: day.status == 'Present'
            ? '✅'
            : day.status == 'Late'
            ? '⏰'
            : '❌',
      );
    }).toList();
  }

  void _markAsRead(String id) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TotalAttendanceDetailsProvider>();
    final days = provider.attendanceDetails?.data?.days ?? [];
    final notifications = _attendanceToNotifications(days);

    final hive = getIt<HiveStorageService>();
    final emp = hive.employeeDetails ?? {};

    return Scaffold(
      key: _scaffoldKey,
      appBar: KAppBarWithDrawer(
        userName: emp['name'] ?? '',
        cachedNetworkImageUrl: emp['profilePhoto'] ?? '',
        userDesignation: emp['designation'] ?? '',
        showUserInfo: true,
        onDrawerPressed: _openDrawer,
        onNotificationPressed: () {},
      ),
      drawer: KDrawer(
        userName: emp['name'] ?? '',
        userEmail: emp['email'] ?? '',
        profileImageUrl: emp['profilePhoto'] ?? '',
      ),
      body: Column(
        children: [

          /// LIST (ONLY SCROLLABLE AREA)
          Expanded(
            child: AnimatedBuilder(
              animation: _listAnimation,
              builder: (_, __) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (provider.errorMessage != null) {
                  return Center(child: Text(provider.errorMessage!));
                }

                if (notifications.isEmpty) {
                  return _buildEmptyState();
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: notifications.length,
                  itemBuilder: (_, index) {
                    return PremiumNotificationCard(
                      notification: notifications[index],
                      onTap: () => _markAsRead(notifications[index].id),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Text(
        'All caught up 🎉',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}

/// =======================
/// MODELS
/// =======================

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final DateTime timestamp;
  final NotificationPriority priority;
  final String avatar;
  bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.timestamp,
    required this.priority,
    required this.avatar,
    required this.isRead,
  });
}

enum NotificationType {
  achievement,
  meeting,
  financial,
  social,
  security,
  education,
  announcement,
}

enum NotificationPriority { high, medium, low }
