enum StatusEnum {
  // Add your specific status enums here, as defined in your SQL table
  // For example: active, inactive, etc.
  activated,
  archived,
  deleted
}

class MovieList {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String title;
  final String userId;
  final StatusEnum status;
  final bool locked;

  MovieList({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.userId,
    required this.status,
    required this.locked,
  });

  factory MovieList.fromJson(Map<String, dynamic> json) {
    return MovieList(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      title: json['title'],
      userId: json['user_id'],
      status: StatusEnum.values
          .firstWhere((e) => e.toString().split('.')[1] == json['status']),
      locked: json['locked'],
    );
  }
}
