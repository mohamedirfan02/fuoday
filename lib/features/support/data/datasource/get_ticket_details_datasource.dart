

import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/support/data/models/get_ticket_details_model.dart';

abstract class GetTicketDetailsDataSource {
  Future<Map<String, List<GetTicketDetailsModel>>> fetchTickets(int webUserId);
}

class GetTicketDetailsDataSourceImpl implements GetTicketDetailsDataSource {
  final DioService dio;
  GetTicketDetailsDataSourceImpl(this.dio);

  @override
  Future<Map<String, List<GetTicketDetailsModel>>> fetchTickets(int webUserId) async {
    final resp = await dio.client.get(AppApiEndpointConstants.getTicketsDetails(webUserId));
    if (resp.statusCode! >= 400) throw Exception("Error: ${resp.statusCode}");
    final grouped = resp.data['data']['groupedTickets'] as Map<String, dynamic>;
    return grouped.map((k, v) => MapEntry(
      k,
      (v as List)
          .map((e) => GetTicketDetailsModel.fromJson(e))
          .toList(),
    ));
  }
}
