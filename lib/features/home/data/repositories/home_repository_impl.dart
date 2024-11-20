import 'package:dartz/dartz.dart';

import '../../../../models/employee.dart';
import '../../../../models/employee_list.dart';
import '../../../../shared/util/app_exception.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasource/remote/home_remote_datasource.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepositoryImpl({required this.homeRemoteDataSource});

  @override
  Future<Either<AppException, List<Employee>>> getEmployees() async {
    final response = await homeRemoteDataSource.getEmployees();
    return response.fold((failure) => Left(failure), (success) {
      final listEmployees =
          success.results.map((e) => Employee.fromJson(e)).toList();
      final EmployeeList employees = EmployeeList(employeeList: listEmployees);
      return Right(employees.employeeList);
    });
  }
}
