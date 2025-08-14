import 'package:flutter/material.dart';
import 'package:fuoday/features/hr/presentation/widgets/hr_card.dart';

class HROverview extends StatelessWidget {
  const HROverview({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      // Important for nested scrolling
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two cards per row
        crossAxisSpacing: 16.0, // Horizontal spacing between cards
        mainAxisSpacing: 16.0, // Vertical spacing between rows
        childAspectRatio: 1.2, // Adjust this to control card height/width ratio
      ),
      itemCount: 8,
      // Number of cards you want to display
      itemBuilder: (context, index) {
        // Sample data for different cards
        final cardData = [
          {
            'count': '15',
            'description': 'Total Employees',
            'filter': 'this week',
            'icon': Icons.person,
          },
          {
            'count': '8',
            'description': 'Active Projects',
            'filter': 'this month',
            'icon': Icons.work,
          },
          {
            'count': '23',
            'description': 'Completed Tasks',
            'filter': 'today',
            'icon': Icons.check_circle,
          },
          {
            'count': '5',
            'description': 'Pending Reviews',
            'filter': 'this week',
            'icon': Icons.rate_review,
          },

          {
            'count': '23',
            'description': 'Completed Tasks',
            'filter': 'today',
            'icon': Icons.check_circle,
          },
          {
            'count': '5',
            'description': 'Pending Reviews',
            'filter': 'this week',
            'icon': Icons.rate_review,
          },

          {
            'count': '23',
            'description': 'Completed Tasks',
            'filter': 'today',
            'icon': Icons.check_circle,
          },
          {
            'count': '5',
            'description': 'Pending Reviews',
            'filter': 'this week',
            'icon': Icons.rate_review,
          },
        ];

        return HRCard(
          totalEmployeesCount: cardData[index]['count'] as String,
          description: cardData[index]['description'] as String,
          filterByHR: cardData[index]['filter'] as String,
          hrCardIcon: cardData[index]['icon'] as IconData,
        );
      },
    );
  }
}
