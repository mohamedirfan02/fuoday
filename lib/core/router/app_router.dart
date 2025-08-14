import 'package:fuoday/core/constants/router/app_route_constants.dart';
import 'package:fuoday/core/models/file_preview_data.dart';
import 'package:fuoday/features/approval/presentation/screens/approval_screen.dart';
import 'package:fuoday/features/attendance/presentation/screens/attendance_absent_days_details_screen.dart';
import 'package:fuoday/features/attendance/presentation/screens/attendance_early_arrivals_details_screen.dart';
import 'package:fuoday/features/attendance/presentation/screens/attendance_late_arrival_details_screen.dart';
import 'package:fuoday/features/attendance/presentation/screens/attendance_punctual_arrival_details_screen.dart';
import 'package:fuoday/features/attendance/presentation/screens/attendance_screen.dart';
import 'package:fuoday/features/attendance/presentation/screens/total_attendance_view_screen.dart';
import 'package:fuoday/features/auth/presentation/screens/auth_forget_password_screen.dart';
import 'package:fuoday/features/auth/presentation/screens/auth_login_screen.dart';
import 'package:fuoday/features/auth/presentation/screens/auth_otp_screen.dart';
import 'package:fuoday/features/bottom_nav/presentation/employee_bottom_nav.dart';
import 'package:fuoday/features/bottom_nav/presentation/recruiter_bottom_nav.dart';
import 'package:fuoday/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:fuoday/features/feeds/presentation/screens/feeds_screen.dart';
import 'package:fuoday/features/home/presentation/screens/home_employee_screen.dart';
import 'package:fuoday/features/home/presentation/screens/home_recruiter_screen.dart';
import 'package:fuoday/features/hr/presentation/screens/hr_screen.dart';
import 'package:fuoday/features/leave_tracker/presentation/screens/leave_tracker_screen.dart';
import 'package:fuoday/features/management/presentation/screens/management_screen.dart';
import 'package:fuoday/features/notification/presentation/screens/notification_screen.dart';
import 'package:fuoday/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:fuoday/features/organizations/presentation/screens/organizations_screen.dart';
import 'package:fuoday/features/payslip/presentation/screens/pay_slip_screen.dart';
import 'package:fuoday/features/performance/presentation/screens/performance_screen.dart';
import 'package:fuoday/features/previews/presentation/screens/image_preview_screen.dart';
import 'package:fuoday/features/previews/presentation/screens/pdf_preview_screen.dart';
import 'package:fuoday/features/profile/presentation/screens/profile_educational_background_screen.dart';
import 'package:fuoday/features/profile/presentation/screens/profile_employment_details_screen.dart';
import 'package:fuoday/features/profile/presentation/screens/profile_on_boarding_screen.dart';
import 'package:fuoday/features/profile/presentation/screens/profile_personal_details_screen.dart';
import 'package:fuoday/features/profile/presentation/screens/profile_professional_experience_screen.dart';
import 'package:fuoday/features/profile/presentation/screens/profile_screen.dart';
import 'package:fuoday/features/splash/presentation/screens/splash_screen.dart';
import 'package:fuoday/features/support/persentation/screens/support_screen.dart';
import 'package:fuoday/features/team_tree/presentation/screens/team_tree_screen.dart';
import 'package:fuoday/features/teams/presentation/screens/teams_screen.dart';
import 'package:fuoday/features/time_tracker/presentation/screens/time_tracker_screen.dart';
import 'package:fuoday/features/work/presentation/screens/work_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  // initial route
  initialLocation: "/splash",

  routes: [
    // splash screen
    GoRoute(
      path: "/splash",
      name: AppRouteConstants.splash,
      builder: (context, state) => SplashScreen(),
    ),

    // on boarding screen
    GoRoute(
      path: "/onBoarding",
      name: AppRouteConstants.onBoarding,
      builder: (context, state) => OnBoardingScreen(),
    ),

    // Auth login screen
    GoRoute(
      path: "/authLogin",
      name: AppRouteConstants.login,
      builder: (context, state) => AuthLoginScreen(),
    ),

    // Auth forget password screen
    GoRoute(
      path: "/authForgetPassword",
      name: AppRouteConstants.forgetPassword,
      builder: (context, state) {
        return AuthForgetPasswordScreen();
      },
    ),

    // Auth forget password screen
    GoRoute(
      path: "/authOTP",
      name: AppRouteConstants.otp,
      builder: (context, state) {
        return AuthOtpScreen();
      },
    ),

    // Home Employee screen
    GoRoute(
      path: "/homeEmployee",
      name: AppRouteConstants.homeEmployee,
      builder: (context, state) {
        return HomeEmployeeScreen();
      },
    ),

    // Home Employee screen
    GoRoute(
      path: "/homeRecruiter",
      name: AppRouteConstants.homeRecruiter,
      builder: (context, state) {
        return HomeRecruiterScreen();
      },
    ),

    // Profile Screen
    GoRoute(
      path: "/profile",
      name: AppRouteConstants.profile,
      builder: (context, state) {
        return ProfileScreen();
      },
    ),

    // Profile educational background screen
    GoRoute(
      path: "/profileEducationalBackground",
      name: AppRouteConstants.profileEducationalBackground,
      builder: (context, state) {
        return ProfileEducationalBackgroundScreen();
      },
    ),

    // Profile Employment Details Screen
    GoRoute(
      path: "/profileEmploymentDetails",
      name: AppRouteConstants.profileEmploymentDetails,
      builder: (context, state) {
        return ProfileEmploymentDetailsScreen();
      },
    ),

    // Profile On Boarding Screen
    GoRoute(
      path: "/profileOnBoarding",
      name: AppRouteConstants.profileOnBoarding,
      builder: (context, state) {
        return ProfileOnBoardingScreen();
      },
    ),

    // Profile Personal Details Screen
    GoRoute(
      path: "/profilePersonalDetails",
      name: AppRouteConstants.profilePersonalDetails,
      builder: (context, state) {
        return ProfilePersonalDetailsScreen();
      },
    ),

    // Profile Professional Experience Screen
    GoRoute(
      path: "/profileProfessionalExperience",
      name: AppRouteConstants.profileProfessionalExperience,
      builder: (context, state) {
        return ProfileProfessionalExperienceScreen();
      },
    ),

    // Approval Screen
    GoRoute(
      path: "/approval",
      name: AppRouteConstants.approval,
      builder: (context, state) {
        return ApprovalScreen();
      },
    ),

    // Feeds Screen
    GoRoute(
      path: "/feeds",
      name: AppRouteConstants.feeds,
      builder: (context, state) {
        return FeedsScreen();
      },
    ),

    // Leave Tracker Screen
    GoRoute(
      path: "/leaveTracker",
      name: AppRouteConstants.leaveTracker,
      builder: (context, state) {
        return LeaveTrackerScreen();
      },
    ),

    // Notification Screen
    GoRoute(
      path: "/notification",
      name: AppRouteConstants.notification,
      builder: (context, state) {
        return NotificationScreen();
      },
    ),

    // Work Screen
    GoRoute(
      path: "/work",
      name: AppRouteConstants.work,
      builder: (context, state) {
        return WorkScreen();
      },
    ),

    // Calendar Screen
    GoRoute(
      path: "/calendar",
      name: AppRouteConstants.calendar,
      builder: (context, state) {
        return CalendarScreen();
      },
    ),

    // employee bottom nav
    GoRoute(
      path: "/employeeBottomNav",
      name: AppRouteConstants.employeeBottomNav,
      builder: (context, state) {
        return EmployeeBottomNav();
      },
    ),

    // recruiter bottom nav
    GoRoute(
      path: "/employeeBottomNav",
      name: AppRouteConstants.recruiterBottomNav,
      builder: (context, state) {
        return RecruiterBottomNav();
      },
    ),

    // Teams Screen
    GoRoute(
      path: "/teams",
      name: AppRouteConstants.teams,
      builder: (context, state) {
        return TeamsScreen();
      },
    ),

    // Organization Screen
    GoRoute(
      path: "/organizations",
      name: AppRouteConstants.organizations,
      builder: (context, state) {
        return OrganizationsScreen();
      },
    ),

    // Attendance Screen
    GoRoute(
      path: "/attendance",
      name: AppRouteConstants.attendance,
      builder: (context, state) {
        return AttendanceScreen();
      },
    ),

    // Attendance Punctual Arrival Details Screen
    GoRoute(
      path: "/attendancePunctualArrivalsDetails",
      name: AppRouteConstants.attendancePunctualArrivalsDetails,
      builder: (context, state) {
        return AttendancePunctualArrivalDetailsScreen();
      },
    ),

    // Attendance Absent Details
    GoRoute(
      path: "/attendanceAbsentDetails",
      name: AppRouteConstants.attendanceAbsentDetails,
      builder: (context, state) {
        return AttendanceAbsentDaysDetailsScreen();
      },
    ),

    // Attendance Late Arrival Details
    GoRoute(
      path: "/attendanceLateArrivalDetails",
      name: AppRouteConstants.attendanceLateArrivalDetails,
      builder: (context, state) {
        return AttendanceLateArrivalDetailsScreen();
      },
    ),

    // Attendance Early Arrival Details
    GoRoute(
      path: "/attendanceEarlyArrivalDetails",
      name: AppRouteConstants.attendanceEarlyArrivalDetails,
      builder: (context, state) {
        return AttendanceEarlyArrivalsDetailsScreen();
      },
    ),

    // Total Attendance View
    GoRoute(
      path: "/totalAttendanceView",
      name: AppRouteConstants.totalAttendanceView,
      builder: (context, state) {
        return TotalAttendanceViewScreen();
      },
    ),

    // Support Screen
    GoRoute(
      path: "/support",
      name: AppRouteConstants.support,
      builder: (context, state) {
        return SupportScreen();
      },
    ),

    // Time Tracker Screen
    GoRoute(
      path: "/timeTracker",
      name: AppRouteConstants.timeTracker,
      builder: (context, state) {
        return TimeTrackerScreen();
      },
    ),

    // Play Slip Screen
    GoRoute(
      path: "/paySlip",
      name: AppRouteConstants.paySlip,
      builder: (context, state) {
        return PaySlipScreen();
      },
    ),

    // Performance Screen
    GoRoute(
      path: "/performance",
      name: AppRouteConstants.performance,
      builder: (context, state) {
        return PerformanceScreen();
      },
    ),

    // Team Tree Screen
    GoRoute(
      path: "/teamTree",
      name: AppRouteConstants.teamTree,
      builder: (context, state) {
        return TeamTreeScreen();
      },
    ),

    // Hr screen
    GoRoute(
      path: "/hr",
      name: AppRouteConstants.hr,
      builder: (context, state) {
        return HRScreen();
      },
    ),

    // Management Screen
    GoRoute(
      path: "/management",
      name: AppRouteConstants.management,
      builder: (context, state) {
        return ManagementScreen();
      },
    ),

    // Pdf Preview Screen
    GoRoute(
      path: "/pdfPreview",
      name: AppRouteConstants.pdfPreview,
      builder: (context, state) {
        final data = state.extra as FilePreviewData;
        return PdfPreviewScreen(
          filePath: data.filePath,
          fileName: data.fileName,
        );
      },
    ),

    // Image Preview Screen
    GoRoute(
      path: "/imagePreview",
      name: AppRouteConstants.imagePreview,
      builder: (context, state) {
        final data = state.extra as FilePreviewData;
        return ImagePreviewScreen(
          filePath: data.filePath,
          fileName: data.fileName,
        );
      },
    ),
  ],
);
