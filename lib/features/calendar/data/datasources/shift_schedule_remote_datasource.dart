import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/calendar/data/models/shift_schedule_model.dart';

class ShiftScheduleRemoteDataSource {
  final DioService dioService;

  ShiftScheduleRemoteDataSource({required this.dioService});

  Future<List<ShiftScheduleModel>> fetchMonthlyShifts(
    String webUserId,
    String month,
  ) async {
    final response = await dioService.post(
      AppApiEndpointConstants.getSchedules,
      data: {'web_user_id': webUserId, 'month': month},
    );

    final data = response.data['data']['shifts'] as List;
    return data.map((json) => ShiftScheduleModel.fromJson(json)).toList();
  }
}
