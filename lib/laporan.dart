import 'package:app/database/helper.dart';
import 'package:app/model/keuangan_model.dart';
import 'package:flutter/material.dart';

class CashFlow extends StatefulWidget {
  final Keuangan? keuangan;
  const CashFlow({Key? key, this.keuangan}) : super(key: key);
  @override
  State<CashFlow> createState() => _CashFlowState();
}

class _CashFlowState extends State<CashFlow> {
  Future<List<Keuangan>?> getDataFromDatabase() async {
    final finances = await Helper.getAllFinance();
    return finances;
  }

  List<Keuangan>? financeList;
  @override
  void initState() {
    super.initState();
    getDataFromDatabase().then((result) {
      setState(() {
        financeList = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laporan'),
      ),
      body: ListView.builder(
          itemCount: financeList?.length ?? 0,
          itemBuilder: ((context, index) {
            final finances = financeList![index];
            Color iconColor =
                finances.kategori == 'pengeluaran' ? Colors.red : Colors.green;
            IconData iconArrow = finances.kategori == 'pemasukan'
                ? Icons.arrow_back_rounded
                : Icons.arrow_forward_rounded;
            String tanda = finances.kategori == 'pemasukan' ? '+' : '-';
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.black,
                      width: 1,
                    )),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '[ ${tanda} ] Rp ${finances.jumlah}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  top: 5,
                                  bottom: 5,
                                ),
                                child: Text(
                                  finances.keterangan,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  top: 5,
                                  bottom: 5,
                                ),
                                child: Text(
                                  '${DateTime.parse(finances.tanggal).day}-${DateTime.parse(finances.tanggal).month}-${DateTime.parse(finances.tanggal).year}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black38,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            iconArrow,
                            color: iconColor,
                            size: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          })),
    );
  }
}
