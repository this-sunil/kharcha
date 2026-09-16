import 'package:flutter/material.dart';

import '../../../../core/util/CustomText.dart';

class AuthChangePass extends StatefulWidget {
  const AuthChangePass({super.key});

  @override
  State<AuthChangePass> createState() => _AuthChangePassState();
}

class _AuthChangePassState extends State<AuthChangePass> {
  final _formKey = GlobalKey<FormState>();

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _changePassword() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // TODO: Call your change-password API here.
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: Colors.white),
            SizedBox(width: 10),
            CustomText(text:'Password changed successfully'),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );

    Navigator.pop(context);
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    required bool obscure,
    required VoidCallback onToggle,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
      prefixIcon: Icon(icon, size: 21, color: Colors.grey.shade600),
      suffixIcon: IconButton(
        onPressed: onToggle,
        icon: Icon(
          obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          size: 21,
          color: Colors.grey.shade600,
        ),
      ),
      filled: true,
      fillColor: Colors.grey.shade50,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xFF176B5B), width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    required bool obscure,
    required VoidCallback onToggle,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text:label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xFF17201D),
          ),
        ),
        const SizedBox(height: 9),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          textInputAction: TextInputAction.next,
          validator: validator,
          onChanged: (_) {
            Future.delayed(Duration(seconds: 1),(){
              setState(() {});
            });
          },
          decoration: _inputDecoration(
            hint: hint,
            icon: icon,
            obscure: obscure,
            onToggle: onToggle,
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordRules() {
    final password = _newPasswordController.text;

    final hasLength = password.length >= 8;
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasNumber = password.contains(RegExp(r'[0-9]'));

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F8F6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE1ECE8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text:'Password requirements',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF17201D),
            ),
          ),
          const SizedBox(height: 12),
          _rule('At least 8 characters', hasLength),
          _rule('At least one uppercase letter', hasUppercase),
          _rule('At least one number', hasNumber),
        ],
      ),
    );
  }

  Widget _rule(String text, bool completed) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        children: [
          Icon(
            completed
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            size: 17,
            color: completed ? const Color(0xFF176B5B) : Colors.grey.shade400,
          ),
          const SizedBox(width: 8),
          CustomText(
            text:text,
            style: TextStyle(
              fontSize: 12,
              color: completed ? const Color(0xFF176B5B) : Colors.grey.shade600,
              fontWeight: completed ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF176B5B);
    const background = Color(0xFFF8FAF9);

    return Scaffold(
      backgroundColor: background,

      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF17201D),
            ),
          ),
        ),
        title: const CustomText(
         text: 'Change Password',
          style: TextStyle(
            color: Color(0xFF17201D),
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: false,
      ),

      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFE8F5F1), Color(0xFFF5FAF8)],
                  ),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.lock_reset_rounded,
                        color: Colors.white,
                        size: 27,
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text:'Secure your account',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF17201D),
                            ),
                          ),
                          SizedBox(height: 5),
                          CustomText(
                            text:'Create a strong password to keep your Kharcha account protected.',
                            style: TextStyle(
                              fontSize: 12,
                              height: 1.4,
                              color: Color(0xFF63716D),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              _buildPasswordField(
                label: 'Current Password',
                hint: 'Enter current password',
                icon: Icons.lock_outline_rounded,
                controller: _currentPasswordController,
                obscure: _obscureCurrent,
                onToggle: () {
                  setState(() {
                    _obscureCurrent = !_obscureCurrent;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your current password';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              _buildPasswordField(
                label: 'New Password',
                hint: 'Enter new password',
                icon: Icons.lock_rounded,
                controller: _newPasswordController,
                obscure: _obscureNew,
                onToggle: () {
                  setState(() {
                    _obscureNew = !_obscureNew;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a new password';
                  }

                  if (value.length < 8) {
                    return 'Password must contain at least 8 characters';
                  }

                  if (!value.contains(RegExp(r'[A-Z]'))) {
                    return 'Add at least one uppercase letter';
                  }

                  if (!value.contains(RegExp(r'[0-9]'))) {
                    return 'Add at least one number';
                  }

                  if (value == _currentPasswordController.text) {
                    return 'New password must be different';
                  }

                  return null;
                },
                // Rebuild password requirements while typing.
              ),

              const SizedBox(height: 12),

              _buildPasswordRules(),

              const SizedBox(height: 20),

              _buildPasswordField(
                label: 'Confirm New Password',
                hint: 'Re-enter new password',
                icon: Icons.verified_user_outlined,
                controller: _confirmPasswordController,
                obscure: _obscureConfirm,
                onToggle: () {
                  setState(() {
                    _obscureConfirm = !_obscureConfirm;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your new password';
                  }

                  if (value != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 30),

              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _changePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: primary.withValues(alpha: 0.55),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.4,
                            color: Colors.white,
                          ),
                        )
                      :  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.lock_reset_rounded, size: 20),
                            SizedBox(width: 9),
                            CustomText(
                              text:'Update Password',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                ),
              ),

              const SizedBox(height: 18),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shield_outlined,
                    size: 16,
                    color: Colors.grey.shade500,
                  ),
                  const SizedBox(width: 6),
                  CustomText(
                    text:'Your password is securely encrypted',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
