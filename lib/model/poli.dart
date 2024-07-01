class Poli {
  String id;
  String namaPoli;
  String imageName;
  String harga;

  Poli({
    required this.id,
    required this.namaPoli,
    required this.imageName,
    required this.harga,
  });

  factory Poli.fromJson(Map<String, dynamic> json) {
    return Poli(
      id: json['id'],
      namaPoli: json['nama_poli'] ?? '',
      imageName: json['imageName'] ?? '',
      harga: json['harga'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_poli': namaPoli,
      'imageName': imageName,
      'harga': harga,
    };
  }
}
