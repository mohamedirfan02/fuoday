import 'package:fuoday/features/attendance/domain/entities/total_punctual_arrivals_details_entity.dart';

class TotalPunctualArrivalsDetailsModel
    extends TotalPunctualArrivalsDetailsEntity {
  TotalPunctualArrivalsDetailsModel({
    super.message,
    super.status,
    PunctualDataModel? super.data,
  });

  factory TotalPunctualArrivalsDetailsModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return TotalPunctualArrivalsDetailsModel(
      message: json['message'],
      status: json['status'],
      data: json['data'] != null
          ? PunctualDataModel.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'status': status,
    'data': (data as PunctualDataModel?)?.toJson(),
  };
}

class PunctualDataModel extends PunctualDataEntity {
  PunctualDataModel({
    super.employeeName,
    super.totalPunctualArrivals,
    super.recordsUpdated,
    super.punctualArrivalPercentage,
    List<PunctualArrivalRecordModel>? super.punctualArrivalsDetails,
  });

  factory PunctualDataModel.fromJson(Map<String, dynamic> json) {
    return PunctualDataModel(
      employeeName: json['employeeName'],
      totalPunctualArrivals: json['totalPunctualArrivals'],
      recordsUpdated: json['recordsUpdated'],
      punctualArrivalPercentage: json['punctualArrivalPercentage'],
      punctualArrivalsDetails:
          (json['punctualArrivalsDetails'] as List?)
              ?.map((e) => PunctualArrivalRecordModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'employeeName': employeeName,
    'totalPunctualArrivals': totalPunctualArrivals,
    'recordsUpdated': recordsUpdated,
    'punctualArrivalPercentage': punctualArrivalPercentage,
    'punctualArrivalsDetails': punctualArrivalsDetails
        ?.map((e) => (e as PunctualArrivalRecordModel).toJson())
        .toList(),
  };
}

class PunctualArrivalRecordModel extends PunctualArrivalRecordEntity {
  PunctualArrivalRecordModel({
    super.date,
    super.empName,
    super.checkinTime,
    super.punctualTime,
    super.currentStatus,
  });

  factory PunctualArrivalRecordModel.fromJson(Map<String, dynamic> json) {
    return PunctualArrivalRecordModel(
      date: json['date'],
      empName: json['empName'],
      checkinTime: json['checkinTime'],
      punctualTime: json['punctualTime'],
      currentStatus: json['currentStatus'],
    );
  }

  Map<String, dynamic> toJson() => {
    'date': date,
    'empName': empName,
    'checkinTime': checkinTime,
    'punctualTime': punctualTime,
    'currentStatus': currentStatus,
  };
}
