import 'package:flutter/material.dart';

class ProfileLiftSettings extends StatelessWidget {
  final bool darkMode;
  final bool notifications;

  final ValueChanged<bool>? onDarkModeChanged;
  final ValueChanged<bool>? onNotificationsChanged;

  final VoidCallback? onPrivacyTap;
  final VoidCallback? onHelpTap;
  final VoidCallback? onAboutTap;

  const ProfileLiftSettings({
    super.key,
    this.darkMode = true,
    this.notifications = true,
    this.onDarkModeChanged,
    this.onNotificationsChanged,
    this.onPrivacyTap,
    this.onHelpTap,
    this.onAboutTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0f0f0f),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSwitchTile(
            icon: Icons.dark_mode,
            title: "Dark Mode",
            value: darkMode,
            onChanged: onDarkModeChanged,
          ),

          const SizedBox(height: 12),

          _buildSwitchTile(
            icon: Icons.notifications,
            title: "Notifications",
            value: notifications,
            onChanged: onNotificationsChanged,
          ),

          const SizedBox(height: 25),

          _buildOptionTile(
            icon: Icons.lock,
            title: "Privacy",
            onTap: onPrivacyTap,
          ),

          const SizedBox(height: 12),

          _buildOptionTile(
            icon: Icons.help,
            title: "Help & Support",
            onTap: onHelpTap,
          ),

          const SizedBox(height: 12),

          _buildOptionTile(
            icon: Icons.info,
            title: "About App",
            onTap: onAboutTap,
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    ValueChanged<bool>? onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff1b1b1b),
        borderRadius: BorderRadius.circular(16),
      ),
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.blue,
        secondary: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff1b1b1b),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white54,
          size: 16,
        ),
      ),
    );
  }
}