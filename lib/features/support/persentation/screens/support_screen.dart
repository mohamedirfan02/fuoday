import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/providers/dropdown_provider.dart';
import 'package:fuoday/commons/widgets/k_app_bar.dart';
import 'package:fuoday/commons/widgets/k_drop_down_text_form_field.dart';
import 'package:fuoday/commons/widgets/k_tab_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:fuoday/features/home/data/model/emp_list_model.dart';
import 'package:fuoday/features/home/domain/usecases/emp_list_usecase.dart';
import 'package:fuoday/features/support/domain/entities/ticket_entity.dart';
import 'package:fuoday/features/support/persentation/provider/get_ticket_details_provider.dart';
import 'package:fuoday/features/support/persentation/provider/ticket_provider.dart';
import 'package:fuoday/features/support/persentation/screens/support_assigned.dart';
import 'package:fuoday/features/support/persentation/screens/support_completed.dart';
import 'package:fuoday/features/support/persentation/screens/support_inprogress.dart';
import 'package:fuoday/features/support/persentation/screens/support_unassigned.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  // controllers
  final TextEditingController dateMonthYearController = TextEditingController();
  final TextEditingController assignToPersonController =
      TextEditingController();
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController ticketController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    dateMonthYearController.dispose();
    assignToPersonController.dispose();
    userIdController.dispose();
    categoryController.dispose();
    ticketController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchEmployees();
  }

  List<EmployeeModel> employees = [];
  String? selectedEmployeeName;
  String? selectedEmployeeId;


  Future<void> fetchEmployees() async {
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;

    // Dynamically get web_user_id
    final int webUserId =
        int.tryParse(employeeDetails?['web_user_id']?.toString() ?? '') ?? 0;

    if (webUserId == 0) {
      print("❌ Invalid or missing web_user_id from Hive");
      return;
    }

    final useCase = getIt<FetchEmployeesUseCase>();
    final result = await useCase(webUserId.toString());

    setState(() {
      employees = result;
    });
    print("✅ Employees fetched: ${result.length}");

  }

  @override
  Widget build(BuildContext context) {

    final hive = getIt<HiveStorageService>();
    final id = int.parse(hive.employeeDetails?['web_user_id'] ?? '0');
    context.read<GetTicketDetailsProvider>().fetchTickets(id, context);


    // Select Date
    Future<void> selectDate(
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
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      }

    }


    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: KAppBar(
          title: "Support",
          centerTitle: true,
          leadingIcon: Icons.arrow_back,
          onLeadingIconPress: () {
            GoRouter.of(context).pop();
          },
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
              text: "Raise Ticket",
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.r),
                    ),
                  ),
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 20.w,
                        right: 20.w,
                        bottom:
                            MediaQuery.of(context).viewInsets.bottom +
                            20.h, // keyboard aware
                        top: 10.h,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Drag handle
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 2.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: AppColors.greyColor,
                                ),
                              ),
                            ),

                            KVerticalSpacer(height: 12.h),

                            // Create Ticket
                            KText(
                              text: "Create Ticket",
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                            ),

                            KVerticalSpacer(height: 20.h),

                            // Your KAuthTextFormField widgets...
                            KAuthTextFormField(
                              hintText: "Enter Date",
                              onTap: () async {
                                selectDate(context, dateMonthYearController);
                              },
                              controller: dateMonthYearController,
                              keyboardType: TextInputType.datetime,
                              suffixIcon: Icons.date_range,
                            ),

                            KVerticalSpacer(height: 10.h),

                            // Select Category
                            Consumer<DropdownProvider>(
                              builder: (context, dropDownProvider, child) {
                                return KDropdownTextFormField<String>(
                                  hintText: "Select Priority",
                                  value: dropDownProvider.getValue('priority'),
                                  items: ['High', 'Medium', 'Low'],
                                  onChanged: (value) => dropDownProvider
                                      .setValue('priority', value),
                                );
                              },
                            ),

                            KVerticalSpacer(height: 10.h),

                            // Assign to employee
                            employees.isEmpty
                                ? const Center(child: CircularProgressIndicator()) // or any fallback
                                : KDropdownTextFormField<String>(
                              hintText: "Select assigned person",
                              value: selectedEmployeeName,
                              items: employees.map((e) => e.empName ?? 'Unknown').toList(),
                              onChanged: (value) {
                                final selected = employees.firstWhere((e) => e.empName == value);
                                setState(() {
                                  selectedEmployeeName = selected.empName;
                                  selectedEmployeeId = selected.webUserId.toString();
                                });
                              },
                            ),


                            KVerticalSpacer(height: 10.h),

                            // Enter Category
                            KAuthTextFormField(
                              hintText: "Enter Category",
                              controller: categoryController,
                              keyboardType: TextInputType.text,
                              suffixIcon: Icons.category_rounded,
                            ),

                            KVerticalSpacer(height: 10.h),

                            KAuthTextFormField(
                              maxLines: 4,
                              hintText: "Describe the issues",
                              controller: ticketController,
                              keyboardType: TextInputType.text,
                              suffixIcon: Icons.description,
                            ),

                            KVerticalSpacer(height: 30.h),

                            // Cancel
                            KAuthFilledBtn(
                              height: 24.h,
                              width: double.infinity,
                              text: "Cancel",
                              fontSize: 10.sp,
                              textColor: AppColors.primaryColor,
                              onPressed: () {
                                GoRouter.of(context).pop();
                              },
                              backgroundColor: AppColors.primaryColor
                                  .withOpacity(0.4),
                            ),

                            SizedBox(height: 12.h),

                            // Submit
                            KAuthFilledBtn(
                              height: 24.h,
                              fontSize: 10.sp,
                              width: double.infinity,
                              text: "Submit",
                              textColor: AppColors.secondaryColor,
                              onPressed: () {
                                final hiveService = getIt<HiveStorageService>();
                                final webUserId = int.tryParse(hiveService.employeeDetails?['web_user_id']?.toString() ?? '');

                                if (webUserId == null || selectedEmployeeId == null || selectedEmployeeName == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('❌ Missing required fields')),
                                  );
                                  return;
                                }

                                final ticket = Ticket(
                                  webUserId: webUserId,
                                  ticket: ticketController.text.trim(),
                                  category: categoryController.text.trim(),
                                  assignedToId: int.parse(selectedEmployeeId!),
                                  assignedTo: selectedEmployeeName!,
                                  priority: context.read<DropdownProvider>().getValue('priority') ?? '',
                                  date: dateMonthYearController.text.trim(),
                                );

                                context.read<TicketProvider>().submitTicket(ticket, context);
                              },

                              backgroundColor: AppColors.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              fontSize: 11.sp,
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Search Controller
              KAuthTextFormField(
                hintText: "Search",
                suffixIcon: Icons.search,
                keyboardType: TextInputType.text,
                controller: searchController,
              ),

              KVerticalSpacer(height: 12.h),

              // Department
              Consumer<DropdownProvider>(
                builder: (context, dropDownProvider, child) {
                  return KDropdownTextFormField<String>(
                    hintText: "Select Department",
                    value: dropDownProvider.getValue('department'),
                    items: ['IT', 'Tele Communication', 'BPO'],
                    onChanged: (value) =>
                        dropDownProvider.setValue('department', value),
                  );
                },
              ),

              KVerticalSpacer(height: 12.h),

              // Category
              Consumer<DropdownProvider>(
                builder: (context, dropDownProvider, child) {
                  return KDropdownTextFormField<String>(
                    hintText: "Select Category",
                    value: dropDownProvider.getValue('category'),
                    items: ['IT', 'Tele Communication', 'BPO'],
                    onChanged: (value) =>
                        dropDownProvider.setValue('category', value),
                  );
                },
              ),

              KVerticalSpacer(height: 30.h),

              // Tab Bar
              KTabBar(
                tabs: [
                  // Assigned
                  Tab(text: "Assigned"),

                  // UnAssigned
                  Tab(text: "UnAssigned"),

                  // In Progress
                  Tab(text: "InProgress"),

                  // Completed
                  Tab(text: "Completed"),
                ],
              ),

              SizedBox(height: 30.h),

              Expanded(
                child: TabBarView(
                  children: [
                    // Support Assigned
                    SupportAssigned(),

                    // Support UnAssigned
                    SupportUnassigned(),

                    // Support InProgress
                    SupportInprogress(),

                    // Support Completed
                    SupportCompleted(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
