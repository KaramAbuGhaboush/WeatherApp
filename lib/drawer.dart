import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _drawerState();
}

class _drawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            height: 150,
            color: Colors.blue,
            child: const Text(
              "Weather app",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 15),
            child: MaterialButton(
              textColor: Colors.black,
              onPressed: () {
                Navigator.of(context).pushReplacementNamed("home");
              },
              child: const Text("Home"),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 15),
            child: MaterialButton(
              textColor: Colors.black,
              onPressed: () {
                Navigator.of(context).pushReplacementNamed("hour");
              },
              child: const Text("Hourly Forecast"),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 15),
            child: MaterialButton(
              textColor: Colors.black,
              onPressed: () {
                Navigator.of(context).pushReplacementNamed("day");
              },
              child: const Text("Daily Forecast"),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 15),
            child: MaterialButton(
              textColor: Colors.black,
              onPressed: () {
                Navigator.of(context).pushReplacementNamed("city");
              },
              child: const Text("Places"),
            ),
          ),
        ],
      ),
    );
  }
}
