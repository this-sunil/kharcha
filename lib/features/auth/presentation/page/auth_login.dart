import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kharcha/core/Storage/secure_storage.dart';
import 'package:kharcha/core/router/app_routes.dart';
import 'package:kharcha/features/auth/presentation/riverpod/auth_provider.dart';

import '../../../../core/util/CustomText.dart';

class AuthLogin extends ConsumerStatefulWidget {
  const AuthLogin({super.key});

  @override
  ConsumerState<AuthLogin> createState() => _AuthLoginState();
}

class _AuthLoginState extends ConsumerState<AuthLogin>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

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
      duration: const Duration(milliseconds: 900),
    );

    scaleAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.elasticOut,
    );

    animationController.forward();
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    animationController.dispose();
    super.dispose();
  }

  Future<void> login() async {
   if(_formKey.currentState!.validate()) {
     ref.read(authNotifierProvider.notifier).login(phoneController.text, passwordController.text);
   }

  }

  InputDecoration inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffix
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF7E8795)),
      prefixIcon: Icon(icon, color: const Color(0xFF19D66B)),
      suffixIcon: suffix,
      filled: true,
      fillColor: const Color(0xFF151A21),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFF242B35)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFF19D66B), width: 1.3),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
    );
  }

  Widget phoneField() {
    return TextFormField(
      controller: phoneController,
      keyboardType: TextInputType.phone,
      maxLength: 10,

      style: const TextStyle(color: Colors.white),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Phone number is required";
        }

        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
          return "Only numbers are allowed";
        }

        if (value.length != 10) {
          return "Enter 10 digit phone number";
        }

        if (!RegExp(r'^[6-9][0-9]{9}$').hasMatch(value)) {
          return "Enter a valid phone number";
        }

        return null;
      },
      decoration:
          inputDecoration(
            hint: "Enter phone number",
            icon: Icons.phone_outlined,
          ).copyWith(
            counterText: "",
            prefixText: "+91  ",
            prefixStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
    );
  }

  Widget passwordField() {
    return TextFormField(
      controller: passwordController,
      obscureText: obscurePassword,
      style: const TextStyle(color: Colors.white),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Password is required";
        }

        if (value.length < 8) {
          return "Password must be at least 8 characters";
        }

        return null;
      },
      decoration: inputDecoration(
        hint: "Enter password",
        icon: Icons.lock_outline_rounded,
        suffix: IconButton(
          onPressed: () {
            setState(() {
              obscurePassword = !obscurePassword;
            });
          },
          icon: Icon(
            obscurePassword
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: const Color(0xFF7E8795),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authNotifierProvider, (prev,next){
      next.when(data: (item){
        setState(() {
          isLoading = false;
        });
        SecureStorage.instance.setToken(item.token??"");
        SecureStorage.instance.setUID(item.result?.id.toString()??"");
        context.pushReplacement(AppRoutes.dashboard);
      }, error: (error,_){
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: CustomText(text:error.toString()),
          ),
        );
      }, loading: (){
        setState(() {
          isLoading=true;
        });
      });
    });
    return Scaffold(
      backgroundColor: const Color(0xFF090C10),
      body: Stack(
        children: [
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
            bottom: -150,
            left: -120,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF19D66B).withValues(alpha: 0.06),
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(22),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
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

                        const CustomText(
                          text:"kharcha",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const CustomText(
                          text:"Your money. Your control.",
                          style: TextStyle(
                            color: Color(0xFF8B95A3),
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Login Card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10151B),
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(color: const Color(0xFF202832)),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomText(
                                  text:"Welcome back",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),

                                const SizedBox(height: 7),

                                const CustomText(
                                  text: "Login to continue managing your money.",
                                  style: TextStyle(
                                    color: Color(0xFF7E8795),
                                    fontSize: 14,
                                  ),
                                ),

                                const SizedBox(height: 28),

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

                                phoneField(),

                                const SizedBox(height: 18),

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

                                passwordField(),

                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {},
                                    child: const CustomText(
                                      text:"Forgot Password?",
                                      style: TextStyle(
                                        color: Color(0xFF19D66B),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 8),

                                // Login Button
                                SizedBox(
                                  width: double.infinity,
                                  height: 56,
                                  child: ElevatedButton(
                                    onPressed: isLoading ? null : login,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF19D66B),
                                      foregroundColor: Colors.black,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: isLoading
                                        ? const SizedBox(
                                            height: 23,
                                            width: 23,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.5,
                                              color: Colors.black,
                                            ),
                                          )
                                        : const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CustomText(
                                                text:"Login",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Icon(Icons.arrow_forward_rounded),
                                            ],
                                          ),
                                  ),
                                ),

                                const SizedBox(height: 22),

                                // Register
                                Center(
                                  child: RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        color: Color(0xFF7E8795),
                                        fontSize: 13,
                                      ),
                                      children: [
                                        const TextSpan(
                                          text: "Don't have an account? ",
                                        ),
                                        WidgetSpan(
                                          child: GestureDetector(
                                            onTap: () {
                                              // Navigate to Register
                                              context.pushReplacement(AppRoutes.register);
                                            },
                                            child: const CustomText(
                                             text: "Create Account",
                                              style: TextStyle(
                                                color: Color(0xFF19D66B),
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
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

                        const SizedBox(height: 25),

                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
