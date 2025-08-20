import 'package:flutter/material.dart';
import 'package:fuoday/features/hr/domain/entities/hr_overview_entity.dart';
import 'package:fuoday/features/hr/presentation/widgets/hr_open_positions_card.dart';
import 'package:provider/provider.dart';
import '../provider/hr_overview_provider.dart';

class HRViewOpenPositionsWidget extends StatelessWidget {
  const HRViewOpenPositionsWidget({super.key, required HROverviewEntity hrOverview});

  @override
  Widget build(BuildContext context) {
    final positions = context.watch<HROverviewProvider>().hrOverview!.openPositions;

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: positions.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final p = positions[index];
        return HROpenPositionsCard(
          openPositonJobDesignation: p.title,
          openPositionJobDescription:
          "Posted at: ${p.postedAt}, Openings: ${p.noOfOpenings}",
        );
      },
    );
  }
}
