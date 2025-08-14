import 'package:flutter/material.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KTabBar extends StatelessWidget {
  final List<Tab> tabs;
  final Color? indicatorColor;
  final Color? selectedLabelColor;
  final Color? unselectedLabelColor;
  final Color? dividerColor;
  final TextStyle? labelStyle;
  final TextStyle? unselectedLabelStyle;
  final BorderRadius? borderRadius;
  final TabBarIndicatorSize? indicatorSize;
  final EdgeInsetsGeometry? indicatorPadding;
  final TabController? controller;

  const KTabBar({
    super.key,
    required this.tabs,
    this.indicatorColor,
    this.selectedLabelColor,
    this.unselectedLabelColor,
    this.dividerColor,
    this.labelStyle,
    this.unselectedLabelStyle,
    this.borderRadius,
    this.indicatorSize,
    this.indicatorPadding,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      tabs: tabs,
      dividerColor: dividerColor ?? AppColors.transparentColor,
      indicator: BoxDecoration(
        color: indicatorColor ?? AppColors.primaryColor,
        borderRadius: borderRadius ?? BorderRadius.circular(15),
      ),
      indicatorColor: AppColors.transparentColor,
      indicatorSize: indicatorSize ?? TabBarIndicatorSize.tab,
      indicatorPadding: indicatorPadding ?? EdgeInsets.zero,
      unselectedLabelColor: unselectedLabelColor ?? AppColors.primaryColor,
      labelColor: selectedLabelColor ?? AppColors.secondaryColor,
      labelStyle:
          labelStyle ??
          GoogleFonts.sora(fontSize: 10.sp, fontWeight: FontWeight.bold),
      unselectedLabelStyle:
          unselectedLabelStyle ??
          GoogleFonts.sora(fontSize: 10.sp, fontWeight: FontWeight.normal),
      labelPadding: EdgeInsets.symmetric(horizontal: 8.w),
      tabAlignment: TabAlignment.center,
      isScrollable: true,
    );
  }
}
