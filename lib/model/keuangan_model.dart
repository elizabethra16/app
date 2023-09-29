class Keuangan {
  const Keuangan(
      {this.id,
      required this.tanggal,
      required this.jumlah,
      required this.keterangan,
      required this.kategori});

  final int? id;
  final String tanggal;
  final int? jumlah;
  final String keterangan;
  final String kategori;

  factory Keuangan.fromJson(Map<String, dynamic> json) => Keuangan(
        id: json['id'],
        tanggal: json['tanggal'],
        jumlah: json['jumlah'],
        keterangan: json['keterangan'],
        kategori: json['kategori'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'tanggal': tanggal,
        'jumlah': jumlah,
        'keterangan': keterangan,
        'kategori': kategori
      };
}
