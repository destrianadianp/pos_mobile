import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pos_mobile/feature/notification/widgets/container_voucher.dart';
import 'package:pos_mobile/feature/ui/color.dart';
import 'package:pos_mobile/feature/ui/dimension.dart';
import '../ui/typography.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Jumlah tab
      child: Scaffold(
        backgroundColor: secondaryColor,
        appBar: AppBar(
          backgroundColor: secondaryColor,
          elevation: 0,
          title: Text(
            'Notifikasi',
            style: sSemiBold.copyWith(color: Colors.black),
          ),
          bottom: TabBar(
            indicatorColor: bgFillSecondary,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Semua"),
                    const SizedBox(width: 5),
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: primaryColor,
                      child: Text(
                        '2', // Jumlah notifikasi untuk tab "Semua"
                        style: sSemiBold.copyWith(color: textSecondary),
                      ),
                    ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Belum dibaca"),
                    const SizedBox(width: 5),
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: primaryColor,
                      child: Text(
                        '1', // Jumlah notifikasi untuk tab "Belum dibaca"
                        style: sSemiBold.copyWith(color: textSecondary),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            // Bagian "month year" dan "Baca Semua" di bawah TabBar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: space400,
                vertical: space150,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('MMMM yyyy').format(DateTime.now()),
                    style: sSemiBold.copyWith(color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Tambahkan aksi untuk "Baca Semua"
                    },
                    child: Text(
                      'Baca Semua',
                      style: sSemiBold.copyWith(color: primaryColor),
                    ),
                  ),
                ],
              ),
            ),
            // Konten TabBarView
            Expanded(
              child: TabBarView(
                children: [
                  // Tab untuk "Semua"
                  ListView(
                    children: const [
                      ContainerVoucher(
                        title: 'Maksi berdua 60 ribuan',
                        desc:
                            'Cuma tiap Senin-Kamis, dapetin 2 My Box + 2 Minuman jadi hemat cuma 60ribuan di Restoran',
                        date: '25 Nov',
                        isReaded: true,
                      ),
                      ContainerVoucher(
                        title: 'Tanggal tua, cari yang hemat yuk',
                        desc:
                            'Dapatkan gratis kentang goreng setiap pembelian 3 Paket Hemat Sambal Matah, weekend kamu dijamin hemat',
                        date: '10 Nov',
                        isReaded: false,
                      ),
                    ],
                  ),
                  ListView(
                    children: const [
                      ContainerVoucher(
                        title: 'Tanggal tua, cari yang hemat yuk',
                        desc:
                            'Dapatkan gratis kentang goreng setiap pembelian 3 Paket Hemat Sambal Matah, weekend kamu dijamin hemat',
                        date: '10 Nov',
                        isReaded: false,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
