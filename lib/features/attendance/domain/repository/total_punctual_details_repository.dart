import 'package:fuoday/features/attendance/domain/entities/total_punctual_arrivals_details_entity.dart';

abstract class TotalPunctualDetailsRepository {
  // Get Total Punctual Arrivals
  Future<TotalPunctualArrivalsDetailsEntity> getTotalPunctualArrivals(
    int webUserId,
  );
}
