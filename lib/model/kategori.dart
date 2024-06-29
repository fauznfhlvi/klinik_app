class Kategori {
  String? id;
  String namaKategori;

  Kategori({this.id, required this.namaKategori});

  factory Kategori.fromJson(Map<String, dynamic> json) =>
      Kategori(id: json["id"], namaKategori: json["nama_kategori"]);

  Map<String, dynamic> toJson() => {"nama_kategori": namaKategori};
}
