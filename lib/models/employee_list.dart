import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'employee.dart';

@immutable
class EmployeeList extends Equatable {
  final List<Employee> employeeList;

  const EmployeeList({
    required this.employeeList,
  });

  @override
  List<Object> get props => [employeeList];

  factory EmployeeList.fromJson(Map<String, dynamic> parsedJson) {
    var content = parsedJson as List;
    List<Employee> list = content.map((i) => Employee.fromJson(i)).toList();
    return EmployeeList(employeeList: list);
  }
}
