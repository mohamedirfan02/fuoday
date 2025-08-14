import 'package:fuoday/features/attendance/domain/entities/total_punctual_arrivals_details_entity.dart';
import 'package:fuoday/features/attendance/domain/repository/total_punctual_details_repository.dart';

class GetTotalPunctualArrivalsDetailsUseCase {
  final TotalPunctualDetailsRepository totalPunctualDetailsRepository;

  GetTotalPunctualArrivalsDetailsUseCase({
    required this.totalPunctualDetailsRepository,
  });

  Future<TotalPunctualArrivalsDetailsEntity> call(int webUserId) {
    return totalPunctualDetailsRepository.getTotalPunctualArrivals(webUserId);
  }
}
