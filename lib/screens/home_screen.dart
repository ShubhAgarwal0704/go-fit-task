// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:progo_fit/components/gym_cards_list.dart';
import 'package:provider/provider.dart';
import 'package:progo_fit/models/current_location.dart';
import 'package:progo_fit/components/activities_section.dart';
import 'package:progo_fit/components/app_bar.dart';
import 'package:progo_fit/services/get_location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    bool permissionGranted = await LocationService.checkPermissions();
    if (permissionGranted) {
      _getCurrentLocation();
    } else {}
  }

  void _getCurrentLocation() {
    LocationService.getCurrentLocation().listen((Position position) {
      _getAddressFromLatLng(position);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      Placemark place = await LocationService.getAddressFromLatLng(position);
      Provider.of<CurrentLocation>(context, listen: false).updateLocation(
        city: place.locality ?? "",
        state: place.administrativeArea ?? "",
        country: place.country ?? "",
        locality: place.name ?? "",
        postalCode: place.postalCode ?? "",
        addressSubAdminArea: place.subAdministrativeArea ?? "",
      );
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final currentLocation = Provider.of<CurrentLocation>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommanAppBar(
        isHome: true,
        screenWidth: screenWidth,
        screenHeight: screenHeight,
        currentLocation: currentLocation,
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  height: screenHeight * 0.3,
                  decoration: const BoxDecoration(
                    color: Color(0xffF1E7FF),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.05,
                      top: screenHeight * 0.03,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Hello, shubh!",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: screenHeight * 0.003),
                          child: const Text(
                            "What would you like\nto do today?",
                            style: TextStyle(
                              color: Color.fromARGB(255, 131, 76, 219),
                              fontSize: 28,
                              height: 1.2,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: screenHeight * 0.01),
                          child: Row(
                            children: [
                              Container(
                                height: screenHeight * 0.06,
                                width: screenWidth * 0.8,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(32),
                                  border: Border.all(
                                    color:
                                        const Color.fromARGB(88, 38, 69, 179),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: screenWidth * 0.015),
                                      child: Image.asset(
                                        "assets/search.png",
                                        width: screenWidth * 0.09,
                                        height: screenHeight * 0.03,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: screenWidth * 0.015),
                                      child: const Text(
                                        "Find a nearby activity",
                                        style: TextStyle(
                                          color: Color(0x66708580),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Image.asset(
                                "assets/filter.png",
                                width: screenWidth * 0.10,
                                height: screenHeight * 0.05,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const ActivityOptions(),
              ],
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
