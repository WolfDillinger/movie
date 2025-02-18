import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../helper/snack_bar.dart';
import '../style/colors.dart';
import '../style/custom_text.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUser();
    });
  }

  _loadUser() {
    context.go("/home");
    showSnack(context, "Welcome Back ;)");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [Color(0xffF4EEF2), Color(0xffF4EEF2), Color(0xffE3EDF5)],
            ),
          ),
          height: size.height,
          width: size.width,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 200,
                      height: 200,
                    ),
                  ),
                ),
                CustomText(
                  text: "loading ...",
                  size: 20,
                  weight: FontWeight.bold,
                  color: c_1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
