import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_bar.dart';
import 'package:fuoday/commons/widgets/k_data_table.dart';
import 'package:fuoday/commons/widgets/k_download_options_bottom_sheet.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/service/excel_generator_service.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/service/pdf_generator_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:go_router/go_router.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:open_filex/open_filex.dart';

class TotalAttendanceViewScreen extends StatefulWidget {
  const TotalAttendanceViewScreen({super.key});

  @override
  State<TotalAttendanceViewScreen> createState() =>
      _TotalAttendanceViewScreenState();
}

class _TotalAttendanceViewScreenState extends State<TotalAttendanceViewScreen> {
  // Controller
  final TextEditingController monthYearController = TextEditingController();

  late final HiveStorageService hiveService;
  late final Map<String, dynamic>? employeeDetails;
  late final String name;
  late final int webUserId;

  @override
  void initState() {
    super.initState();

    hiveService = getIt<HiveStorageService>();
    employeeDetails = hiveService.employeeDetails;
    name = employeeDetails?['name'] ?? "No Name";
    webUserId =
        int.tryParse(employeeDetails?['web_user_id']?.toString() ?? '') ?? 0;

    Future.microtask(() {
      context.totalAttendanceDetailsProviderRead.fetchAttendanceDetails(
        webUserId,
      );
    });
  }

  @override
  void dispose() {
    monthYearController.dispose();
    super.dispose();
  }

  Future<void> selectMonthYear(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showMonthPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      controller.text = "${picked.month}/${picked.year}";
      // Optionally filter here
    }
  }

  @override
  Widget build(BuildContext context) {
    // Total Attendance Provider
    final totalAttendanceProvider = context.totalAttendanceDetailsProviderWatch;

    // Table Columns
    final columns = [
      'S.No',
      'Date',
      'Day',
      'Log on',
      'Log off',
      'Worked hours',
      'Status',
    ];

    // Table Data
    final List<Map<String, String>> data =
        totalAttendanceProvider.attendanceDetails?.data?.days
            ?.asMap()
            .entries
            .map((entry) {
              final index = entry.key + 1;
              final day = entry.value;

              return {
                'S.No': '$index',
                'Date': day.date ?? '-',
                'Day': day.day ?? '-',
                'Log on': day.checkin ?? '-',
                'Log off': day.checkout ?? '-',
                'Worked hours': day.workedHours ?? '-',
                'Status': day.status ?? '-',
              };
            })
            .toList() ??
        [];

    return Scaffold(
      appBar: KAppBar(
        title: "Total Attendance Details",
        centerTitle: true,
        leadingIcon: Icons.arrow_back,
        onLeadingIconPress: () => GoRouter.of(context).pop(),
      ),
      bottomSheet: Container(
        height: 60.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        margin: EdgeInsets.symmetric(vertical: 10.h),
        child: Center(
          child: KAuthFilledBtn(
            backgroundColor: AppColors.primaryColor,
            height: 24.h,
            width: double.infinity,
            text: "Download",
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                ),
                builder: (context) {
                  return KDownloadOptionsBottomSheet(
                    onPdfTap: () async {
                      // Pdf service
                      final pdfService = getIt<PdfGeneratorService>();

                      // Generating
                      final pdfFile = await pdfService.generateAndSavePdf(
                        data: data,
                        title: 'Total Attendance Report',
                      );

                      // Open a PDF File
                      await OpenFilex.open(pdfFile.path);
                    },
                    onExcelTap: () async {
                      // Excel Service
                      final excelService = getIt<ExcelGeneratorService>();

                      // Implement Excel logic
                      final excelFile = await excelService.generateAndSaveExcel(
                        data: data,
                        filename: 'Total Attendance Report.xlsx',
                      );

                      // Open a Excel File
                      await OpenFilex.open(excelFile.path);
                    },
                  );
                },
              );
            },
            fontSize: 11.sp,
          ),
        ),
      ),
      body: totalAttendanceProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : totalAttendanceProvider.errorMessage != null
          ? Center(child: Text(totalAttendanceProvider.errorMessage!))
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KAuthTextFormField(
                      onTap: () {
                        selectMonthYear(context, monthYearController);
                      },
                      hintText: "Select Month & Year",
                      suffixIcon: Icons.calendar_month_outlined,
                      keyboardType: TextInputType.text,
                      controller: monthYearController,
                    ),
                    KVerticalSpacer(height: 30.h),
                    SizedBox(
                      height: 600.h,
                      child: KDataTable(columnTitles: columns, rowData: data),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
