class PayrollOverviewEntity {
  final PayslipEntity payslip;
  final Map<String, Map<String, num>> salaryComponents; // Earnings/Deductions
  final EmployeeDetailsEntity employeeDetails;
  final OnboardingDetailsEntity onboardingDetails;

  PayrollOverviewEntity({
    required this.payslip,
    required this.salaryComponents,
    required this.employeeDetails,
    required this.onboardingDetails,
  });
}

class PayslipEntity {
  final String month;
  final String basic;
  final num overtime;
  final String totalPaidDays;
  final num lop;
  final String gross;
  final String totalDeductions;
  final String totalSalary;
  final String totalSalaryWord;
  final String status;
  final String date;
  final String companyName;
  final String logo;

  PayslipEntity({
    required this.month,
    required this.basic,
    required this.overtime,
    required this.totalPaidDays,
    required this.lop,
    required this.gross,
    required this.totalDeductions,
    required this.totalSalary,
    required this.totalSalaryWord,
    required this.status,
    required this.date,
    required this.companyName,
    required this.logo,
  });
}

class EmployeeDetailsEntity {
  final String name;
  final String designation;
  final String empId;
  final String dateOfJoining;
  final String year;

  EmployeeDetailsEntity({
    required this.name,
    required this.designation,
    required this.empId,
    required this.dateOfJoining,
    required this.year,
  });
}

class OnboardingDetailsEntity {
  final String? pfAccountNo;
  final String? uan;
  final String? esiNo;
  final String? bankAccountNo;

  OnboardingDetailsEntity({
    this.pfAccountNo,
    this.uan,
    this.esiNo,
    this.bankAccountNo,
  });
}
