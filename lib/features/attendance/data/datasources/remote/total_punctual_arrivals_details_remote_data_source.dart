import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/attendance/data/models/total_punctual_arrivals_details_model.dart';

class TotalPunctualArrivalDetailsRemoteDataSource {
  final DioService dioService;

  TotalPunctualArrivalDetailsRemoteDataSource({required this.dioService});

  Future<TotalPunctualArrivalsDetailsModel> getTotalPunctualArrivalsDetails(
    int webUserId,
  ) async {
    try {
      final response = await dioService.get(
        AppApiEndpointConstants.getPunctualArrivalsDetails(webUserId),
      );

      final data = response.data['data'];
      return TotalPunctualArrivalsDetailsModel.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }
}
