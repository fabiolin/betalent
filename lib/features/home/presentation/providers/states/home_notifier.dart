import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../di/injector.dart';
import '../../../../../models/employee.dart';
import '../../../../../shared/util/app_exception.dart';
import '../../../domain/use_cases/home_use_case.dart';
import 'home_state.dart';

class HomeNotifier extends StateNotifier<HomeState> {
  final HomeUseCase _homeUseCase = injector.get<HomeUseCase>();

  HomeNotifier() : super(const HomeState.initial());

  Future<void> getEmployees() async {
    state = state.copyWith(
      state: HomeConcreteState.loading,
      isLoading: true,
    );
    final response = await _homeUseCase.getEmployees();
    updateStateFromHomeResponse(response);
  }

  void updateStateFromHomeResponse(Either<AppException, dynamic> response) {
    response.fold((failure) {
      state = state.copyWith(
          state: HomeConcreteState.failure,
          title: failure.title,
          message: failure.message,
          isLoading: false);
    }, (success) async {
      state = state.copyWith(
        state: HomeConcreteState.loaded,
        employee: success is Employee ? success : null,
        listEmployees: success is List<Employee> ? success : null,
        isLoading: false,
        message: '',
      );
    });
  }
}
