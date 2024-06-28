class Pelanggan {
  String? id;
  String namaPelanggan;

  Pelanggan({this.id, required this.namaPelanggan});

  factory Pelanggan.fromJson(Map<String, dynamic> json) =>
      Pelanggan(id: json["id"], namaPelanggan: json["nama_pelanggan"]);

  Map<String, dynamic> toJson() => {"nama_pelanggan": namaPelanggan};
}
