import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StorageService with ChangeNotifier{
  // firebase storage
  final firebaseStorage = FirebaseStorage.instance;
  
  //Images are stored in firebase as download URLs
  List<String> _imageUrls = [];

  // loading status
  bool _isLoading = false;

  // uploading status
  bool _isUploading = false;

  /*
  G E T T E R S
  */
  List<String> get imageUrls => _imageUrls;
  bool get isLoading => _isLoading;
  bool get isUploading => _isUploading;

  /*
  R E A D  I M A G E S
  */
  Future<void> fetchImages() async {
    // start loading
    _isLoading = true;

    // get the list under the directory: uploaded_images/
    final ListResult result = await firebaseStorage.ref('uploaded_images/').listAll();

    // get the download URLs for each image
    final urls = await Future.wait(result.items.map((ref) => ref.getDownloadURL()));

    // update URLs
    _imageUrls = urls;

    // loading finished
    _isLoading = false;

    // update UI
    notifyListeners();
  }

  /*
  D E L E T E  I M A G E S
  */
  Future<void> deleteImages(String imageUrl) async {
    try {
      // remove from local list
      _imageUrls.remove(imageUrl);

      // get path name and delete from firebase
      final String path = extractPathFromUrl(imageUrl);
      await firebaseStorage.ref(path).delete();
    } catch (e) {
      print("Error deleting image: $e");
    }

    // update UI
    notifyListeners();
  }

  String extractPathFromUrl(String url) {
    Uri uri = Uri.parse(url);

    // extracting the part of the url we need
    String encodedPath = uri.pathSegments.last;

    // url decoding the path
    return Uri.decodeComponent(encodedPath);
  }

  /*
  U P L O A D  I M A G E
  */
  Future<void> uploadImage() async {
    print('flag 1');
    // start upload
    _isUploading = true;
    // update UI
    notifyListeners();

    print('flag 2');

    // pick an image
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    print('flag 3');

    if (image == null) return; // user cancelled the picker

    File file = File(image.path);

    print('flag 4');

    try {
      // define the path in storage
      String filePath = 'uploaded_images/${DateTime.now()}.png';
      print('flag 5 - filePath: $filePath');

      // upload the file to firebase storage
      await firebaseStorage.ref(filePath).putFile(file);
      print('flag 6');

      // after uploading, fetch the download URL
      String downloadUrl = await firebaseStorage.ref(filePath).getDownloadURL();
      print('flag 7');

      // update the image urls list and UI
      _imageUrls.add(downloadUrl);
      notifyListeners();
      print('flag 8');
    } catch (e) {
      print("Error uploading the image: $e");
    } finally {
      _isUploading = false;
      notifyListeners();
    }
  }
}