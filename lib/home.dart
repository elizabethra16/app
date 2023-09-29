import 'package:app/database/helper.dart';
import 'package:app/laporan.dart';
import 'package:app/model/keuangan_model.dart';
import 'package:app/pemasukan.dart';
import 'package:app/pengaturan.dart';
import 'package:app/pengeluaran.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Keuangan> finances = [];

  void _fetchFinances() async {
    final allFinances = await Helper.getAllFinance();

    setState(() {
      finances = allFinances ?? [];
      _calculateTotalbyCategory();
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchFinances();
    _calculateTotalbyCategory();
  }

  Map<String, int> totalByCategory = {
    'pemasukan': 0,
    'pengeluaran': 0,
  };

  void _calculateTotalbyCategory() {
    for (final finance in finances) {
      final kategori = finance.kategori;
      final jumlah = finance.jumlah;

      if (kategori == 'pemasukan' && jumlah != null) {
        totalByCategory['pemasukan'] =
            (totalByCategory['pemasukan'] ?? 0) + jumlah;
      } else if (kategori == 'pengeluaran' && jumlah != null) {
        totalByCategory['pengeluaran'] =
            (totalByCategory['pengeluaran'] ?? 0) + jumlah;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  'Rangkuman Bulan ini',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  'Pengeluaran Rp ${totalByCategory['pengeluaran']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  'Pemasukan Rp ${totalByCategory['pemasukan']}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.green),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Card(
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => EntryForm()));
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                // child: Icon(
                                //   Icons.add,
                                //   size: 100,
                                //   color: Colors.blue,
                                // ),
                                child: Image.asset(
                                  "assets/images/pemasukan.png",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        "Pemasukan",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Card(
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => Pengeluaran()));
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                // child: Icon(
                                //   Icons.disabled_by_default_outlined,
                                //   size: 100,
                                //   color: Colors.blue,
                                // ),
                                child: Image.asset(
                                  "assets/images/pengeluaran.png",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        "Pengeluaran",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Card(
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => CashFlow()));
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                // child: Icon(
                                //   Icons.show_chart,
                                //   size: 100,
                                //   color: Colors.blue,
                                // )
                                child: Image.asset(
                                  "assets/images/laporan.png",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        "Detail Cash Flow",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Card(
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => Pengaturan()));
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                // child: Icon(
                                //   Icons.settings,
                                //   size: 100,
                                //   color: Colors.blue,
                                // )
                                child: Image.asset(
                                  "assets/images/settings.png",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        "Pengaturan",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
