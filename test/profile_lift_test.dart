import 'package:flutter_test/flutter_test.dart';
import 'package:profile_lift/profile_lift.dart';

void main() {
  test('ProfileLiftModel stores profile data', () {
    const model = ProfileLiftModel(
      name: 'Test User',
      username: '@testuser',
      bio: 'Bio text',
      imageUrl: 'https://example.com/avatar.png',
      followers: 100,
      following: 50,
      skills: ['Flutter', 'Dart'],
    );

    expect(model.name, 'Test User');
    expect(model.username, '@testuser');
    expect(model.bio, 'Bio text');
    expect(model.imageUrl, 'https://example.com/avatar.png');
    expect(model.followers, 100);
    expect(model.following, 50);
    expect(model.skills, ['Flutter', 'Dart']);
  });
}
