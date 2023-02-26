import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:task1/constants/colors.dart';

class ConfirmImageScreen extends StatelessWidget {
  final dynamic image;

  const ConfirmImageScreen({Key? key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                  ),
                ),
                SizedBox(
                  height: 450,
                  width: double.infinity,
                  child: image == null
                      ? Lottie.asset('assets/lotties/image.json')
                      : Image(
                    fit: BoxFit.fill,
                    image: FileImage(image),
                  ),
                ),
                const SizedBox(height: 50),
                const Text(
                  'The Result is:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Bengin',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
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
                        'retry',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
