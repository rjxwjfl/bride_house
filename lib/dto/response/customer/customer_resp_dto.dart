class CustomerRespDto {
  int id;
  String userName;
  String contact;

  CustomerRespDto({
    required this.id,
    required this.userName,
    required this.contact,
  });

  factory CustomerRespDto.fromMap(Map<String, dynamic> map) {
    return CustomerRespDto(
      id: map['id'] as int,
      userName: map['username'] as String,
      contact: map['contact'] as String,
    );
  }
}