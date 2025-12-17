import 'package:flutter/material.dart';
import 'notification_screen.dart';

class PremiumNotificationCard extends StatelessWidget {
  final NotificationItem notification;
  final VoidCallback onTap;

  const PremiumNotificationCard({
    super.key,
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: notification.isRead
              ? [Colors.white, Colors.grey.shade50]
              : [Colors.white, Colors.blue.shade50.withOpacity(0.25)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Avatar
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _getGradientColors(notification.type),
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      notification.avatar,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                /// CONTENT
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title
                      Text(
                        notification.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A202C),
                        ),
                      ),

                      const SizedBox(height: 8),

                      /// FULL MESSAGE (NO TRUNCATION)
                      Text(
                        notification.message.trim(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// Timestamp
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 14,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _formatTimestamp(notification.timestamp),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Color> _getGradientColors(NotificationType type) {
    switch (type) {
      case NotificationType.achievement:
        return [const Color(0xFFFFD700), const Color(0xFFFFA500)];
      case NotificationType.meeting:
        return [const Color(0xFF4F46E5), const Color(0xFF7C3AED)];
      case NotificationType.financial:
        return [const Color(0xFF10B981), const Color(0xFF059669)];
      case NotificationType.social:
        return [const Color(0xFFEC4899), const Color(0xFFBE185D)];
      case NotificationType.security:
        return [const Color(0xFFEF4444), const Color(0xFFDC2626)];
      case NotificationType.education:
        return [const Color(0xFF3B82F6), const Color(0xFF2563EB)];
      case NotificationType.announcement:
        return [const Color(0xFF8B5CF6), const Color(0xFF7C3AED)];
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final diff = DateTime.now().difference(timestamp);

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';

    return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
  }
}
