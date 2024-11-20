import 'package:dartz/dartz.dart';

import '../../../../../models/response/employee_response.dart';
import '../../../../../shared/network/network_service.dart';
import '../../../../../shared/network/network_values.dart';
import '../../../../../shared/util/app_exception.dart';
import 'home_remote_datasource.dart';

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final NetworkService networkService;

  HomeRemoteDataSourceImpl({required this.networkService});

  @override
  Future<Either<AppException, EmployeeResponse>> getEmployees() async {
    final response = await networkService.get(EndPoints.getEmployees);

    return response.fold((l) => Left(l), (r) {
      if (r.statusCode != 200) {
        return Left(AppException(
            identifier: EndPoints.getEmployees,
            statusCode: r.statusCode,
            title: r.data['errors'] ?? 'Error while listing employees',
            message: r.statusMessage,
            which: 'http'));
      }

      final jsonData = r.data;
      if (jsonData == null) {
        return Left(
          AppException(
              identifier: EndPoints.getEmployees,
              statusCode: 0,
              title: r.data['errors'] ?? 'Error while listing employees',
              message: 'The data is not in the valid format',
              which: 'http'),
        );
      }

      final employeeResponse =
          EmployeeResponse.fromJsonList(jsonData, jsonData ?? []);
      return Right(employeeResponse);
    });
  }
}
