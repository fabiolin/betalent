import 'package:dartz/dartz.dart';

import '../../../../../models/response/employee_response.dart';
import '../../../../../shared/util/app_exception.dart';

abstract class HomeRemoteDataSource {
  Future<Either<AppException, EmployeeResponse>> getEmployees();
}
