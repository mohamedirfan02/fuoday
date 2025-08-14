import 'package:flutter/material.dart';
import 'package:fuoday/core/themes/app_colors.dart';

// Select Date Utility
Future<void> selectDatePicker(
  BuildContext context,
  TextEditingController controller,
) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
    initialDatePickerMode: DatePickerMode.day,
    helpText: 'Select Date',
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: AppColors.primaryColor,
            onPrimary: AppColors.secondaryColor,
            onSurface: AppColors.titleColor,
          ),
        ),
        child: child!,
      );
    },
  );

  if (picked != null) {
    controller.text = "${picked.day}/${picked.month}/${picked.year}";
  }
}
