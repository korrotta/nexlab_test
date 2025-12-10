class ContactModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;

  ContactModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
    };
  }
}
