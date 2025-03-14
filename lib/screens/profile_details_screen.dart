import 'dart:io';

import 'package:chat_app/helpers/change_photo_dialog.dart';
import 'package:chat_app/helpers/show_alert.dart';
import 'package:chat_app/models/profile_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:chat_app/helpers/change_detail_dialog.dart';
import 'package:chat_app/models/loggedin_user.dart';
import 'package:chat_app/helpers/response_animation_dialog.dart';
import 'package:chat_app/services/profile_service.dart';
import 'package:chat_app/widgets/settings/profile/user_details_container.dart';
import 'package:chat_app/services/auth_service.dart';



class ProfileDetailsScreen extends StatelessWidget {
  ProfileDetailsScreen({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController aboutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    LoggedinUser user = authService.user!;
    final theme = Theme.of(context);

    
    void loadingWidget() {
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator(color: Theme.of(context).highlightColor));
        }
      );
    }

    void responseWidget(Color mainColor, Color backgroundColor, IconData icon) {
      Navigator.of(context).pop();
      showDialog(
        context: context,
        useSafeArea: false, // Use all screen size
        barrierDismissible: false, // Prevent dismissing by tapping outside
        builder: (BuildContext context) {
          return ResponseAnimationDialog(
            mainColor: mainColor,
            backgroundColor: backgroundColor,
            icon: icon,
          );
        },
      );
      // Automatically dismiss after 2 seconds
      Future.delayed(Duration(seconds: 2), () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      });
    }

    void showConfirmDialog(File photo) {
      Navigator.of(context).pop();
      changePhotoDialog(context, "Do you want to change your photo?", photo, () async {
        loadingWidget();
        // Crear conexión a la api para cambiar la foto en el servidor
        ProfileResponse success = await authService.changePhoto(photo);

        responseWidget(
          success.ok ? Colors.green.shade700 : Colors.red.shade700,
          success.ok ? Colors.green.shade100 : Colors.red.shade100,
          success.ok ? Icons.check_circle : Icons.cancel,
        );
      });

    }

    Future pickImageFromGallery() async {
      final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (returnedImage == null) return;

      showConfirmDialog(File(returnedImage.path));
    }

    Future pickImageFromCamera() async {
      final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);

      if (returnedImage == null) return;

      showConfirmDialog(File(returnedImage.path));
    }

    void showImageSourceSheet() {
      if (Platform.isAndroid) {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Wrap(
              children: [
                Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.camera_alt, color: Colors.blue),
                      title: Text("Take Photo"),
                      onTap: () => pickImageFromCamera(),
                    ),
                    ListTile(
                      leading: Icon(Icons.photo_library, color: Colors.green),
                      title: Text("Choose from Gallery"),
                      onTap: () => pickImageFromGallery(),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ],
            );
          },
        );
      }

      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () => pickImageFromCamera(), 
              child: Text("Take Photo", style: TextStyle(color: Theme.of(context).highlightColor),),
            ),
            CupertinoActionSheetAction(
              onPressed: () => pickImageFromGallery(), 
              child: Text("Choose from Gallery", style: TextStyle(color: Theme.of(context).highlightColor),),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cancel", style: TextStyle(color: Theme.of(context).highlightColor),),
          )
        )
      );
    }
    
    void changeName(AuthService authService) async {
      loadingWidget();

      bool success = await authService.changeName(nameController.text);

      responseWidget(
        success ? Colors.green.shade700 : Colors.red.shade700,
        success ? Colors.green.shade100 : Colors.red.shade100,
        success ? Icons.check_circle : Icons.cancel,
      );
    }

    void changeLastName(AuthService authService) async {
      loadingWidget();

      bool success = await authService.changeLastName(lastNameController.text);

      responseWidget(
        success ? Colors.green.shade700 : Colors.red.shade700,
        success ? Colors.green.shade100 : Colors.red.shade100,
        success ? Icons.check_circle : Icons.cancel,
      );
    }

    void changeUserName(AuthService authService) async {
      loadingWidget();

      bool success = await authService.changeUserName(userNameController.text);

      responseWidget(
        success ? Colors.green.shade700 : Colors.red.shade700,
        success ? Colors.green.shade100 : Colors.red.shade100,
        success ? Icons.check_circle : Icons.cancel,
      );
    }

    void changeAbout(AuthService authService) async {
      loadingWidget();

      bool success = await authService.changeAbout(aboutController.text);

      responseWidget(
        success ? Colors.green.shade700 : Colors.red.shade700,
        success ? Colors.green.shade100 : Colors.red.shade100,
        success ? Icons.check_circle : Icons.cancel,
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.secondaryHeaderColor,
        elevation: 1,
        centerTitle: false,
        title: Text('Profile', style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: theme.secondaryHeaderColor,
            child: user.profilePicture != '' ?
            InkWell(
              customBorder: CircleBorder(),
              onTap: () => showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: Colors.transparent,
                  content: Stack(
                    children: [
                      CachedNetworkImage(
                        width: MediaQuery.of(context).size.width,
                        progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        imageUrl: user.profilePicture,
                      ),
                      Positioned(
                        top: -5,
                        right: -5,
                        child: IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          color: Colors.black,
                          icon: Icon(Icons.cancel)
                        )
                      ),
                    ],
                  ),
                ),
              ),
              child: Stack(
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      fit: BoxFit.cover, // Ensures the image covers the entire area 
                      width: 120, // Match the CircleAvatar radius * 2 
                      height: 120, // Match the CircleAvatar radius * 2
                      progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      imageUrl: user.profilePicture
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Material(
                      shape: CircleBorder(),
                      child: InkWell(
                        customBorder: CircleBorder(),
                        onTap: () {
                          print('delete button');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Icon(Icons.cancel, color: theme.indicatorColor,),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ) :
            Text(
              user.name.substring(0, 2),
              style: TextStyle(color: theme.highlightColor, fontSize: 30),
            )
          ),
          Center(
            child: TextButton(
              onPressed: showImageSourceSheet,
              style: ButtonStyle(
                padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 20))
              ),
              child: Text('Select New Photo', style: TextStyle(color: theme.highlightColor),)
            ),
          ),
          UserDetailsContainer(
            header: 'Name',
            content: authService.user!.name,
            onTap: () => changeDetailDialog(
              context,
              'Change name?',
              nameController = TextEditingController(text: authService.user!.name),
              () => changeName(authService),
            ),
          ),
          UserDetailsContainer(
            header: 'Last name',
            content: authService.user!.lastName,
            onTap: () => changeDetailDialog(
              context,
              'Change last name?',
              lastNameController = TextEditingController(text: authService.user!.lastName),
              () => changeLastName(authService),
            ),
          ),
          UserDetailsContainer(
            header: 'Username',
            content: '@${authService.user!.userName}',
            onTap: () => changeDetailDialog(
              context,
              'Change username?',
              userNameController = TextEditingController(text: authService.user!.userName),
              () => changeUserName(authService),
            ),
          ),
          UserDetailsContainer(
            header: 'About',
            content: authService.user!.about,
            onTap: () => changeDetailDialog(
              context,
              'Change about?',
              aboutController = TextEditingController(text: authService.user!.about),
              () => changeAbout(authService),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: (){},
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(theme.indicatorColor)
            ),
            child: Text(
              'Delete Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            )
          )
        ],
      ),
    );
  }

  
}