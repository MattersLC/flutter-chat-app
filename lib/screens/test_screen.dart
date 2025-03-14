import 'package:chat_app/services/storage/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  void initState() {
    super.initState();

    fetchImages();
  }

  Future<void> fetchImages() async {
    await Provider.of<StorageService>(context, listen: false).fetchImages();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StorageService>(
      builder: (context, storageService, child) {
        // list of image urls
        final List<String> imageUrls = storageService.imageUrls;

        // test screen UI
        return Scaffold(
          body: ListView.builder(
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              // get each individual image
              final String imageUrl = imageUrls[index];

              // image post UI
              return Image.network(imageUrl);
            }
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => storageService.uploadImage(),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}