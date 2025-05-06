class UserModel {
  final String name;
  final String email;
  final String uid;
  final String? location;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    this.location,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'],
      name: map['name'],
      uid: map['uid'],
      location: map['location'],
    );
  }
  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'uid': uid, 'location': location};
  }
}
