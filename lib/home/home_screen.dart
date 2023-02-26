import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/transitions.dart';
import 'confirm_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? image;
  var formProfileKey = GlobalKey<FormState>();

  Future<File> saveImage(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }

  Future pickImage(ImageSource source, context) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      //final imageTemporary = File(image.path);
      final imageTemporary = await saveImage(image.path);
      setState(
            () async {
          this.image = imageTemporary;
          File myFile = File(image.path);
          Navigator.push(
            context,
            CustomPageRoute(
                child: ConfirmImageScreen(
                  image: myFile,
                ),
                direction: AxisDirection.right),
          );
          debugPrint('lol lol =>: $myFile');
        },
      );
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                  'assets/lottie/image.json'),
              const Text(
                'upload an image to see is there a cancer or not.',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: size.height*.02),
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        content: Lottie.asset(
                            'assets/lottie/image.json'),
                        actions: [
                          Center(
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .center,
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    pickImage(
                                      ImageSource
                                          .camera,
                                      context,
                                    );
                                    Navigator.pop(
                                        context);
                                  },
                                  child:
                                  const Text(
                                    'Camera',
                                    style: TextStyle(
                                        fontSize:
                                        20),
                                  ),
                                ),
                                const SizedBox(
                                    width: 120),
                                TextButton(
                                  onPressed: () {
                                    pickImage(
                                      ImageSource
                                          .gallery,
                                      context,
                                    );
                                    Navigator.pop(
                                        context);
                                  },
                                  child:
                                  const Text(
                                    'Gallery',
                                    style: TextStyle(
                                        fontSize:
                                        20),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(primaryColor),
                    shape: MaterialStateProperty.all<
                        RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Text(
                      'upload',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

}
