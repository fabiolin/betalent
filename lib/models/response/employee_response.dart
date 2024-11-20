class EmployeeResponse<T> {
  final int id;
  final String name;
  final String job;
  final DateTime admissionDate;
  final String phone;
  final String image;
  final List<T> results;

  EmployeeResponse(
      {required this.id,
      required this.name,
      required this.job,
      required this.admissionDate,
      required this.phone,
      required this.image,
      required this.results});

  factory EmployeeResponse.fromJson(dynamic json, List<T> results,
          {Function(dynamic json)? fixtures}) =>
      EmployeeResponse(
          id: json.containsKey('id') ? json['id'] : null,
          name: json.containsKey('name') ? json['name'] ?? '' : null,
          job: json.containsKey('job') ? json['job'] ?? '' : null,
          admissionDate: json.containsKey('admission_date')
              ? json['admission_date'] ?? ''
              : null,
          phone: json.containsKey('phone') ? json['phone'] ?? '' : null,
          image: json.containsKey('image') ? json['image'] ?? '' : null,
          results: results);

  factory EmployeeResponse.fromJsonList(dynamic json, List<T> results,
          {Function(dynamic json)? fixtures}) =>
      EmployeeResponse(
          id: 0,
          name: '',
          job: '',
          admissionDate: DateTime(0),
          phone: '',
          image: '',
          results: results);

  @override
  String toString() {
    return 'EmployeeResponse('
        'id: $id, '
        'name: $name, '
        'job: $job, '
        'admissionDate: $admissionDate, '
        'phone: $phone, '
        'image: $image, '
        'results: $results '
        ')';
  }
}
