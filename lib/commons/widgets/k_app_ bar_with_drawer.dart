import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_circular_cache_image.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/themes/app_colors.dart';

class KAppBarWithDrawer extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onDrawerPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final VoidCallback onNotificationPressed;
  final String userName;
  final String cachedNetworkImageUrl;
  final String userDesignation;
  final bool showUserInfo; // New boolean parameter

  const KAppBarWithDrawer({
    super.key,
    required this.onDrawerPressed,
    this.backgroundColor,
    this.iconColor,
    required this.onNotificationPressed,
    required this.userName,
    required this.userDesignation,
    required this.cachedNetworkImageUrl,
    this.showUserInfo = true, // Default to true
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: !showUserInfo,
      // Center title only when user info is not shown
      actions: [
        IconButton(
          onPressed: () {
            HapticFeedback.mediumImpact();
            onNotificationPressed();
          },
          icon: Icon(Icons.notifications, color: AppColors.secondaryColor),
        ),
      ],
      backgroundColor: backgroundColor ?? AppColors.primaryColor,
      leading: IconButton(
        onPressed: onDrawerPressed ?? () {},
        icon: Icon(Icons.menu, color: iconColor ?? AppColors.secondaryColor),
      ),
      title: showUserInfo
          ? Row(
              spacing: 12.w,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Cached Image
                KCircularCachedImage(
                  imageUrl: cachedNetworkImageUrl,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: Column(
                    spacing: 1.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Person Name
                      KText(
                        text: userName,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                        color: AppColors.secondaryColor,
                      ),
                      // Person Designation
                      KText(
                        text: userDesignation,
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                        color: AppColors.secondaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            )
          : null, // When showUserInfo is false, title is null (no user info shown)
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
