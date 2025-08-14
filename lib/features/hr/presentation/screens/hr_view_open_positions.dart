import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/features/hr/presentation/widgets/hr_open_positions_card.dart';

class HRViewOpenPositions extends StatelessWidget {
  const HRViewOpenPositions({super.key});

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
        return HROpenPositionsCard(
          openPositonJobDesignation: 'Flutter Developer',
          openPositionJobDescription:
              "We are seeking for the mobile app developer experience should be atleast 2 year",
        );
      },
    );
  }
}
