import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../res/routes/routesname.dart';

class AuthController extends GetxController {
  var user = Rx<User?>(null);
  var isLoading = false.obs;
  var errorMessage = "".obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final loginEmailController = TextEditingController().obs;
  final loginPasswordController = TextEditingController().obs;

  final signupNameController = TextEditingController().obs;
  final signupEmailController = TextEditingController().obs;
  final signupPasswordController = TextEditingController().obs;

  @override
  void onInit() {
    super.onInit();
    user.value = _auth.currentUser;
    _auth.authStateChanges().listen((User? user) {
      this.user.value = user;
      navigateBasedOnAuthStatus(user);
    });
  }

  @override
  void dispose() {
    super.dispose();
    loginEmailController.value.dispose();
    loginPasswordController.value.dispose();
    signupNameController.value.dispose();
    signupEmailController.value.dispose();
    signupPasswordController.value.dispose();
  }

  void navigateBasedOnAuthStatus(User? user) {
    if (user != null) {
      Get.offAllNamed(RouteName.home);
    } else {
      Get.offAllNamed(RouteName.loginView);
    }
  }

  /// Display message utility
  void _showMessage({
    required String title,
    required String message,
    Color backgroundColor = Colors.green,
    Color textColor = Colors.white,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: backgroundColor,
      colorText: textColor,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
    );
  }

  /// User Login with Firebase
  Future<void> login() async {
    String email = loginEmailController.value.text.trim();
    String password = loginPasswordController.value.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage(
        title: "Error",
        message: "Email and Password are required!",
        backgroundColor: Colors.red,
      );
      return;
    }

    try {
      isLoading(true);

      // Attempt to log in
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      // Show success message and navigate to home
      _showMessage(
        title: "Success",
        message: "Login successful!",
      );


      // Clear login form
      loginEmailController.value.clear();
      loginPasswordController.value.clear();
      errorMessage.value = "";
    } on FirebaseAuthException catch (e) {
      // Handle login errors
      errorMessage.value = e.message ?? "An error occurred";
      _showMessage(
        title: "Error",
        message: errorMessage.value,
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading(false);
    }
  }

  /// Signup and store data in Firebase
  Future<void> signUp() async {
    String name = signupNameController.value.text.trim();
    String email = signupEmailController.value.text.trim();
    String password = signupPasswordController.value.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _showMessage(
        title: "Error",
        message: "All fields are required!",
        backgroundColor: Colors.red,
      );
      return;
    }

    try {
      isLoading(true);

      // Create user in Firebase Auth
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Store the user details in Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'name': name,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Show success message and navigate to home
      _showMessage(
        title: "Success",
        message: "Account created successfully!",
      );
      Get.toNamed(RouteName.home);

      // Clear sign-up form
      signupNameController.value.clear();
      signupEmailController.value.clear();
      signupPasswordController.value.clear();
      errorMessage.value = "";
    } on FirebaseAuthException catch (e) {
      // Handle sign-up errors
      errorMessage.value = e.message ?? "An error occurred";
      _showMessage(
        title: "Error",
        message: errorMessage.value,
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading(false);
    }
  }

  /// Logout logic
  Future<void> logout() async {
    await _auth.signOut();
    Get.offAllNamed('/');
    
    _showMessage(
      title: "Success",
      message: "Logged out successfully!",
    );
  }
}
