import 'package:dartz/dartz.dart';

import '../../../../models/employee.dart';
import '../../../../shared/util/app_exception.dart';

abstract class HomeRepository {
  Future<Either<AppException, List<Employee>>> getEmployees();
}
