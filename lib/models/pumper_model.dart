class Pumper {
  final String id;
  final String name;
  final String mobile;
  final String shiftType;
  final String fuelType;

  Pumper({
    required this.id,
    required this.name,
    required this.mobile,
    required this.shiftType,
    required this.fuelType,
  });

  // method to convert the firebase document in to a dart object
  factory Pumper.fromJson(Map<String, dynamic> json) {
    return Pumper(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      mobile: json['mobile'] ?? '',
      shiftType: json['shiftType'] ?? '',
      fuelType: json['fuelType'] ?? '',
    );
  }

  // convert the product model to a firebase document
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mobile': mobile,
      'shiftType': shiftType,
      'fuelType': fuelType,
    };
  }
}
