import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:graphview/GraphView.dart';

class TeamTreeScreen extends StatefulWidget {
  const TeamTreeScreen({super.key});

  @override
  State<TeamTreeScreen> createState() => _TeamTreeScreenState();
}

class _TeamTreeScreenState extends State<TeamTreeScreen> {
  final Graph graph = Graph();
  final BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  @override
  void initState() {
    super.initState();

    // Create nodes with unique IDs
    var ceo = Node.Id("ceo");
    var hr = Node.Id("hr");
    var ishManager = Node.Id("ishManager");
    var itManager = Node.Id("itManager");

    var sriVidhya = Node.Id("sriVidhya");

    var eswar = Node.Id("eswar");
    var irfan = Node.Id("irfan");

    // Add nodes to graph
    graph.addNode(ceo);
    graph.addNode(hr);
    graph.addNode(ishManager);
    graph.addNode(itManager);
    graph.addNode(sriVidhya);
    graph.addNode(eswar);
    graph.addNode(irfan);

    // Add edges to create hierarchy
    graph.addEdge(ceo, hr);
    graph.addEdge(ceo, ishManager);
    graph.addEdge(ceo, itManager);
    graph.addEdge(ceo, sriVidhya);

    graph.addEdge(itManager, eswar);
    graph.addEdge(itManager, irfan);

    // Graph layout settings
    builder
      ..siblingSeparation = 25
      ..levelSeparation = 60
      ..subtreeSeparation = 30
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;
  }

  Widget _buildEmployeeCard(String name, String role, String imageUrl) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColors.subTitleColor, width: 1.w),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        width: 120.w, // Fixed width for consistency
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Person Avatar
            CircleAvatar(backgroundImage: NetworkImage(imageUrl), radius: 25.r),

            SizedBox(height: 6.h),

            // Person Name
            KText(
              text: name,
              fontWeight: FontWeight.w600,
              fontSize: 10.sp,
              color: AppColors.titleColor,
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 3.h),

            // Person Role
            KText(
              text: role,
              fontWeight: FontWeight.w600,
              fontSize: 8.sp,
              color: AppColors.greyColor,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar(
        title: "Team Tree",
        centerTitle: true,
        leadingIcon: Icons.arrow_back,
        onLeadingIconPress: () {
          GoRouter.of(context).pop();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            KVerticalSpacer(height: 20.h),

            // Graph View Container
            SizedBox(
              height: 600.h, // Set appropriate height
              child: InteractiveViewer(
                constrained: false,
                boundaryMargin: EdgeInsets.all(100.w),
                minScale: 0.3,
                maxScale: 3.0,
                child: GraphView(
                  graph: graph,
                  algorithm: BuchheimWalkerAlgorithm(
                    builder,
                    TreeEdgeRenderer(builder),
                  ),
                  builder: (Node node) {
                    // Map node IDs to employee information
                    switch (node.key?.value) {
                      case "ceo":
                        return _buildEmployeeCard(
                          "Krishnakanth ST",
                          "FOUNDER & CEO",
                          "https://fuoday-s3-bucket.s3.ap-south-1.amazonaws.com/Thikse/profile/1001.png",
                        );
                      case "hr":
                        return _buildEmployeeCard(
                          "Aysha Begam",
                          "hr",
                          "https://fuoday-s3-bucket.s3.ap-south-1.amazonaws.com/Thikse/profile/1015.jpg",
                        );
                      case "ishManager":
                        return _buildEmployeeCard(
                          "Ishwarya K",
                          "ASSISTANT MANAGER - CC & BANKING",
                          "https://fuoday-s3-bucket.s3.ap-south-1.amazonaws.com/Thikse/image+(7).png",
                        );
                      case "itManager":
                        return _buildEmployeeCard(
                          "Saravanan S",
                          "INFORMATION TECHNOLOGY",
                          "https://fuoday-s3-bucket.s3.ap-south-1.amazonaws.com/Thikse/profile/1005.png",
                        );
                      case "sriVidhya":
                        return _buildEmployeeCard(
                          "Sri Vidhya",
                          "ASSISTANT MANAGER AMAZON",
                          "https://fuoday.com/assets/images/fuoday/logo/default.jpg",
                        );

                      case "eswar":
                        return _buildEmployeeCard(
                          "Easwar raj",
                          "PROJECT MANAGER-IT",
                          "https://fuoday-s3-bucket.s3.ap-south-1.amazonaws.com/Thikse/profile/1047.png",
                        );
                      case "irfan":
                        return _buildEmployeeCard(
                          "Mohamed Irfan",
                          "MOBILE APP DEVELOPER",
                          "https://fuoday-s3-bucket.s3.ap-south-1.amazonaws.com/Thikse/profile/1043.jpg",
                        );

                      default:
                        return const SizedBox();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
