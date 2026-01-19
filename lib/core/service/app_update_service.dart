import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';

/// Service to check and handle app updates
/// PRODUCTION READY - Handles all edge cases and errors gracefully
class AppUpdateService {
  /// Check for available updates using Google's In-App Update API
  static Future<void> checkForUpdate(BuildContext context) async {
    // Only check on Android platform
    if (!Platform.isAndroid) {
      return;
    }

    try {
      final updateInfo = await InAppUpdate.checkForUpdate();

      // Log update info (remove these logs in production if needed)
      AppLoggerHelper.logInfo('Update check: ${updateInfo.updateAvailability}');

      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        // Critical update - Force user to update
        if (updateInfo.immediateUpdateAllowed) {
          _showForceUpdateDialog(context);
        }
        // Optional update - Show dismissible banner
        else if (updateInfo.flexibleUpdateAllowed) {
          _showUpdateBanner(context);
        }
      }
    } catch (e) {
      final errorString = e.toString();

      // Handle expected errors silently in production
      if (errorString.contains('ERROR_APP_NOT_OWNED')) {
        // App not installed from Play Store - this is normal for debug builds
        // Don't show error to user
        AppLoggerHelper.logInfo('Update check skipped - not from Play Store');
      } else if (errorString.contains('MissingPluginException')) {
        // Plugin not linked - should not happen in production
        AppLoggerHelper.logWarning('Update plugin not linked');
      } else {
        // Unexpected error - log but don't crash
        AppLoggerHelper.logError('Update check error: $e');
      }
    }
  }

  /// Perform immediate update (blocks user until updated)
  static Future<void> performImmediateUpdate() async {
    try {
      await InAppUpdate.performImmediateUpdate();
    } catch (e) {
      AppLoggerHelper.logError('Immediate update failed: $e');
    }
  }

  /// Start flexible update (downloads in background)
  static Future<void> startFlexibleUpdate() async {
    try {
      await InAppUpdate.startFlexibleUpdate();
      // Complete the update when download finishes
      await InAppUpdate.completeFlexibleUpdate();
    } catch (e) {
      AppLoggerHelper.logError('Flexible update failed: $e');
    }
  }

  /// Show force update dialog (user cannot dismiss)
  static void _showForceUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                Icon(Icons.system_update, color: Colors.orange, size: 28),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Update Required',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            content: Text(
              'A new version of the app is available. Please update to continue using Fuoday.',
              style: TextStyle(fontSize: 15),
            ),
            actions: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.download),
                  label: Text('Update Now'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    performImmediateUpdate();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Show update banner (user can dismiss)
  static void _showUpdateBanner(BuildContext context) {
    // Check if scaffold messenger is available
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        padding: EdgeInsets.all(16),
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
        content: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: Theme.of(context).primaryColor,
              size: 24,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Update Available',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'A new version is available with improvements and bug fixes.',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
            child: Text('Later'),
          ),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              startFlexibleUpdate();
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

  /// Open Play Store page (fallback method)
  static Future<void> openPlayStore() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final url = Uri.parse(
        'https://play.google.com/store/apps/details?id=${packageInfo.packageName}',
      );

      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      AppLoggerHelper.logError('Failed to open Play Store: $e');
    }
  }
}