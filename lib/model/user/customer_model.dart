class CustomerModel {
  int id;
  String username;
  String contact;

  CustomerModel({
    required this.id,
    required this.username,
    required this.contact,
  });

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      id: map['id'] as int,
      username: map['username'] as String,
      contact: map['contact'] as String,
    );
  }
}