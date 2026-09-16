import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kharcha/core/router/app_routes.dart';

import '../../../../core/util/CustomText.dart';
import '../riverpod/auth_provider.dart';

class AuthUpdate extends ConsumerStatefulWidget {
  const AuthUpdate({super.key});

  @override
  ConsumerState<AuthUpdate> createState() => _AuthUpdateState();
}

class _AuthUpdateState extends ConsumerState<AuthUpdate> {
  // ================= COLORS =================

  static const Color background = Color(0xFFF5F8F3);
  static const Color card = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFF0F5EE);

  static const Color green = Color(0xFF8BCF3F);
  static const Color greenDark = Color(0xFF65A52A);

  static const Color primaryText = Color(0xFF172016);
  static const Color secondaryText = Color(0xFF687267);
  static const Color border = Color(0xFFE1E9DE);

  // ================= CONTROLLERS =================

  final nameController = TextEditingController(text: "Sunil Shedge");

  final phoneController = TextEditingController(text: "+91 98765 43210");

  final emailController = TextEditingController(text: "sunil@example.com");

  final occupationController = TextEditingController(
    text: "Software Developer",
  );

  final incomeController = TextEditingController(text: "75000");

  String selectedGender = "Male";
  XFile? photos;
  ImagePicker picker = ImagePicker();
  Future<XFile?> pickPhoto(ImageSource source) async {
    final photo = await picker.pickImage(source: source);
    if (photo == null) {
      throw Exception("No Image Found");
    }
    setState(() {
      photos = XFile(photo.path);
    });
    return photo;
  }
  @override
  void initState() {
    super.initState();



  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    occupationController.dispose();
    incomeController.dispose();
    super.dispose();
  }


  // ================= BUILD =================

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    return Scaffold(
      backgroundColor: background,

      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        centerTitle: false,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: primaryText,
          ),
          onPressed: () => Navigator.pop(context),
        ),

        title: const CustomText(
          text: "Update Profile",
          style: TextStyle(
            color: primaryText,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 110),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= PROFILE HEADER =================

              authState.when(
                data: (item) {
                  return _buildProfileHeader(
                    name: item.result?.name ?? '',
                    photo: photos==null?null:File(photos!.path),
                    onCameraTap: _showPhotoOptions
                  );
                },

                error: (error, stackTrace) {
                  return Center(
                    child: CustomText(text: 'Unable to load profile'),
                  );
                },

                loading: () {
                  return const Center(child: CircularProgressIndicator());
                },
              ),
              const SizedBox(height: 28),

              // ================= PERSONAL INFORMATION =================
              _buildSectionTitle(
                "Personal Information",
                "Keep your profile details up to date",
              ),

              const SizedBox(height: 14),

              _buildInputCard(
                children: [
                  _buildTextField(
                    controller: nameController,
                    label: "Full Name",
                    hint: "Enter your full name",
                    icon: Icons.person_outline_rounded,
                  ),

                  _divider(),

                  _buildTextField(
                    controller: phoneController,
                    label: "Mobile Number",
                    hint: "Enter mobile number",
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                  ),

                  _divider(),

                  _buildTextField(
                    controller: emailController,
                    label: "Email Address",
                    hint: "Enter email address",
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  _divider(),

                  _buildTextField(
                    controller: occupationController,
                    label: "Occupation",
                    hint: "Enter occupation",
                    icon: Icons.work_outline_rounded,
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // ================= FINANCIAL INFORMATION =================
              _buildSectionTitle(
                "Financial Information",
                "Used to personalize your Kharcha experience",
              ),

              const SizedBox(height: 14),

              _buildInputCard(
                children: [
                  _buildTextField(
                    controller: incomeController,
                    label: "Monthly Income",
                    hint: "Enter monthly income",
                    icon: Icons.currency_rupee_rounded,
                    keyboardType: TextInputType.number,
                  ),

                  _divider(),

                  _buildDropdownField(),
                ],
              ),

              const SizedBox(height: 28),

              // ================= SECURITY =================
              _buildSectionTitle("Security", "Manage your account security"),

              const SizedBox(height: 14),

              _buildSecurityCard(),

              const SizedBox(height: 28),

              // ================= ACCOUNT =================
              _buildSectionTitle("Account", "Manage your Kharcha account"),

              const SizedBox(height: 14),

              _buildAccountCard(),

              const SizedBox(height: 30),

              // ================= SAVE BUTTON =================
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  // ================= PROFILE HEADER =================

  Widget _buildProfileHeader({
    required String name,
    String subtitle = 'Manage your personal profile',
    File? photo,
    VoidCallback? onCameraTap,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE3EAD9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 92,
                height: 92,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8BCF3F), Color(0xFF65A52A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: photo == null
                    ? Center(
                        child: CustomText(
                          text: _getInitials(name),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      )
                    : ClipOval(child: Image.file(photo, fit: BoxFit.cover)),
              ),

              // Camera
              Positioned(
                right: -2,
                bottom: -2,
                child: GestureDetector(
                  onTap: onCameraTap,
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: const Color(0xFF172019),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          CustomText(
            text: name.isEmpty ? 'User' : name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF172019),
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 5),

          CustomText(
            text: subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF69756B),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _getInitials(String name) {
    final value = name.trim();

    if (value.isEmpty) return 'U';

    final parts = value.split(RegExp(r'\s+'));

    if (parts.length == 1) {
      return parts.first[0].toUpperCase();
    }

    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  // ================= SECTION TITLE =================

  Widget _buildSectionTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          style: const TextStyle(
            color: primaryText,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(height: 3),

        CustomText(
          text: subtitle,
          style: const TextStyle(
            color: secondaryText,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // ================= INPUT CARD =================

  Widget _buildInputCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: border),
      ),
      child: Column(children: children),
    );
  }

  // ================= TEXT FIELD =================

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),

      child: TextField(
        controller: controller,
        keyboardType: keyboardType,

        style: const TextStyle(
          color: primaryText,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),

        decoration: InputDecoration(
          border: InputBorder.none,

          prefixIcon: Container(
            margin: const EdgeInsets.only(right: 12, top: 10, bottom: 10),

            decoration: BoxDecoration(
              color: cardLight,
              borderRadius: BorderRadius.circular(11),
            ),

            child: Icon(icon, color: greenDark, size: 20),
          ),

          labelText: label,

          labelStyle: const TextStyle(
            color: secondaryText,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),

          hintText: hint,

          hintStyle: const TextStyle(color: secondaryText, fontSize: 13),
        ),
      ),
    );
  }

  // ================= DROPDOWN =================

  Widget _buildDropdownField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),

      child: DropdownButtonFormField<String>(
        initialValue: selectedGender,

        decoration: InputDecoration(
          border: InputBorder.none,

          prefixIcon: Container(
            margin: const EdgeInsets.only(right: 12, top: 10, bottom: 10),

            decoration: BoxDecoration(
              color: cardLight,
              borderRadius: BorderRadius.circular(11),
            ),

            child: const Icon(Icons.person_rounded, color: greenDark, size: 20),
          ),

          labelText: "Gender",

          labelStyle: const TextStyle(
            color: secondaryText,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),

        icon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: secondaryText,
        ),

        style: const TextStyle(
          color: primaryText,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),

        items: const [
          DropdownMenuItem(
            value: "Male",
            child: CustomText(text: "Male"),
          ),
          DropdownMenuItem(
            value: "Female",
            child: CustomText(text: "Female"),
          ),
          DropdownMenuItem(
            value: "Other",
            child: CustomText(text: "Other"),
          ),
        ],

        onChanged: (value) {
          if (value != null) {
            setState(() {
              selectedGender = value;
            });
          }
        },
      ),
    );
  }

  // ================= SECURITY CARD =================

  Widget _buildSecurityCard() {
    return Container(
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: border),
      ),

      child: Column(
        children: [
          _buildActionTile(
            icon: Icons.lock_outline_rounded,
            title: "Change Password",
            subtitle: "Update your account password",
            onTap: () {},
          ),

          _divider(),

          _buildActionTile(
            onTap: () {},
            icon: Icons.fingerprint_rounded,
            title: "Biometric Login",
            subtitle: "Use fingerprint or Face ID",
            trailing: Switch(
              value: true,
              activeThumbColor: greenDark,
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }

  // ================= ACCOUNT CARD =================

  Widget _buildAccountCard() {
    return Container(
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: border),
      ),

      child: Column(
        children: [
          _buildActionTile(
            icon: Icons.notifications_none_rounded,
            title: "Notifications",
            subtitle: "Manage financial alerts",
            onTap: () {
              context.push(AppRoutes.notification);
            },
          ),

          _divider(),

          _buildActionTile(
            icon: Icons.delete_outline_rounded,
            title: "Delete Account",
            subtitle: "Permanently remove your account",
            iconColor: const Color(0xFFE45564),
            onTap: () {
              _showDeleteDialog();
            },
          ),
        ],
      ),
    );
  }

  // ================= ACTION TILE =================

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Widget? trailing,
    Color iconColor = greenDark,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),

        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,

              decoration: BoxDecoration(
                color: cardLight,
                borderRadius: BorderRadius.circular(13),
              ),

              child: Icon(icon, color: iconColor, size: 21),
            ),

            const SizedBox(width: 13),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: title,
                    style: const TextStyle(
                      color: primaryText,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 3),

                  CustomText(
                    text: subtitle,
                    style: const TextStyle(
                      color: secondaryText,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            trailing ??
                const Icon(
                  Icons.chevron_right_rounded,
                  color: secondaryText,
                  size: 21,
                ),
          ],
        ),
      ),
    );
  }

  // ================= DIVIDER =================

  Widget _divider() {
    return const Divider(
      height: 1,
      thickness: 1,
      indent: 72,
      endIndent: 16,
      color: border,
    );
  }

  // ================= SAVE BUTTON =================

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 58,

      child: ElevatedButton(
        onPressed: _saveProfile,

        style: ElevatedButton.styleFrom(
          backgroundColor: primaryText,
          foregroundColor: Colors.white,

          elevation: 0,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.check_circle_outline_rounded, size: 20),

            SizedBox(width: 9),

            CustomText(
              text: "Save Changes",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }

  // ================= SAVE =================

  void _saveProfile() {
    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: Colors.white),
            SizedBox(width: 10),
            CustomText(
              text: "Profile updated successfully",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),

        backgroundColor: greenDark,

        behavior: SnackBarBehavior.floating,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }

  // ================= PHOTO OPTIONS =================

  void _showPhotoOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),

      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,

                  decoration: BoxDecoration(
                    color: border,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 20),

                const CustomText(
                  text: "Update Profile Photo",
                  style: TextStyle(
                    color: primaryText,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 18),

                _buildPhotoOption(
                  icon: Icons.camera_alt_rounded,
                  title: "Take a Photo",
                  onTap: () async {
                    await pickPhoto(ImageSource.gallery).whenComplete(() {
                      Future.delayed(Duration(seconds: 1), () {
                        context.pop();
                      });
                    });
                  },
                ),

                _buildPhotoOption(
                  icon: Icons.photo_library_outlined,
                  title: "Choose from Gallery",
                  onTap: () async {
                    await pickPhoto(ImageSource.gallery).whenComplete(() {
                      Future.delayed(Duration(seconds: 1), () {
                        context.pop();
                      });
                    });
                  },
                ),

                _buildPhotoOption(
                  icon: Icons.delete_outline_rounded,
                  title: "Remove Photo",
                  onTap: () {
                    setState(() {
                      photos = null;
                    });
                    context.pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPhotoOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,

      leading: Container(
        width: 44,
        height: 44,

        decoration: BoxDecoration(
          color: cardLight,
          borderRadius: BorderRadius.circular(13),
        ),

        child: Icon(icon, color: greenDark),
      ),

      title: CustomText(
        text: title,
        style: const TextStyle(
          color: primaryText,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),

      onTap: onTap,
    );
  }

  // ================= DELETE DIALOG =================

  void _showDeleteDialog() {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          backgroundColor: card,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),

          title: const CustomText(
            text: "Delete Account?",
            style: TextStyle(color: primaryText, fontWeight: FontWeight.w800),
          ),

          content: const CustomText(
            text:
                "This action cannot be undone. Your Kharcha account and associated data may be permanently removed.",
            style: TextStyle(color: secondaryText, height: 1.5),
          ),

          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),

              child: const CustomText(
                text: "Cancel",
                style: TextStyle(
                  color: secondaryText,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const CustomText(
                text: "Delete",
                style: TextStyle(
                  color: Color(0xFFE45564),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
