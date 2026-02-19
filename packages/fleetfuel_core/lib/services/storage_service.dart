import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Upload a single image from [localPath] to [storagePath].
  /// Returns the public download URL.
  Future<String> uploadImage(String localPath, String storagePath) async {
    final file = File(localPath);
    final ref = _storage.ref(storagePath);
    final task = await ref.putFile(
      file,
      SettableMetadata(contentType: 'image/jpeg'),
    );
    return task.ref.getDownloadURL();
  }

  /// Upload multiple images. [storageBasePath] is the folder path.
  /// [filePrefix] is the base name; files are named prefix_0.jpg, prefix_1.jpg etc.
  Future<List<String>> uploadMultipleImages(
    List<String> localPaths,
    String storageBasePath,
    String filePrefix,
  ) async {
    final urls = <String>[];
    for (var i = 0; i < localPaths.length; i++) {
      final storagePath = '$storageBasePath/${filePrefix}_$i.jpg';
      final url = await uploadImage(localPaths[i], storagePath);
      urls.add(url);
    }
    return urls;
  }

  /// Delete an image by its download URL.
  Future<void> deleteImage(String downloadUrl) async {
    try {
      final ref = _storage.refFromURL(downloadUrl);
      await ref.delete();
    } catch (_) {
      // Ignore if file doesn't exist
    }
  }

  /// Build the storage path for a log image.
  /// type: 'odometer' | 'fuel_meter' | 'vehicle' | 'receipt'
  static String logImagePath(
    String companyId,
    String logLocalId,
    String type, {
    int index = 0,
  }) {
    if (type == 'receipt') {
      return 'companies/$companyId/logs/$logLocalId/receipt_$index.jpg';
    }
    return 'companies/$companyId/logs/$logLocalId/$type.jpg';
  }

  /// Build storage path for a user image.
  /// type: 'profile' | 'license'
  static String userImagePath(String companyId, String userId, String type) {
    return 'companies/$companyId/users/$userId/$type.jpg';
  }
}
