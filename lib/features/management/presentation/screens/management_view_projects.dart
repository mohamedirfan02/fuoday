import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_data_table.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/features/teams/presentation/widgets/k_team_project_tile.dart';

class ManagementViewProjects extends StatefulWidget {
  const ManagementViewProjects({super.key});

  @override
  State<ManagementViewProjects> createState() => _ManagementViewProjectsState();
}

class _ManagementViewProjectsState extends State<ManagementViewProjects> {


  @override
  void initState() {
    super.initState();
    final webUserId = getIt<HiveStorageService>()
        .employeeDetails?['web_user_id']
        ?.toString();

    if (webUserId != null) {
      Future.microtask(() {
        context.teamProjectProviderRead.fetchTeamProjects(webUserId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final teamProjectProvider = context.teamProjectProviderWatch;

    if (teamProjectProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (teamProjectProvider.error != null) {
      return Center(child: Text("Error: ${teamProjectProvider.error}"));
    }

    if (teamProjectProvider.projects.isEmpty) {
      return const Center(child: Text("No team projects available."));
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: teamProjectProvider.projects.length,
        itemBuilder: (context, index) {
          final project = teamProjectProvider.projects[index];
          return KTeamProjectTile(
            projectName: project.name,
            projectDomain: project.domain,
            projectTeamMembers: project.teamMembers.map((e) => e.name).toList(),
            projectStartMonthDate: project.deadline,
            projectStatus: true,
            projectReview: "Reviewed",
          );
        },
        separatorBuilder: (context, index) => KVerticalSpacer(height: 10.h),
      ),
    );
  }
}
