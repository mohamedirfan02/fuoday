import 'package:flutter/material.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/features/attendance/domain/entities/total_early_arrivals_details_entity.dart';
import 'package:fuoday/features/attendance/domain/usecases/get_total_early_arrivals_details_use_case.dart';

class TotalEarlyArrivalsDetailsProvider extends ChangeNotifier {
  final GetTotalEarlyArrivalsUseCase getTotalEarlyArrivalsUseCase;

  TotalEarlyArrivalsDetailsProvider({
    required this.getTotalEarlyArrivalsUseCase,
  });

  bool _isLoading = false;
  String? _errorMessage;
  EarlyArrivalsEntity? _earlyArrivalsDetails;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  EarlyArrivalsEntity? get earlyArrivalsDetails => _earlyArrivalsDetails;

  // ✅ Add this
  EarlyArrivalsEntity? get data => _earlyArrivalsDetails;

  Future<void> fetchTotalEarlyArrivalsDetails(int userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final EarlyArrivalsEntity result =
      await getTotalEarlyArrivalsUseCase.call(userId);

      _earlyArrivalsDetails = result;
      _isLoading = false;

      AppLoggerHelper.logInfo(
        '✅ Early arrivals fetched successfully for userId: $userId',
      );
    } catch (e) {
      _earlyArrivalsDetails = null;
      _isLoading = false;
      _errorMessage = "Failed to fetch early arrivals data.";

      AppLoggerHelper.logError(
        '❌ Error fetching early arrivals for userId $userId',
      );
    }

    notifyListeners();
  }
}

