import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class KDrawerListTile extends StatelessWidget {
  final String drawerTitle;
  final VoidCallback drawerListTileOnTap;
  final IconData drawerLeadingIcon;

  const KDrawerListTile({
    super.key,
    required this.drawerTitle,
    required this.drawerListTileOnTap,
    required this.drawerLeadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(drawerLeadingIcon, color: AppColors.titleColor),
      title: Text(drawerTitle),
      titleTextStyle: GoogleFonts.sora(
        fontWeight: FontWeight.w500,
        color: AppColors.titleColor,
        fontSize: 12.sp,
      ),
      onTap: () {
        HapticFeedback.mediumImpact();

        drawerListTileOnTap();
      },
    );
  }
}
