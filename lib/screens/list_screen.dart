import 'package:flutter/material.dart';
import 'package:progo_fit/components/app_bar.dart';
import 'package:progo_fit/components/gym_cards_list.dart';
import 'package:provider/provider.dart';
import 'package:progo_fit/models/current_location.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late int _currentIndex = 0;
  List<bool> isSelected = List.generate(10, (_) => false);
  List<String> itemTexts = [
    "Gym",
    "Swimming",
    "Cricket",
    "Badminton",
    "Yoga",
    "Zumba"
  ];

  @override
  Widget build(BuildContext context) {
    final currentLocation = Provider.of<CurrentLocation>(context);
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: CommanAppBar(
        currentLocation: currentLocation,
        isHome: false,
        screenHeight: mediaQueryHeight,
        screenWidth: mediaQueryWidth,
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blueGrey.shade50,
            title: SizedBox(
              height: mediaQueryHeight * 0.045,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: itemTexts.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        isSelected[index] = !isSelected[index];
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected[index]
                              ? const Color.fromARGB(255, 149, 102, 229)
                              : Colors.white,
                          border: Border.all(color: Colors.black38, width: 1.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Center(
                            child: Text(
                              itemTexts[index],
                              style: TextStyle(
                                fontSize: 15,
                                color: isSelected[index]
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const GymCardList(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xff7E3AF2),
        unselectedItemColor: Colors.grey.shade600,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
