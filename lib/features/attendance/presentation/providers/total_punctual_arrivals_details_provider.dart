import 'package:flutter/material.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/features/attendance/domain/entities/total_punctual_arrivals_details_entity.dart';
import 'package:fuoday/features/attendance/domain/usecases/get_total_punctual_arrivals_details_use_case.dart';

class TotalPunctualArrivalDetailsProvider extends ChangeNotifier {
  final GetTotalPunctualArrivalsDetailsUseCase
  getTotalPunctualArrivalsDetailsUseCase;

  TotalPunctualArrivalDetailsProvider({
    required this.getTotalPunctualArrivalsDetailsUseCase,
  });

  TotalPunctualArrivalsDetailsEntity? _details;
  bool _isLoading = false;
  String? _error;

  TotalPunctualArrivalsDetailsEntity? get details => _details;

  bool get isLoading => _isLoading;

  String? get error => _error;

  Future<void> fetchTotalPunctualArrivalDetails(int webUserId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    AppLoggerHelper.logInfo(
      'Fetching punctual arrival details for employeeId: $webUserId',
    );

    try {
      final result = await getTotalPunctualArrivalsDetailsUseCase(webUserId);
      _details = result;

      AppLoggerHelper.logInfo(
        'Fetched punctual arrivals successfully for $webUserId',
      );
    } catch (e) {
      _error = e.toString();

      AppLoggerHelper.logError(
        'Failed to fetch punctual arrival details for $webUserId: $_error',
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clear() {
    AppLoggerHelper.logInfo('Clearing punctual arrival state');
    _details = null;
    _error = null;
    notifyListeners();
  }
}
