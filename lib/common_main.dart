import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/providers/checkbox_provider.dart';
import 'package:fuoday/commons/providers/dropdown_provider.dart';
import 'package:fuoday/config/flavors/flavors_config.dart';
import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/constants/storage/app_hive_storage_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/core/providers/app_file_downloader_provider.dart';
import 'package:fuoday/core/providers/app_file_picker_provider.dart';
import 'package:fuoday/core/providers/app_internet_checker_provider.dart';
import 'package:fuoday/core/router/app_router.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/attendance/presentation/providers/total_absent_days_details_provider.dart';
import 'package:fuoday/features/attendance/presentation/providers/total_attendance_details_provider.dart';
import 'package:fuoday/features/attendance/presentation/providers/total_early_arrivals_details_provider.dart';
import 'package:fuoday/features/attendance/presentation/providers/total_late_arrivals_details_provider.dart';
import 'package:fuoday/features/attendance/presentation/providers/total_punctual_arrivals_details_provider.dart';
import 'package:fuoday/features/auth/presentation/providers/employee_auth_login_provider.dart';
import 'package:fuoday/features/auth/presentation/providers/employee_auth_logout_provider.dart';
import 'package:fuoday/features/auth/presentation/providers/sliding_segmented_provider.dart';
import 'package:fuoday/features/bottom_nav/providers/bottom_nav_provider.dart';
import 'package:fuoday/features/calendar/presentation/providers/shift_schedule_provider.dart';
import 'package:fuoday/features/home/presentation/provider/all_events_provider.dart';
import 'package:fuoday/features/home/presentation/provider/check_in_provider.dart';
import 'package:fuoday/features/organizations/domain/usecase/GetDepartmentListUseCase.dart';
import 'package:fuoday/features/organizations/domain/usecase/ser_ind_usecase.dart';
import 'package:fuoday/features/organizations/presentation/providers/DepartmentListProvider.dart';
import 'package:fuoday/features/organizations/presentation/providers/organization_about_provider.dart';
import 'package:fuoday/features/organizations/presentation/providers/services_and_industries_provider.dart';
import 'package:fuoday/features/organizations/presentation/screens/organizations_about.dart';
import 'package:fuoday/features/payslip/presentation/Provider/payroll_provider.dart';
import 'package:fuoday/features/performance/presentation/providers/employee_audit_form_provider.dart';
import 'package:fuoday/features/performance/presentation/providers/employee_audit_provider.dart';
import 'package:fuoday/features/performance/presentation/providers/performance_summary_provider.dart';
import 'package:fuoday/features/performance/presentation/providers/rating_provider.dart';
import 'package:fuoday/features/profile/presentation/providers/profile_edit_provider.dart';
import 'package:fuoday/features/support/domain/usecase/create_ticket_usecase.dart';
import 'package:fuoday/features/support/domain/usecase/get_ticket_details_usecase.dart';
import 'package:fuoday/features/support/persentation/provider/get_ticket_details_provider.dart';
import 'package:fuoday/features/support/persentation/provider/ticket_provider.dart';
import 'package:fuoday/features/teams/presentation/providers/team_members_provider.dart';
import 'package:fuoday/features/teams/presentation/providers/team_project_provider.dart';
import 'package:fuoday/features/teams/presentation/providers/team_reportees_provider.dart';
import 'package:fuoday/features/time_tracker/domain/usecase/get_time_and_project_tracker_UseCase.dart';
import 'package:fuoday/features/time_tracker/presentation/provider/time_tracker_provider.dart';
import 'package:fuoday/features/time_tracker/presentation/screens/time_tracker_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'features/payslip/presentation/Provider/payroll_overview_provider.dart';

void commonMain() async {
  WidgetsFlutterBinding.ensureInitialized();

  // App Api Environment Check
  AppLoggerHelper.logInfo(
    'App Environment Url Check: ${AppApiEndpointConstants.baseUrl}',
  );

  // Hive init
  await Hive.initFlutter();

  // Hive Open Boxes
  await Hive.openBox(AppHiveStorageConstants.apiCacheBox);
  await Hive.openBox(AppHiveStorageConstants.authBoxKey);
  await Hive.openBox(AppHiveStorageConstants.onBoardingBoxKey);
  await Hive.openBox(AppHiveStorageConstants.employeeDetailsBoxKey);

  // dependency injection
  setUpServiceLocator();

  // Initialize hive service
  await getIt<HiveStorageService>().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Bottom Nav Provider
        ChangeNotifierProvider(create: (context) => getIt<BottomNavProvider>()),

        // Sliding Segmented Provider
        ChangeNotifierProvider(
          create: (context) => getIt<SlidingSegmentedProvider>(),
        ),

        // Drop Down Provider
        ChangeNotifierProvider(create: (context) => getIt<DropdownProvider>()),

        // Check Box Provider
        ChangeNotifierProvider(create: (context) => getIt<CheckboxProvider>()),

        // Profile Edit Provider
        ChangeNotifierProvider(
          create: (context) => getIt<ProfileEditProvider>(),
        ),

        // App File Picker Provider
        ChangeNotifierProvider(
          create: (context) => getIt<AppFilePickerProvider>(),
        ),

        // Check In Provider
        ChangeNotifierProvider(create: (context) => getIt<CheckInProvider>()),

        // App File Downloader Provider
        ChangeNotifierProvider(
          create: (context) => getIt<AppFileDownloaderProvider>(),
        ),

        // Employee Auth Login Provider
        ChangeNotifierProvider(
          create: (context) => getIt<EmployeeAuthLoginProvider>(),
        ),

        // Employee Auth Logout Provider
        ChangeNotifierProvider(
          create: (context) => getIt<EmployeeAuthLogoutProvider>(),
        ),

        // All Events Provider
        ChangeNotifierProvider(create: (context) => getIt<AllEventsProvider>()),

        // Shift Schedule Provider
        ChangeNotifierProvider(
          create: (context) => getIt<ShiftScheduleProvider>(),
        ),

        // Team Members Provider
        ChangeNotifierProvider(
          create: (context) => getIt<TeamMembersProvider>(),
        ),

        // Team Project Provider
        ChangeNotifierProvider(
          create: (context) => getIt<TeamProjectProvider>(),
        ),

        // Team Reportee Provider
        ChangeNotifierProvider(
          create: (context) => getIt<TeamReporteesProvider>(),
        ),

        ChangeNotifierProvider(
          create: (_) => TimeTrackerProvider(
            usecase: getIt<GetTimeAndProjectTrackerUseCase>(),
          ),
          child: TimeTrackerScreen(),
        ),

        // Total Attendance Details Provider
        ChangeNotifierProvider(
          create: (context) => getIt<TotalAttendanceDetailsProvider>(),
        ),

        ChangeNotifierProvider(
          create: (_) => getIt<OrganizationAboutProvider>(),
          child: const OrganizationsAbout(),
        ),

        //Organization Services and industries
        ChangeNotifierProvider(
          create: (_) => ServicesAndIndustriesProvider(
            getServicesAndIndustriesUseCase:
                getIt<GetServicesAndIndustriesUseCase>(),
          ),
        ),

        //Organization Dept TeamList
        ChangeNotifierProvider(
          create: (_) => DepartmentListProvider(
            getDepartmentListUseCase: getIt<GetDepartmentListUseCase>(),
          ),
        ),

        // Total Late Arrivals Details Provider
        ChangeNotifierProvider(
          create: (context) => getIt<TotalLateArrivalsDetailsProvider>(),
        ),

        // Total Early Arrivals Details Provider
        ChangeNotifierProvider(
          create: (context) => getIt<TotalEarlyArrivalsDetailsProvider>(),
        ),

        // Total Absent Days Details Provider
        ChangeNotifierProvider(
          create: (context) => getIt<TotalAbsentDaysDetailsProvider>(),
        ),

        // Total Punctual Details Provider
        ChangeNotifierProvider(
          create: (context) => getIt<TotalPunctualArrivalDetailsProvider>(),
        ),

        //create ticket
        ChangeNotifierProvider(
          create: (context) => TicketProvider(getIt<CreateTicketUseCase>()),
        ),

        //get ticket details
        ChangeNotifierProvider(
          create: (context) =>
              GetTicketDetailsProvider(getIt<GetTicketDetailsUseCase>()),
        ),

        // Performance Summary Provider
        ChangeNotifierProvider(
          create: (context) => getIt<PerformanceSummaryProvider>(),
        ),

        // Employee Audit Provider
        ChangeNotifierProvider(
          create: (context) => getIt<EmployeeAuditProvider>(),
        ),

        // Employee Audit Form Provider
        ChangeNotifierProvider(
          create: (context) => getIt<EmployeeAuditFormProvider>(),
        ),

        // Rating Provider
        ChangeNotifierProvider(create: (context) => RatingProvider()),

        // App Internet Checker Provider
        ChangeNotifierProvider(
          create: (context) => AppInternetCheckerProvider(),
        ),

        // Payroll Provider
        ChangeNotifierProvider(
          create: (context) => getIt<PayrollProvider>(),
        ),

        // Payroll Overview Provider
        ChangeNotifierProvider(
          create: (context) => getIt<PayrollOverviewProvider>(),
        ),


      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: AppEnvironment.environmentName == "DEV"
                ? "Fuoday Dev"
                : "Fuoday",
            theme: ThemeData(
              textTheme: GoogleFonts.soraTextTheme(Theme.of(context).textTheme),
            ),
            routerConfig: appRouter,
            builder: (context, child) {
              return Banner(
                message: AppEnvironment.environmentName,
                location: BannerLocation.topEnd,
                color: AppEnvironment.environmentName == "DEV"
                    ? AppColors.checkOutColor
                    : AppColors.checkInColor,
                textStyle: TextStyle(
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.0,
                  letterSpacing: 1.0,
                ),
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
