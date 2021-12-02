import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monochat/components/logout_dialog.dart';
import 'package:monochat/components/user_image.dart';
import 'package:monochat/models/current_user_dao.dart';
import 'package:monochat/models/user_dao.dart';
import 'package:provider/provider.dart';
import 'package:monochat/screens/image_crop_screen.dart';
import 'package:image_picker/image_picker.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late final CurrentUserDao currentUserDao;

  @override
  void initState() {
    super.initState();
    currentUserDao = Provider.of<CurrentUserDao>(context, listen: false);
  }

  Future<Map<String, dynamic>> getUserData() async {
    return await Provider.of<UserDao>(context, listen: false)
        .getUserData(currentUserDao.userId()!);
  }

  @override
  Widget build(BuildContext context) {
    final Future<Map<String, dynamic>> userData = getUserData();
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () => showDialog(
                  context: context, builder: (con) => const LogoutDialog()),
              icon: const Icon(Icons.logout),
              tooltip: 'Logout',
            )
          ],
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          initialData: const <String, dynamic>{},
          future: userData,
          builder: (cont, snap) => ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (con) => SimpleDialog(
                            children: [
                              TextButton(
                                  onPressed: selectImage,
                                  child: const Text('Update profile picture')),
                              TextButton(
                                  onPressed: () {},
                                  child: const Text('Remove profile picture'))
                            ],
                          ));
                },
                child: UserImage(
                  currentUserDao.userId()!,
                  radius: 100,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                  textAlign: TextAlign.center,
                  controller: TextEditingController(
                      text: snap.data!['name'] ?? 'No Name'),
                  style: Theme.of(context).textTheme.headline4,
                  decoration: const InputDecoration(border: InputBorder.none),
                  onSubmitted: (text) =>
                      Provider.of<UserDao>(context, listen: false)
                          .updateName(currentUserDao.userId()!, text)),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: const Icon(Icons.email_outlined),
                title: Text(snap.data?['email'] ?? ''),
                subtitle: const Text('Email address'),
                trailing: const Tooltip(
                  message: 'Email Verified!',
                  child: Icon(
                    Icons.verified,
                    color: Colors.green,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.calendar_today_outlined),
                title: Text(snap.data!.isNotEmpty
                    ? DateFormat('d LLLL y')
                        .format(snap.data?['creationDate'].toDate())
                    : ''),
                subtitle: const Text('Account creation date'),
              ),
            ],
          ),
        ));
  }

  void selectImage() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxHeight: 500, maxWidth: 500);
    if (file != null) {
      Uint8List imageData = await file.readAsBytes();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (con) =>
              ImageCropScreen(currentUserDao.userId()!, imageData)));
    }
  }
}
