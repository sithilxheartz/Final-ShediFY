import 'package:firebase_auth_tutorials/utils/colors.dart';
import 'package:flutter/material.dart';

class DashboardButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget routePage;

  const DashboardButton({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.routePage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => routePage),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: mainColor),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon, size: 60, color: mainColor),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 220,
                      child: Text(
                        subtitle,
                        style: TextStyle(fontSize: 13, color: subTextColor),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 12),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
