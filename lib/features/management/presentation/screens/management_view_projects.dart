import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_data_table.dart';

class ManagementViewProjects extends StatefulWidget {
  const ManagementViewProjects({super.key});

  @override
  State<ManagementViewProjects> createState() => _ManagementViewProjectsState();
}

class _ManagementViewProjectsState extends State<ManagementViewProjects> {
  // Project Management Data (matching your columns)
  final columns = [
    'S.No',
    'Project Name',
    'Domain',
    'Team Members',
    'Deadline',
  ];

  final data = [
    {
      'S.No': '1',
      'Project Name': 'E-commerce Mobile App',
      'Domain': 'Mobile Development',
      'Team Members': '5',
      'Deadline': '2025-08-15',
    },
    {
      'S.No': '2',
      'Project Name': 'Customer Analytics Dashboard',
      'Domain': 'Data Analytics',
      'Team Members': '3',
      'Deadline': '2025-07-30',
    },
    {
      'S.No': '3',
      'Project Name': 'Cloud Migration System',
      'Domain': 'Cloud Computing',
      'Team Members': '7',
      'Deadline': '2025-09-20',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Table
          SizedBox(
            height: 200.h,
            child: KDataTable(columnTitles: columns, rowData: data),
          ),
        ],
      ),
    );
  }
}
