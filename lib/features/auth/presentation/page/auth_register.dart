import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kharcha/core/router/app_routes.dart';
import 'package:kharcha/features/auth/presentation/riverpod/auth_provider.dart';

import '../../../../core/Storage/secure_storage.dart';
import '../../../../core/util/CustomText.dart';

class AuthRegister extends ConsumerStatefulWidget {
  const AuthRegister({super.key});

  @override
  ConsumerState<AuthRegister> createState() => _AuthRegisterState();
}

class _AuthRegisterState extends ConsumerState<AuthRegister>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;
  bool isLoading = false;

  late AnimationController animationController;
  late Animation<double> scaleAnimation;


  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    scaleAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.elasticOut,
    );

    animationController.forward();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    animationController.dispose();
    super.dispose();
  }

  void register()  {
    if(_formKey.currentState!.validate()){
      print("Register");
      ref.read(authNotifierProvider.notifier).register(nameController.text,phoneController.text,passwordController.text);
    }
  }

  InputDecoration inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Color(0xFF7E8795),
        fontSize: 14,
      ),
      counterText: "",
      prefixIcon: Icon(
        icon,
        color: const Color(0xFF19D66B),
        size: 21,
      ),
      suffixIcon: suffix,
      filled: true,
      fillColor: const Color(0xFF151A21),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Color(0xFF242B35),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Color(0xFF19D66B),
          width: 1.3,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Colors.redAccent,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Colors.redAccent,
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    int? maxLength,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffix,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLength: maxLength,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
      validator: validator,

      decoration: inputDecoration(

        hint: hint,
        icon: icon,
        suffix: suffix,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    ref.listen<AsyncValue>(authNotifierProvider, (previous, next) {
      next.when(
        loading: () {
          setState(() {
            isLoading = true;
          });
        },
        data: (item) {
          setState(() {
            isLoading = false;
          });
          SecureStorage.instance.setToken(item.token??"");
          SecureStorage.instance.setUID(item.result?.id.toString()??"");
          context.pushReplacement(AppRoutes.dashboard);
        },
        error: (error, stackTrace) {
          setState(() {
            isLoading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: CustomText(text:error.toString()),
            ),
          );
        },
      );
    });

    return Scaffold(
      backgroundColor: const Color(0xFF090C10),
      body: Stack(
        children: [
          // Background glow
          Positioned(
            top: -120,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF19D66B).withValues(alpha: 0.10),
              ),
            ),
          ),

          Positioned(
            bottom: -160,
            left: -120,
            child: Container(
              width: 330,
              height: 330,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF19D66B).withValues(alpha: 0.06),
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 25,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 480,
                  ),
                  child: ScaleTransition(
                    scale: scaleAnimation,
                    child: Column(
                      children: [
                        // Logo
                        Container(
                            width: 76,
                            height: 76,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: .cover,
                                    image: AssetImage("assets/icons/logo.jpg"))
                            )
                        ),

                        const SizedBox(height: 18),

                        // Brand
                        const CustomText(
                          text:"kharcha",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -1.2,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const CustomText(
                          text:"Build better money habits.",
                          style: TextStyle(
                            color: Color(0xFF8B95A3),
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Form Card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10151B),
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(
                              color: const Color(0xFF202832),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.25),
                                blurRadius: 35,
                                offset: const Offset(0, 18),
                              ),
                            ],
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                const CustomText(
                                  text:"Create your account",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),

                                const SizedBox(height: 7),

                                const CustomText(
                                  text:"Start tracking your money smarter.",
                                  style: TextStyle(
                                    color: Color(0xFF7E8795),
                                    fontSize: 14,
                                  ),
                                ),

                                const SizedBox(height: 28),

                                // Name
                                const CustomText(
                                  text:"FULL NAME",
                                  style: TextStyle(
                                    color: Color(0xFF8B95A3),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                buildTextField(
                                  controller: nameController,
                                  hint: "Enter your full name",
                                  icon: Icons.person_outline_rounded,
                                  validator: (value) {
                                    if (value == null ||
                                        value.trim().isEmpty) {
                                      return "Please enter your name";
                                    }

                                    if (value.trim().length < 3) {
                                      return "Name must be at least 3 characters";
                                    }

                                    return null;
                                  },
                                ),

                                const SizedBox(height: 18),

                                // Phone
                                const CustomText(
                                  text:"PHONE NUMBER",
                                  style: TextStyle(
                                    color: Color(0xFF8B95A3),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                buildTextField(
                                  controller: phoneController,
                                  hint: "Enter phone number",

                                  icon: Icons.phone_outlined,
                                  maxLength: 10,
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty) {
                                      return "Please enter phone number";
                                    }

                                    if (!RegExp(r'^[0-9]{10}$')
                                        .hasMatch(value)) {
                                      return "Enter a valid 10-digit number";
                                    }

                                    return null;
                                  },
                                ),

                                const SizedBox(height: 18),





                                // Password
                                const CustomText(
                                  text:"PASSWORD",
                                  style: TextStyle(
                                    color: Color(0xFF8B95A3),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                buildTextField(
                                  controller: passwordController,
                                  hint: "Create a strong password",
                                  icon: Icons.lock_outline_rounded,
                                  obscureText: obscurePassword,
                                  suffix: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscurePassword =
                                        !obscurePassword;
                                      });
                                    },
                                    icon: Icon(
                                      obscurePassword
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: const Color(0xFF7E8795),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty) {
                                      return "Please enter password";
                                    }

                                    if (value.length < 8) {
                                      return "Password must be at least 8 characters";
                                    }

                                    return null;
                                  },
                                ),

                                const SizedBox(height: 25),

                                // Create Account Button
                                SizedBox(
                                  width: double.infinity,
                                  height: 56,
                                  child: ElevatedButton(
                                    onPressed:
                                    isLoading ? null : register,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      const Color(0xFF19D66B),
                                      foregroundColor: Colors.black,
                                      disabledBackgroundColor:
                                      const Color(0xFF19D66B)
                                          .withValues(alpha: 0.5),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: isLoading
                                        ? const SizedBox(
                                      width: 23,
                                      height: 23,
                                      child:
                                      CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        color: Colors.black,
                                      ),
                                    )
                                        : const Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        CustomText(
                                          text:"Create Account",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight:
                                            FontWeight.w800,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Icon(
                                          Icons.arrow_forward_rounded,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 22),

                                // Terms
                                Center(
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: const TextSpan(
                                      style: TextStyle(
                                        color: Color(0xFF727C89),
                                        fontSize: 11,
                                        height: 1.5,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                          "By creating an account, you agree to our\n",
                                        ),
                                        TextSpan(
                                          text: "Terms of Service",
                                          style: TextStyle(
                                            color: Color(0xFF19D66B),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(text: " and "),
                                        TextSpan(
                                          text: "Privacy Policy",
                                          style: TextStyle(
                                            color: Color(0xFF19D66B),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Login
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CustomText(
                              text:"Already have an account?",
                              style: TextStyle(
                                color: Color(0xFF7E8795),
                                fontSize: 13,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.pushReplacement(AppRoutes.login);
                              },
                              child: const CustomText(
                                text:"Sign In",
                                style: TextStyle(
                                  color: Color(0xFF19D66B),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        // Security
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.verified_user_outlined,
                              size: 15,
                              color: Color(0xFF687381),
                            ),
                            SizedBox(width: 6),
                            CustomText(
                              text:"Your data is encrypted & secure",
                              style: TextStyle(
                                color: Color(0xFF687381),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


