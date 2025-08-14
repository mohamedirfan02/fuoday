import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/features/management/presentation/widgets/management_open_positions_card.dart';

class ManagementViewOpenPositions extends StatelessWidget {
  const ManagementViewOpenPositions({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemCount: 12,
      separatorBuilder: (context, index) {
        return KVerticalSpacer(height: 12.h);
      },
      itemBuilder: (context, index) {
        return ManagementOpenPositionsCard(
          openPositonJobDesignation: 'Flutter Developer',
          openPositionJobDescription:
              "We are seeking for the mobile app developer experience should be atleast 2 year",
        );
      },
    );
  }
}
