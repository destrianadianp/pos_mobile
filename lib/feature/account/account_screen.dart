import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pos_mobile/feature/edit_profile/edit_profile_screen.dart';
import 'package:pos_mobile/feature/ui/color.dart';
import 'package:pos_mobile/feature/ui/dimension.dart';
import 'package:pos_mobile/models/user.dart';

import '../ui/shared_view/circle_image_view.dart'; // Impor CircleImageView

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: secondaryColor, // Menyesuaikan background
      appBar: AppBar(
        backgroundColor: secondaryColor,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(screenPadding),
        child: Column(
          children: [
            // Menampilkan gambar profil bundar
            FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('accounts')
                    .doc(currentUser?.uid)
                    .get(),
                builder: (context, snapshot) {
                  return CircleAvatar(
                      // radius: 30,
                      // backgroundImage: currentUser?.photoURL != null
                      //     ? NetworkImage(currentUser!.photoURL!)
                      //     // : AssetImage('assets/images/profile.jpg') as ImageProvider,
                      //     : snapshot.hasData
                      //         ? NetworkImage(snapshot.data!['imageUrl'])
                      //         : const AssetImage('assets/images/profile.jpg')
                      //             as ImageProvider,
                      );
                }),

            const SizedBox(height: 20),
            FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('accounts')
                    .doc(currentUser?.uid)
                    .get(),
                builder: (context, snapshot) {
                  return Text(snapshot.hasData
                      ? snapshot.data!['firstName']
                      : 'Nama tidak tersedia');
                }),
            const SizedBox(height: 30),

            // Daftar menu
            Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: const Icon(Icons.person_outline),
                title: const Text('Profile'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  if (currentUser!=null) {
                    UserModel userModel = UserModel(
                      id: currentUser.uid,
                      email: currentUser.uid,
                      firstName: currentUser.displayName ?? 'Nama tidak tersedia'
                    );
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfileScreen(user: userModel,)),
                  );
                  }
                  
                },
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: const Icon(Icons.security),
                title: const Text('Kebijakan Privasi'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Implementasikan navigasi ke Kebijakan Privasi
                },
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: const Icon(Icons.info_outline_rounded),
                title: const Text('Syarat dan Ketentuan'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Implementasikan navigasi ke Syarat dan Ketentuan
                },
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: const Icon(Icons.contact_mail),
                title: const Text('Contact us'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Implementasikan navigasi ke Contact us
                },
              ),
            ),
            const Spacer(), // Untuk memberi ruang kosong di bawah

            // Tombol hapus akun di bawah
            TextButton(
              onPressed: () {
                _showDeleteAccountDialog(context);
              },
              child:
                  const Text("Hapus Akun", style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  // Dialog untuk menghapus akun
  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Hapus Akun"),
          content: const Text(
            "Apakah Anda yakin ingin menghapus akun? Semua data Anda akan dihapus secara permanen dan tidak bisa dikembalikan.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Batal"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                print("Akun dihapus");
                Navigator.pop(context);
              },
              child: const Text("Hapus", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
