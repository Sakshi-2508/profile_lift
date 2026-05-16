import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'profile_lift_model.dart';
import 'profile_lift_theme.dart';

class ProfileLiftScreen extends StatefulWidget {
  final ProfileLiftModel profile;

  final VoidCallback? onEditProfile;
  final VoidCallback? onSettings;
  final VoidCallback? onLogout;

  final bool editable;
  final Function(ProfileLiftModel updatedProfile)? onSaveProfile;

  final ProfileLiftTheme theme;

  const ProfileLiftScreen({
    super.key,
    required this.profile,
    this.onEditProfile,
    this.onSettings,
    this.onLogout,
    this.editable = false,
    this.onSaveProfile,
    this.theme = const ProfileLiftTheme(),
  });

  @override
  State<ProfileLiftScreen> createState() => _ProfileLiftScreenState();
}

class _ProfileLiftScreenState extends State<ProfileLiftScreen>
    with SingleTickerProviderStateMixin {
  late ProfileLiftModel currentProfile;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    currentProfile = widget.profile;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _pickProfileImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) return;

    final updatedProfile = currentProfile.copyWith(
      localImagePath: image.path,
    );

    setState(() {
      currentProfile = updatedProfile;
    });

    widget.onSaveProfile?.call(updatedProfile);
  }

  void _openEditProfileDialog() {
    final nameController = TextEditingController(text: currentProfile.name);
    final emailController = TextEditingController(text: currentProfile.email);
    final phoneController = TextEditingController(text: currentProfile.phone);
    final addressController =
        TextEditingController(text: currentProfile.address);
    final bioController = TextEditingController(text: currentProfile.bio);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: widget.theme.cardColor,
          title: Text(
            "Edit Profile",
            style: TextStyle(color: widget.theme.textColor),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField("Name", nameController),
                _buildTextField("Email", emailController),
                _buildTextField("Phone", phoneController),
                _buildTextField("Address", addressController),
                _buildTextField("Bio", bioController, maxLines: 3),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancel",
                style: TextStyle(color: widget.theme.primaryColor),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final updatedProfile = currentProfile.copyWith(
                  name: nameController.text,
                  email: emailController.text,
                  phone: phoneController.text,
                  address: addressController.text,
                  bio: bioController.text,
                );

                setState(() {
                  currentProfile = updatedProfile;
                });

                widget.onSaveProfile?.call(updatedProfile);

                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: TextStyle(color: widget.theme.textColor),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: widget.theme.subtitleColor),
          filled: true,
          fillColor: widget.theme.backgroundColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Profile",
          style: TextStyle(color: widget.theme.textColor),
        ),
        centerTitle: true,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                GestureDetector(
                  onTap: widget.editable ? _pickProfileImage : null,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundImage:
                            currentProfile.localImagePath != null
                                ? FileImage(
                                    File(currentProfile.localImagePath!),
                                  )
                                : NetworkImage(
                                    currentProfile.imageUrl,
                                  ) as ImageProvider,
                      ),
                      if (widget.editable)
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: widget.theme.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: widget.theme.textColor,
                            size: 18,
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  currentProfile.name,
                  style: TextStyle(
                    color: widget.theme.textColor,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  currentProfile.email,
                  style: TextStyle(
                    color: widget.theme.subtitleColor,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 30),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: widget.theme.cardColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      _buildTile(Icons.phone, "Phone", currentProfile.phone),
                      const Divider(color: Colors.white12),
                      _buildTile(
                        Icons.location_on,
                        "Address",
                        currentProfile.address,
                      ),
                      const Divider(color: Colors.white12),
                      _buildTile(Icons.info, "Bio", currentProfile.bio),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                if (widget.editable)
                  _buildButton(
                    icon: Icons.edit,
                    title: "Edit Profile",
                    onTap: _openEditProfileDialog,
                  ),

                if (widget.editable) const SizedBox(height: 15),

                _buildButton(
                  icon: Icons.settings,
                  title: "Settings",
                  onTap: widget.onSettings,
                ),

                const SizedBox(height: 15),

                _buildButton(
                  icon: Icons.logout,
                  title: "Logout",
                  isLogout: true,
                  onTap: widget.onLogout,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required String title,
    bool isLogout = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: isLogout ? widget.theme.logoutColor : widget.theme.cardColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: widget.theme.textColor),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                color: widget.theme.textColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: widget.theme.textColor),
      title: Text(
        title,
        style: TextStyle(
          color: widget.theme.textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: widget.theme.subtitleColor),
      ),
    );
  }
}