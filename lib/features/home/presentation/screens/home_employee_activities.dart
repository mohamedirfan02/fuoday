import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/assets/app_assets_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/home/presentation/widgets/k_checkin_button.dart';
import 'package:fuoday/features/home/presentation/widgets/k_home_activities_card.dart';
import 'package:fuoday/features/home/presentation/widgets/k_home_activity_alert_dialog_box.dart';
import 'package:intl/intl.dart';

class HomeEmployeeActivities extends StatefulWidget {
  const HomeEmployeeActivities({super.key});

  @override
  State<HomeEmployeeActivities> createState() => _HomeEmployeeActivitiesState();
}

class _HomeEmployeeActivitiesState extends State<HomeEmployeeActivities> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.allEventsProviderRead.fetchAllEvents();
    });
  }

  // Time Formating
  String formatIsoTime(String? isoString) {
    if (isoString == null) return "00:00:00";
    try {
      final dateTime = DateTime.parse(isoString).toLocal();
      final formatted = DateFormat(
        'h:mm:ss a',
      ).format(dateTime); // 12-hour format
      AppLoggerHelper.logInfo("Formatted Time for $isoString → $formatted");
      return formatted;
    } catch (e) {
      AppLoggerHelper.logError("Time format error: $e");
      return "00:00:00";
    }
  }

  @override
  Widget build(BuildContext context) {
    // Providers
    final checkInProvider = context.checkInProviderWatch;
    final allEventsProvider = context.allEventsProviderWatch;

    // Service
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;
    final name = employeeDetails?['name'] ?? "No Name";
    final int webUserId = int.tryParse(employeeDetails?['web_user_id']?.toString() ?? '') ?? 0;

    return RefreshIndicator(
      onRefresh: () async {
        await context.allEventsProviderRead.fetchAllEvents(forceRefresh: true);
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KVerticalSpacer(height: 20.h),
              KText(
                text: "Welcome, $name!",
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                color: AppColors.titleColor,
              ),
              KVerticalSpacer(height: 10.h),
              KText(
                text: "Your work is going to fill a large part of your life...",
                fontWeight: FontWeight.w500,
                fontSize: 10.sp,
                color: AppColors.titleColor,
              ),
              KVerticalSpacer(height: 20.h),

              /// Timer & Actions
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.all(20.w),
                  width: 200.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: AppColors.primaryColor,
                  ),
                  child: Column(
                    children: [
                      /// ⏱ Timer using Duration format
                      StreamBuilder<int>(
                        stream: checkInProvider.stopWatchTimer.rawTime,
                        initialData: 0,
                        builder: (_, snapshot) {
                          final rawTime = snapshot.data ?? 0;
                          final duration = Duration(milliseconds: rawTime);

                          final hours = duration.inHours;
                          final minutes = duration.inMinutes.remainder(60);
                          final seconds = duration.inSeconds.remainder(60);

                          final formattedTime =
                              '${hours.toString().padLeft(1, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

                          return KText(
                            text: formattedTime,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.sp,
                            color: AppColors.secondaryColor,
                          );
                        },
                      ),

                      KVerticalSpacer(height: 8.h),

                      /// Check-in/out button
                      KCheckInButton(
                        text: checkInProvider.isLoading
                            ? "Loading..."
                            : checkInProvider.isCheckedIn
                            ? "Check Out"
                            : "Check In",
                        fontSize: 8.sp,
                        height: 25.h,
                        width: 100.w,
                        backgroundColor: checkInProvider.isLoading
                            ? Colors.grey
                            : checkInProvider.isCheckedIn
                            ? AppColors.checkOutColor
                            : AppColors.checkInColor,
                        onPressed: checkInProvider.isLoading
                            ? null
                            : () {
                                final now = DateTime.now().toIso8601String();

                                if (checkInProvider.isCheckedIn) {
                                  context.checkInProviderRead.handleCheckOut(
                                    userId: webUserId,
                                    time: now,
                                  );

                                  AppLoggerHelper.logInfo(
                                    "Check Out Web User Id: $webUserId",
                                  );
                                } else {
                                  context.checkInProviderRead.handleCheckIn(
                                    userId: webUserId,
                                    time: now,
                                  );

                                  AppLoggerHelper.logInfo(
                                    "Check In Web User Id: $webUserId",
                                  );
                                }
                              },
                      ),

                      KVerticalSpacer(height: 8.h),

                      /// Status & Location
                      checkInProvider.isLoading
                          ? const CircularProgressIndicator()
                          : KText(
                              text: "Status : ${checkInProvider.status}",
                              fontWeight: FontWeight.w500,
                              fontSize: 10.sp,
                              color: AppColors.secondaryColor,
                            ),
                      KVerticalSpacer(height: 8.h),
                      KAuthFilledBtn(
                        text: "Location onSite",
                        fontSize: 8.sp,
                        onPressed: () {},
                        backgroundColor: AppColors.locationOnSiteColor,
                        height: 25.h,
                        width: 100.w,
                      ),
                      KVerticalSpacer(height: 10.h),

                      /// Check In/Out Times
                      /// Check In/Out Times
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Icon(
                                Icons.login,
                                color: AppColors.secondaryColor,
                              ),
                              KText(
                                text: formatIsoTime(
                                  checkInProvider.checkInTime,
                                ),
                                fontWeight: FontWeight.w500,
                                fontSize: 10.sp,
                                color: AppColors.secondaryColor,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(
                                Icons.logout,
                                color: AppColors.secondaryColor,
                              ),
                              KText(
                                text: formatIsoTime(
                                  checkInProvider.checkOutTime,
                                ),
                                fontWeight: FontWeight.w500,
                                fontSize: 10.sp,
                                color: AppColors.secondaryColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              KVerticalSpacer(height: 20.h),

              /// Events Section
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  KText(
                    text: "Events All",
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: AppColors.titleColor,
                  ),
                  Icon(Icons.event, color: AppColors.titleColor),
                ],
              ),
              KVerticalSpacer(height: 10.h),

              if (allEventsProvider.isLoading)
                const Center(child: CircularProgressIndicator())
              else if (allEventsProvider.error != null)
                KText(
                  text: 'Error: ${allEventsProvider.error}',
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                  fontSize: 12.sp,
                )
              else
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      if (allEventsProvider.celebrations.isNotEmpty)
                        _buildEventCard(
                          context,
                          title: "Celebrations",
                          events: allEventsProvider.celebrations,
                          img: AppAssetsConstants.birthdayImg,
                          bg: AppColors.primaryColor,
                        ),
                      if (allEventsProvider.organizationalPrograms.isNotEmpty)
                        _buildEventCard(
                          context,
                          title: "Organizational Program",
                          events: allEventsProvider.organizationalPrograms,
                          img: AppAssetsConstants.organizationalProgramImg,
                          bg: AppColors.organizationalColor,
                        ),
                      if (allEventsProvider.announcements.isNotEmpty)
                        _buildEventCard(
                          context,
                          title: "Announcements",
                          events: allEventsProvider.announcements,
                          img: AppAssetsConstants.announcementsImg,
                          bg: AppColors.announcementColor,
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard(
    BuildContext context, {
    required String title,
    required List events,
    required String img,
    required Color bg,
  }) {
    // Events
    final event = events.first;

    return Padding(
      padding: EdgeInsets.only(right: 12.w),
      child: KHomeActivitiesCard(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => KHomeActivityAlertDialogBox(
              activityType: title,
              date: formatIsoTime(event.date.toIso8601String()),
              title: event.title,
              subtitle: event.description,
            ),
          );
        },
        svgImage: img,
        cardImgBgColor: bg,
        cardTitle: title,
        members: "${events.length} members",
        count: "${events.length}",
        bgChipColor: bg,
      ),
    );
  }
}
