// screens/home_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:way_point/screens/contact_recovery.dart';
import 'package:way_point/screens/file_recovery.dart';
import 'package:way_point/screens/photo_recovery.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Data Recovery'),
        trailing: Icon(CupertinoIcons.settings),
      ),
      child: SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(16),
          children: [
            _buildRecoveryOption(
              context,
              CupertinoIcons.photo,
              'Photos',
              'Recover deleted photos',
              () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const PhotoRecoveryScreen(),
                ),
              ),
            ),
            _buildRecoveryOption(
              context,
              CupertinoIcons.person_2,
              'Contacts',
              'Recover deleted contacts',
              () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const ContactRecoveryScreen(),
                ),
              ),
            ),
            _buildRecoveryOption(
              context,
              CupertinoIcons.folder,
              'Files',
              'Recover deleted files',
              () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const FileRecoveryScreen(),
                ),
              ),
            ),
            _buildRecoveryOption(
              context,
              CupertinoIcons.doc_text,
              'Documents',
              'Recover documents',
              () {},
            ),
            _buildRecoveryOption(
              context,
              CupertinoIcons.music_note,
              'Audio',
              'Recover audio files',
              () {},
            ),
            _buildRecoveryOption(
              context,
              CupertinoIcons.videocam,
              'Videos',
              'Recover videos',
              () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecoveryOption(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey6,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: CupertinoColors.systemBlue),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: CupertinoColors.systemGrey),
            ),
          ],
        ),
      ),
    );
  }
}
