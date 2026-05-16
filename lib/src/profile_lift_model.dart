class ProfileLiftModel {
  final String name;
  final String email;
  final String phone;
  final String bio;
  final String imageUrl;
  final String address;
  final String? localImagePath;

  const ProfileLiftModel({
  required this.name,
  required this.email,
  required this.phone,
  required this.bio,
  required this.imageUrl,
  required this.address,
  this.localImagePath,
});

  ProfileLiftModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? bio,
    String? imageUrl,
    String? address,
    String? localImagePath,
  }) {
    return ProfileLiftModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
      imageUrl: imageUrl ?? this.imageUrl,  
      address: address ?? this.address,
      localImagePath: localImagePath ?? this.localImagePath,
    );
  }
}