// screens/photo_recovery.dart
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:photo_manager/photo_manager.dart';

class PhotoRecoveryScreen extends StatefulWidget {
  const PhotoRecoveryScreen({super.key});

  @override
  State<PhotoRecoveryScreen> createState() => _PhotoRecoveryScreenState();
}

class _PhotoRecoveryScreenState extends State<PhotoRecoveryScreen> {
  List<AssetEntity> _deletedPhotos = [];
  bool _isLoading = true;
  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    final PermissionState state = await PhotoManager.requestPermissionExtend();
    if (state.hasAccess) {
      setState(() {
        _hasPermission = true;
      });
      _loadDeletedPhotos();
    } else {
      setState(() {
        _hasPermission = false;
        _isLoading = false;
      });
    }
  }

  Future<void> _loadDeletedPhotos() async {
    try {
      final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        filterOption: FilterOptionGroup(
          orders: [const OrderOption(asc: false)],
        ),
      );

      if (albums.isNotEmpty) {
        final AssetPathEntity recentAlbum = albums.first;
        final List<AssetEntity> assets = await recentAlbum.getAssetListRange(
          start: 0,
          end: 100,
        );

        // Filter for potentially deleted/recently modified photos
        final recentAssets = assets.where((asset) {
          final modified = asset.modifiedDateTime;
          final created = asset.createDateTime;
          return modified != null && 
                 created != null && 
                 modified.difference(created).inSeconds > 0;
        }).toList();

        setState(() {
          _deletedPhotos = recentAssets;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Photo Recovery'),
      ),
      child: SafeArea(
        child: _isLoading
            ? const Center(child: CupertinoActivityIndicator())
            : _hasPermission
                ? _buildPhotoGrid()
                : _buildPermissionRequest(),
      ),
    );
  }

  Widget _buildPhotoGrid() {
    if (_deletedPhotos.isEmpty) {
      return const Center(
        child: Text('No recoverable photos found'),
      );
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: _deletedPhotos.length,
      itemBuilder: (context, index) {
        return FutureBuilder<Uint8List?>(
          future: _deletedPhotos[index].thumbnailData,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return Image.memory(
                snapshot.data!,
                fit: BoxFit.cover,
              );
            }
            return Container(color: CupertinoColors.systemGrey5);
          },
        );
      },
    );
  }

  Widget _buildPermissionRequest() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(CupertinoIcons.photo, size: 64),
          const SizedBox(height: 16),
          const Text('Photo Access Required'),
          const SizedBox(height: 8),
          CupertinoButton(
            onPressed: _checkPermissions,
            child: const Text('Grant Permission'),
          ),
        ],
      ),
    );
  }
}