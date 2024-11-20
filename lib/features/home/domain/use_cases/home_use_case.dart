import 'package:dartz/dartz.dart';

import '../../../../models/employee.dart';
import '../../../../shared/util/app_exception.dart';
import '../repositories/home_repository.dart';

class HomeUseCase {
  final HomeRepository homeRepository;

  HomeUseCase({required this.homeRepository});

  Future<Either<AppException, List<Employee>>> getEmployees() async {
    return homeRepository.getEmployees();
  }
}
