import 'package:fuoday/features/attendance/data/datasources/remote/total_punctual_arrivals_details_remote_data_source.dart';
import 'package:fuoday/features/attendance/domain/entities/total_punctual_arrivals_details_entity.dart';
import 'package:fuoday/features/attendance/domain/repository/total_punctual_details_repository.dart';

class TotalPunctualDetailsRepositoryImpl
    implements TotalPunctualDetailsRepository {
  final TotalPunctualArrivalDetailsRemoteDataSource
  totalPunctualArrivalDetailsRemoteDataSource;

  TotalPunctualDetailsRepositoryImpl({
    required this.totalPunctualArrivalDetailsRemoteDataSource,
  });

  @override
  Future<TotalPunctualArrivalsDetailsEntity> getTotalPunctualArrivals(
    int webUserId,
  ) async {
    return await totalPunctualArrivalDetailsRemoteDataSource
        .getTotalPunctualArrivalsDetails(webUserId);
  }
}
