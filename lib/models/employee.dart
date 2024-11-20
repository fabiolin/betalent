import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

@immutable
class Employee extends Equatable {
  final int id;
  final String name;
  final String job;
  final DateTime admissionDate;
  final String phone;
  final String image;

  const Employee(
      {required this.id,
      required this.name,
      required this.job,
      required this.admissionDate,
      required this.phone,
      required this.image});

  @override
  List<Object> get props => [id, name, job, admissionDate, phone, image];

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
        id: json.containsKey('id') ? json['id'] : null,
        name: json.containsKey('name') ? json['name'] ?? '' : null,
        job: json.containsKey('job') ? json['job'] ?? '' : null,
        admissionDate: json.containsKey('admission_date')
            ? DateFormat("yyyy-MM-ddThh:mm:ss").parse(json['admission_date'])
            : DateTime(0),
        phone: json.containsKey('phone') ? json['phone'] ?? '' : null,
        image: json.containsKey('image') ? json['image'] ?? '' : null);
  }

  static Employee copyWith(
      {required int id,
      required String name,
      required String job,
      required DateTime admissionDate,
      required String phone,
      required String image}) {
    return Employee(
        id: id,
        name: name,
        job: job,
        admissionDate: admissionDate,
        phone: phone,
        image: image);
  }
}
