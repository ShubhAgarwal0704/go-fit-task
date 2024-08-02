import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:progo_fit/models/current_location.dart';

class CommanAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommanAppBar({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required bool isHome,
    required CurrentLocation currentLocation,
  }) : _isHome = isHome;

  final double screenWidth;
  final double screenHeight;
  final bool _isHome;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final currentLocation = Provider.of<CurrentLocation>(context);

    return AppBar(
      backgroundColor: _isHome ? const Color(0xffF1E7FF) : Colors.white,
      title: Row(
        children: [
          SizedBox(
            width: screenWidth * 0.45,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${currentLocation.city}, ${currentLocation.state}, ${currentLocation.country}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.01),
                      child: Image.asset(
                        "assets/drop_down.png",
                        width: screenWidth * 0.045,
                        height: screenHeight * 0.025,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.003),
                  child: Text(
                    "${currentLocation.locality}, ${currentLocation.addressSubAdminArea}, ${currentLocation.postalCode}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(flex: 8),
          _isHome
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: screenWidth * 0.005),
                          child: Image.asset(
                            "assets/points.png",
                            width: screenWidth * 0.04,
                            height: screenHeight * 0.02,
                          ),
                        ),
                        const Text(
                          "Points",
                          style: TextStyle(
                            color: Color(0xff555555),
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.012),
                      child: const Text(
                        "3,256",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
