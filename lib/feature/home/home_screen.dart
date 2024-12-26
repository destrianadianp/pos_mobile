import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pos_mobile/feature/menu/menu_screen.dart';
import 'widgets/recomended_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Future<List<Map<String, dynamic>>> _fetchRecommendedData() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchRecommendedData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No users found.'));
          } else {
            final users = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 3 / 4,
              ),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return RecomendedCard(
                  name: user['userName'] ?? 'No username',
                  distance: user['distance']?.toString(),
                  discount: user['discount']?.toString(),
                  imageUrl: user['imageUrl'],
                  rating: user['rating']?.toDouble(),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MenuScreen(userId: user['id'],)));
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
