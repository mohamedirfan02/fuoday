import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_bar.dart';
import 'package:fuoday/commons/widgets/k_data_table.dart';
import 'package:fuoday/commons/widgets/k_download_options_bottom_sheet.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/service/excel_generator_service.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/service/pdf_generator_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/attendance/presentation/widgets/attendance_message_content.dart';
import 'package:fuoday/features/attendance/presentation/widgets/attendance_punctual_arrival_card.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:go_router/go_router.dart';
import 'package:open_filex/open_filex.dart';

class AttendanceLateArrivalDetailsScreen extends StatefulWidget {
  const AttendanceLateArrivalDetailsScreen({super.key});

  @override
  State<AttendanceLateArrivalDetailsScreen> createState() =>
      _AttendanceLateArrivalDetailsScreenState();
}

class _AttendanceLateArrivalDetailsScreenState
    extends State<AttendanceLateArrivalDetailsScreen> {
  // Controllers
  final TextEditingController searchController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  // Service
  late final HiveStorageService hiveService;
  late final Map<String, dynamic>? employeeDetails;
  late final String name;
  late final int webUserId;

  @override
  void initState() {
    hiveService = getIt<HiveStorageService>();
    employeeDetails = hiveService.employeeDetails;
    name = employeeDetails?['name'] ?? "No Name";
    webUserId =
        int.tryParse(employeeDetails?['web_user_id']?.toString() ?? '') ?? 0;

    Future.microtask(() {
      context.totalLateArrivalsDetailsProviderRead.fetchLateArrivalDetails(
        webUserId,
      );
    });

    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Providers
    final provider = context.totalLateArrivalsDetailsProviderWatch;
    final details = provider.data;
    final isLoading = provider.isLoading;
    final error = provider.errorMessage;

    // Cards
    final punctualData = [
      {
        'count': '${details?.totalLateArrivals ?? 0}',
        'label': 'Total Late Days',
      },
      {
        'count': '${details?.totalLateMinutes ?? 0} mins',
        'label': 'Total Late Time',
      },
      {
        'count': '${details?.averageLateMinutes ?? 0} mins',
        'label': 'Average Late Time',
      },
      {
        'count': '${details?.lateArrivalPercentage ?? 0}%',
        'label': 'Late Percentage',
      },
    ];

    // Table columns
    final columns = [
      'S.No',
      'Date',
      'Day',
      'Log on',
      'Log off',
      'Worked hours',
      'Status',
    ];

    // Table data mapping
    final data = (details?.lateArrivalsDetails ?? []).asMap().entries.map((
      entry,
    ) {
      final index = entry.key + 1;
      final record = entry.value;

      final dateObj = DateTime.tryParse(record.date);
      final day = dateObj != null
          ? [
              "Sunday",
              "Monday",
              "Tuesday",
              "Wednesday",
              "Thursday",
              "Friday",
              "Saturday",
            ][dateObj.weekday % 7]
          : '-';

      return {
        'S.No': '$index',
        'Date': record.date,
        'Day': day,
        'Log on': record.checkinTime,
        'Log off': '-',
        'Worked hours': '-',
        'Status': record.currentStatus,
      };
    }).toList();

    return Scaffold(
      appBar: KAppBar(
        title: "Late Arrival Details",
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
                        columns: List<String>.from(columns),
                        title: 'Total late arrival Report',
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
                        columns: List<String>.from(columns),   // 👈 add this
                        filename: 'Total late arrival Report.xlsx',
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Grid Cards
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: punctualData.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12.h,
                  crossAxisSpacing: 12.w,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) {
                  final item = punctualData[index];
                  return AttendancePunctualArrivalCard(
                    punctualCountOrPercentageText: item['count']!,
                    punctualCountOrPercentageDescriptionText: item['label']!,
                  );
                },
              ),

              KVerticalSpacer(height: 10.h),

              KText(
                text: "Filter & Search Options",
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),

              KVerticalSpacer(height: 12.h),

              KAuthTextFormField(
                hintText: "Search by data",
                keyboardType: TextInputType.text,
                suffixIcon: Icons.search,
              ),

              KVerticalSpacer(height: 12.h),

              Row(
                spacing: 20.w,
                children: [
                  Expanded(
                    child: KAuthTextFormField(
                      onTap: () => _selectDate(context, startDateController),
                      controller: startDateController,
                      hintText: "Start Date",
                      keyboardType: TextInputType.datetime,
                      suffixIcon: Icons.date_range,
                    ),
                  ),
                  Expanded(
                    child: KAuthTextFormField(
                      onTap: () => _selectDate(context, endDateController),
                      controller: endDateController,
                      hintText: "End Date",
                      keyboardType: TextInputType.datetime,
                      suffixIcon: Icons.date_range,
                    ),
                  ),
                ],
              ),

              KVerticalSpacer(height: 40.h),

              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else if (error != null)
                Center(child: Text(error))
              else if (data.isEmpty)
                const Center(child: Text('No late arrival records found'))
              else
                SizedBox(
                  height: 200.h,
                  child: KDataTable(columnTitles: columns, rowData: data),
                ),

              KVerticalSpacer(height: 20.h),

              AttendanceMessageContent(
                messageContentTitle: "Performance: High",
                messageContentSubTitle:
                    "You arrive mostly on time, consider arriving a few minutes early to be better prepared",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
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
}
