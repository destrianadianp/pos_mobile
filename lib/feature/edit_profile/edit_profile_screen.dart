import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pos_mobile/models/user.dart';
import '../ui/dimension.dart';
import '../ui/shared_view/circle_image_view.dart';
import '../ui/shared_view/custom_button.dart';
import '../ui/shared_view/custom_image_picker.dart';
import '../ui/shared_view/custom_text_form_field.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel user;

   EditProfileScreen({required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late String _profileImageUrl;

  File? _profileImage;


   @override
  void initState() {
    super.initState();
    getUser();

    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _profileImageUrl = '';

  }

    Future<void> getUser() async {
    final Map<String, dynamic> currentUserData = await FirebaseFirestore.instance
        .collection('accounts')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) => value.data() as Map<String, dynamic>);
    setState(() {
      _usernameController.text = currentUserData['firstName'];
      _emailController.text = currentUserData['email'];
      _profileImageUrl = currentUserData['imageUrl'];
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Atur Profil"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: space1000),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleImageView(
                  imageFile: _profileImage,
                  imageAsset: "assets/images/img_profil_default.jpg",
                  imageType: _profileImage != null ? ImageType.file : ImageType.asset,
                  radius: 60, // Ukuran lingkaran gambar profil
                ),
                CustomImagePicker(
                  onImageSelected: (File? selectedImage) {
                    setState(() {
                      _profileImage = selectedImage;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: space1000),
            Padding(
              padding: const EdgeInsets.all(screenPadding),
              child: Form(
                child: Column(
                  children: [
                    CustomTextFormField(
                      placeholder: 'Username',
                      controller: _usernameController,
                    ),
                    CustomTextFormField(
                      placeholder: 'Email',
                      controller: _emailController,
                      enabled: false,
                    ),
                    const SizedBox(height: space1000),
                    CustomButton(
                      child: const Text("Simpan"),
                      onPressed: () {
                        Navigator.pop(context);
                        _saveUserProfile();
                        print("Data disimpan");
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveUserProfile() async {
    try {
      // Simpan username yang baru ke Firebase
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Update displayName di Firebase Authentication
        await user.updateDisplayName(_usernameController.text);
        await user.reload(); // Refresh data pengguna di Firebase

        // Perbarui model lokal
        final updatedUser = UserModel(
          id: widget.user.id,
          email: widget.user.email,
          firstName: _usernameController.text,
        );

        // Menampilkan data yang disimpan untuk debugging
        print("Updated User: ${updatedUser.firstName}");
        print("Updated Profile Image: $_profileImage");

        // Feedback sukses
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profil berhasil diperbarui!")),
        );
      }
    } catch (e) {
      print("Error updating profile: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan: $e")),
      );
    }
  }
}