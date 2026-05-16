import 'package:flutter/material.dart';
import 'package:profile_lift/profile_lift.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = true;
  bool notifications = true;

  ProfileLiftTheme get currentTheme {
    return isDarkMode
        ? const ProfileLiftTheme(
            backgroundColor: Colors.black,
            cardColor: Color(0xff1b1b1b),
            textColor: Colors.white,
            subtitleColor: Colors.white70,
            primaryColor: Colors.blue,
            logoutColor: Colors.red,
          )
        : const ProfileLiftTheme(
            backgroundColor: Colors.white,
            cardColor: Color(0xfff2f2f2),
            textColor: Colors.black,
            subtitleColor: Colors.black54,
            primaryColor: Colors.blue,
            logoutColor: Colors.red,
          );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Builder(
        builder: (context) {
          return ProfileLiftScreen(
            editable: true,
            theme: currentTheme,

            profile: const ProfileLiftModel(
              name: "Christopher Baker",
              email: "christopherbaker@gmail.com",
              phone: "+91876543210",
              address: "New York, USA",
              bio:
                  "Flutter developer passionate about beautiful UI, animations, backend systems and reusable packages.",
              imageUrl: "https://i.pravatar.cc/300?img=12",
            ),

            onSettings: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfileLiftSettings(
                    darkMode: isDarkMode,
                    notifications: notifications,
                    onDarkModeChanged: (value) {
                      setState(() {
                        isDarkMode = value;
                      });
                      Navigator.pop(context);
                    },
                    onNotificationsChanged: (value) {
                      setState(() {
                        notifications = value;
                      });
                    },
                  ),
                ),
              );
            },

            onLogout: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Logout"),
                  content: const Text("Are you sure you want to logout?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        print("User logged out");
                      },
                      child: const Text("Logout"),
                    ),
                  ],
                );
              },
            );
          },
          );
        },
      ),
    );
  }
}