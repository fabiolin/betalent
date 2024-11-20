import 'package:const_date_time/const_date_time.dart';
import 'package:equatable/equatable.dart';

import '../../../../../models/employee.dart';

enum HomeConcreteState { initial, loading, loaded, deleted, failure }

class HomeState extends Equatable {
  final HomeConcreteState state;
  final Employee employee;
  final List<Employee> listEmployees;
  final String title;
  final String message;
  final bool isLoading;
  final bool cache;

  const HomeState({
    this.state = HomeConcreteState.initial,
    this.employee = const Employee(
        id: 0,
        name: '',
        job: '',
        admissionDate: ConstDateTime(0),
        image: '',
        phone: ''),
    this.listEmployees = const [],
    this.title = '',
    this.message = '',
    this.isLoading = false,
    this.cache = false,
  });

  const HomeState.initial({
    this.state = HomeConcreteState.initial,
    this.title = '',
    this.message = '',
    this.employee = const Employee(
        id: 0,
        name: '',
        job: '',
        admissionDate: ConstDateTime(0),
        image: '',
        phone: ''),
    this.listEmployees = const [],
    this.isLoading = false,
    this.cache = false,
  });

  HomeState copyWith({
    HomeConcreteState? state,
    String? title,
    String? message,
    Employee? employee,
    List<Employee>? listEmployees,
    bool? isLoading,
    bool? cache,
  }) {
    return HomeState(
        state: state ?? this.state,
        title: title ?? this.title,
        message: message ?? this.message,
        employee: employee ?? this.employee,
        listEmployees: listEmployees ?? this.listEmployees,
        isLoading: isLoading ?? this.isLoading,
        cache: cache ?? this.cache);
  }

  @override
  String toString() {
    return 'HomeState{state: $state, title: $title, message: $message, employee: $employee, listEmployees: $listEmployees, isLoading: $isLoading, cache: $cache}';
  }

  @override
  List<Object?> get props =>
      [state, title, message, employee, listEmployees, isLoading, cache];
}
