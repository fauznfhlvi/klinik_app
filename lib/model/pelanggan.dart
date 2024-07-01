class Pelanggan {
  String id;
  String namaPelanggan;
  String imageName;
  String alamat;

  Pelanggan({
    required this.id,
    required this.namaPelanggan,
    required this.imageName,
    required this.alamat,
  });

  factory Pelanggan.fromJson(Map<String, dynamic> json) {
    return Pelanggan(
      id: json['id'],
      namaPelanggan: json['nama_pelanggan'] ?? '',
      imageName: json['imageName'] ?? '',
      alamat: json['alamat'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_pelanggan': namaPelanggan,
      'imageName': imageName,
      'alamat': alamat,
    };
  }
}
