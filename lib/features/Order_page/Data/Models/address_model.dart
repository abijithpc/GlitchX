class AddressModel {
  final String id;
  final String name;
  final String phone;
  final String pincode;
  final String house;
  final String area;
  final String city;
  final String state;
  final bool isDefault;

  AddressModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.pincode,
    required this.house,
    required this.area,
    required this.city,
    required this.state,
    this.isDefault = false,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'phone': phone,
    'pincode': pincode,
    'house': house,
    'area': area,
    'city': city,
    'state': state,
    'isDefault': isDefault,
  };

  factory AddressModel.fromMap(Map<String, dynamic> map) => AddressModel(
    id: map['id'],
    name: map['name'],
    phone: map['phone'],
    pincode: map['pincode'],
    house: map['house'],
    area: map['area'],
    city: map['city'],
    state: map['state'],
    isDefault: map['isDefault'] ?? false,
  );
}
