class AddressModel {
  final String name;
  final String phone;
  final String pincode;
  final String city;
  final String state;
  final String houseName;
  final String locality;

  AddressModel({
    required this.name,
    required this.phone,
    required this.locality,
    required this.city,
    required this.state,
    required this.houseName,
    required this.pincode,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'locality': locality,
      'city': city,
      'state': state,
      'pincode': pincode,
      'houseName': houseName,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      name: map['name'],
      phone: map['phone'],
      locality: map['locality'],
      city: map['city'],
      state: map['state'],
      pincode: map['pincode'],
      houseName: map['houseName'],
    );
  }
}
