// screens/file_recovery.dart
import 'package:flutter/cupertino.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class FileRecoveryScreen extends StatefulWidget {
  const FileRecoveryScreen({super.key});

  @override
  State<FileRecoveryScreen> createState() => _FileRecoveryScreenState();
}

class _FileRecoveryScreenState extends State<FileRecoveryScreen> {
  List<File> _recoveredFiles = [];
  bool _isScanning = false;

  Future<void> _scanForDeletedFiles() async {
    setState(() {
      _isScanning = true;
    });

    try {
      // This is a simplified version - actual file recovery would require
      // low-level file system access which is limited on iOS
      final Directory tempDir = await getTemporaryDirectory();
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      
      // Scan directories for potentially recoverable files
      final List<FileSystemEntity> entities = [
        ...await tempDir.list().toList(),
        ...await appDocDir.list().toList(),
      ];

      final List<File> files = entities
          .where((entity) => entity is File)
          .map((entity) => entity as File)
          .toList();

      setState(() {
        _recoveredFiles = files;
        _isScanning = false;
      });
    } catch (e) {
      setState(() {
        _isScanning = false;
      });
    }
  }

  Future<void> _recoverFile(File file) async {
    try {
      final String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
      if (selectedDirectory != null) {
        final String fileName = file.path.split('/').last;
        final File newFile = File('$selectedDirectory/$fileName');
        await file.copy(newFile.path);
        
        showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text('Success'),
            content: Text('File recovered to $selectedDirectory'),
            actions: [
              CupertinoDialogAction(
                child: const Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Error'),
          content: Text('Failed to recover file: $e'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('File Recovery'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: CupertinoButton.filled(
                onPressed: _isScanning ? null : _scanForDeletedFiles,
                child: _isScanning
                    ? const CupertinoActivityIndicator()
                    : const Text('Scan for Deleted Files'),
              ),
            ),
            Expanded(
              child: _recoveredFiles.isEmpty
                  ? const Center(
                      child: Text('No files found. Tap scan to search.'),
                    )
                  : ListView.builder(
                      itemCount: _recoveredFiles.length,
                      itemBuilder: (context, index) {
                        final file = _recoveredFiles[index];
                        return CupertinoListTile(
                          leading: const Icon(CupertinoIcons.doc),
                          title: Text(file.path.split('/').last),
                          subtitle: Text('${file.lengthSync()} bytes'),
                          trailing: CupertinoButton(
                            child: const Text('Recover'),
                            onPressed: () => _recoverFile(file),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}