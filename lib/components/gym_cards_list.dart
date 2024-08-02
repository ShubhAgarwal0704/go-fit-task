import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:progo_fit/components/list_tile.dart';

class GymCardList extends StatelessWidget {
  const GymCardList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Gym').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return SliverFillRemaining(
            child: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else if (snapshot.hasData && snapshot.data != null) {
          var gyms = snapshot.data!.docs;
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                var gym = gyms[index];
                return CustomListTile(
                  gymName: gym['gymName'],
                  gymLocation: gym['gymAddress'],
                  gymImage: gym['imageUrl'],
                  gymDistance: gym['gymDistance'],
                  gymPrice: gym['gymCharge'],
                );
              },
              childCount: gyms.length,
            ),
          );
        } else {
          return const SliverFillRemaining(
            child: Center(child: Text('No data available')),
          );
        }
      },
    );
  }
}
