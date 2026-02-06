import 'package:clean_architecture_example/features/auth/domain/entity/user_entity.dart';

class UserModel {
  final String id;
  final String email;
  final String name;

  UserModel({required this.id, required this.email, required this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(id: json['id'] as String, email: json['email'] as String, name: json['name'] as String);

  Map<String, dynamic> toJson() => {'id': id, 'email': email, 'name': name};

  UserEntity toEntity() => UserEntity(id: id, email: email, name: name);
}
