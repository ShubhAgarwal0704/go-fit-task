import 'package:flutter/material.dart';
import 'package:progo_fit/screens/list_screen.dart';

class ActivityOptions extends StatelessWidget {
  const ActivityOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ActivityOption(
              label: "Gym",
              imagePath: "assets/gym.png",
              onTap: () => _navigateToListScreen(context),
            ),
            ActivityOption(
              label: "Swimming",
              imagePath: "assets/swimming.png",
              onTap: () => _navigateToListScreen(context),
            ),
            ActivityOption(
              label: "Badminton",
              imagePath: "assets/badminton.png",
              onTap: () => _navigateToListScreen(context),
            ),
          ],
        ),
        Row(
          children: [
            ActivityOption(
              label: "Yoga",
              imagePath: "assets/yoga.png",
              onTap: () => _navigateToListScreen(context),
            ),
            ActivityOption(
              label: "Zumba",
              imagePath: "assets/zumba.png",
              onTap: () => _navigateToListScreen(context),
            ),
            GestureDetector(
              onTap: () => _navigateToListScreen(context),
              child: const Padding(
                padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                child: SizedBox(
                  width: 80,
                  height: 100,
                  child: Center(
                    child: Text(
                      "View All",
                      style: TextStyle(
                          color: Color(0xff7E3AF2),
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _navigateToListScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListScreen()),
    );
  }
}

class ActivityOption extends StatelessWidget {
  final String label;
  final String imagePath;
  final VoidCallback onTap;

  const ActivityOption({
    required this.label,
    required this.imagePath,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding:
            EdgeInsets.symmetric(vertical: 20, horizontal: screenWidth * 0.05),
        child: SizedBox(
          width: screenWidth * 0.2,
          height: 100,
          child: Column(
            children: [
              Image.asset(
                imagePath,
                width: 65,
                height: 65,
              ),
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xff555555),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
