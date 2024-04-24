class EmployeeDetails {
  final String name;
  final String email;

  final dynamic phoneNumber;
  final String designation;
  final String hireDate;
  final String salary;

  final String isActive;
  EmployeeDetails(
      {required this.name,
      required this.email,
      required this.phoneNumber,
      required this.designation,
      required this.hireDate,
      required this.salary,
      required this.isActive});

  factory EmployeeDetails.fromJson(Map<String, dynamic> json) {
    return EmployeeDetails(
        name: json["username"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        designation: json["designation"],
        hireDate: json['hireDate'],
        salary: json['salary'],
        isActive: json['isActive']);
  }
}
