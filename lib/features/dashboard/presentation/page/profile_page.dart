import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:kharcha/core/Storage/secure_storage.dart';
import 'package:kharcha/core/router/app_routes.dart';
import 'package:kharcha/features/auth/presentation/riverpod/auth_provider.dart';

import '../../../../core/util/CustomText.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  // ============================================================
  // COLORS
  // ============================================================

  static const Color background = Color(0xFFF5F9EE);
  static const Color card = Colors.white;

  static const Color lime = Color(0xFFB7E63B);
  static const Color limeDark = Color(0xFF6D991A);
  static const Color green = Color(0xFF19B85B);

  static const Color textPrimary = Color(0xFF172019);
  static const Color textSecondary = Color(0xFF69756B);
  static const Color muted = Color(0xFF98A29A);

  static const Color border = Color(0xFFE3EAD9);

  // ============================================================
  // PROFILE FUTURE
  // ============================================================


  @override
  void initState() {
    super.initState();



  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final authState=ref.watch(authNotifierProvider);
    return Scaffold(
      backgroundColor: background,
      body: Stack(
        children: [
          _backgroundDecoration(),

          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      _header(),

                      const SizedBox(height: 24),


                      authState.when(
                        data: (item) {
                          return GestureDetector(
                            onTap: () {
                              context.push(AppRoutes.updateProfile);
                            },
                            child: _profileCard(
                              name: item.result?.name ?? '',
                              phone: item.result?.phone ?? '',
                            ),
                          );
                        },

                        loading: () {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 40),
                              child: CircularProgressIndicator(
                                color: card,
                                strokeWidth: 2.5,
                              ),
                            ),
                          );
                        },

                        error: (error, stackTrace) {
                          return Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(
                                color: card,
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.error_outline_rounded,
                                  color: Color(0xFFE85E70),
                                ),

                                const SizedBox(width: 12),

                                const Expanded(
                                  child: CustomText(
                                    text: 'Unable to load profile',
                                    style: TextStyle(
                                      color: card,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),

                                IconButton(
                                  onPressed: () {
                                    ref.invalidate(authNotifierProvider);
                                  },
                                  icon: const Icon(
                                    Icons.refresh_rounded,
                                    color: card,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),


                      const SizedBox(height: 26),

                      _accountSection(context),

                      const SizedBox(height: 24),

                      _preferencesSection(context),

                      const SizedBox(height: 24),

                      _securitySection(context),

                      const SizedBox(height: 24),

                      _supportSection(context),

                      const SizedBox(height: 28),

                      GestureDetector(onTap: _logout, child: _logoutButton()),

                      const SizedBox(height: 16),

                      const Center(
                        child: CustomText(
                          text: 'Kharcha • Version 1.0.0',
                          style: TextStyle(
                            color: Color(0xFF9AA39B),
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            letterSpacing: .3,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // LOGOUT
  // ============================================================

  Future<void> _logout() async {
    await SecureStorage.instance.reset();

    if (!mounted) return;

    context.pushReplacement(AppRoutes.login);
  }

  // ============================================================
  // BACKGROUND
  // ============================================================

  Widget _backgroundDecoration() {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -100,
            right: -80,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: lime.withValues(alpha: .13),
              ),
            ),
          ),

          Positioned(
            top: 330,
            left: -140,
            child: Container(
              width: 230,
              height: 230,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFDDF3A8).withValues(alpha: .18),
              ),
            ),
          ),

          Positioned(
            bottom: 100,
            right: -120,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFBFEA6A).withValues(alpha: .08),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _header() {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'ACCOUNT',
                style: TextStyle(
                  color: textSecondary,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.1,
                ),
              ),

              SizedBox(height: 5),

              CustomText(
                text: 'Profile & Settings',
                style: TextStyle(
                  color: textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -.5,
                ),
              ),
            ],
          ),
        ),

        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: card,
            shape: BoxShape.circle,
            border: Border.all(color: border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .035),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Icon(
            Icons.settings_outlined,
            color: textSecondary,
            size: 20,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // PROFILE CARD
  // ============================================================

  Widget _profileCard({required String name, required String phone}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF2FAD9), Color(0xFFFFFFFF)],
        ),
        border: Border.all(color: Color(0xFFDDE9BC)),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF7DA82A).withValues(alpha: .08),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          // ======================================================
          // AVATAR
          // ======================================================

          Stack(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFD6F477), Color(0xFF91C52D)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: lime.withValues(alpha: .30),
                      blurRadius: 20,
                      offset: const Offset(0, 7),
                    ),
                  ],
                ),
                child: Center(
                  child: CustomText(
                    text: _getInitials(name),
                    style: const TextStyle(
                      color: Color(0xFF31420F),
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),

              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 23,
                  height: 23,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFDCE8C2),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .08),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.edit_rounded,
                    color: limeDark,
                    size: 11,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(width: 15),

          // ======================================================
          // USER INFO
          // ======================================================
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: textPrimary,
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                const SizedBox(height: 5),

                CustomText(
                  text: phone.isEmpty ? 'Phone number not available' : phone,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: textSecondary,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                const Row(
                  children: [
                    Icon(Icons.verified_rounded, color: green, size: 13),

                    SizedBox(width: 5),

                    CustomText(
                      text: 'Verified account',
                      style: TextStyle(
                        color: green,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // ======================================================
          // ARROW
          // ======================================================
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .75),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.chevron_right_rounded,
              color: textSecondary,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // INITIALS
  // ============================================================

  String _getInitials(String name) {
    final value = name.trim();

    if (value.isEmpty) {
      return 'U';
    }

    final parts = value.split(RegExp(r'\s+'));

    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }

    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  // ============================================================
  // PROFILE LOADING
  // ============================================================

  Widget _profileLoading() {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: border),
      ),
      child: const Center(
        child: SizedBox(
          width: 25,
          height: 25,
          child: CircularProgressIndicator(strokeWidth: 2.5, color: limeDark),
        ),
      ),
    );
  }

  // ============================================================
  // PROFILE ERROR
  // ============================================================

  Widget _profileError({required String message}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: border),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFE85E70).withValues(alpha: .09),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.error_outline_rounded,
              color: Color(0xFFE85E70),
              size: 20,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: CustomText(
              text: message,
              style: const TextStyle(
                color: textSecondary,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          IconButton(
            onPressed: () {
              setState(() {
                ref
                    .read(authNotifierProvider.notifier)
                    .fetchProfile();
              });
            },
            icon: const Icon(Icons.refresh_rounded, color: limeDark, size: 20),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ACCOUNT
  // ============================================================

  Widget _accountSection(BuildContext context) {
    return _section(
      title: 'Account',
      children: [
        _settingTile(
          icon: Icons.person_outline_rounded,
          title: 'Personal information',
          subtitle: 'Name, phone & email',
          color: const Color(0xFF4D98E8),
          onTap: () {
            context.push(AppRoutes.updateProfile);
          },
        ),

        _divider(),

        _settingTile(
          icon: Icons.account_balance_wallet_outlined,
          title: 'Wallet & accounts',
          subtitle: 'Manage connected accounts',
          color: green,
          onTap: () {
            context.push(AppRoutes.walletInfo);
          },
        ),
      ],
    );
  }

  // ============================================================
  // PREFERENCES
  // ============================================================

  Widget _preferencesSection(BuildContext context) {
    return _section(
      title: 'Preferences',
      children: [
        _settingTile(
          icon: Icons.notifications_none_rounded,
          title: 'Notifications',
          subtitle: 'Alerts & reminders',
          color: const Color(0xFFE99A3D),
          onTap: () {
            context.push(AppRoutes.notification);
          },
        ),

        _divider(),

        _settingTile(
          icon: Icons.currency_rupee_rounded,
          title: 'Currency',
          subtitle: 'Indian Rupee (₹)',
          color: green,
          onTap: () {
            context.push(AppRoutes.currency);
          },
        ),

        _divider(),

        _settingTile(
          icon: Icons.wb_sunny_outlined,
          title: 'Appearance',
          subtitle: 'Light lime mode',
          color: const Color(0xFFE1A92E),
          trailing: Switch(
            value: true,
            onChanged: (value) {},
            activeThumbColor: limeDark,
            activeTrackColor: lime.withValues(alpha: .35),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: const Color(0xFFDDE3D8),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SECURITY
  // ============================================================

  Widget _securitySection(BuildContext context) {
    return _section(
      title: 'Security',
      children: [
        _settingTile(
          icon: Icons.lock_outline_rounded,
          title: 'Change password',
          subtitle: 'Update your account password',
          color: const Color(0xFFE85E70),
          onTap: () {
            context.push(AppRoutes.authChangePass);
          },
        ),

        _divider(),

        _settingTile(
          icon: Icons.fingerprint_rounded,
          title: 'Biometric lock',
          subtitle: 'Face ID / Fingerprint',
          color: green,
          trailing: Switch(
            value: true,
            onChanged: (value) {},
            activeThumbColor: limeDark,
            activeTrackColor: lime.withValues(alpha: .35),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: const Color(0xFFDDE3D8),
          ),
        ),

        _divider(),

        _settingTile(
          icon: Icons.devices_outlined,
          title: 'Active sessions',
          subtitle: 'Manage logged-in devices',
          color: const Color(0xFF4D98E8),
          onTap: () {},
        ),
      ],
    );
  }

  // ============================================================
  // SUPPORT
  // ============================================================

  Widget _supportSection(BuildContext context) {
    return _section(
      title: 'Support',
      children: [
        _settingTile(
          icon: Icons.help_outline_rounded,
          title: 'Help center',
          subtitle: 'Get help with Kharcha',
          color: const Color(0xFF4D98E8),
          onTap: () {
            context.push(AppRoutes.help);
          },
        ),

        _divider(),

        _settingTile(
          icon: Icons.chat_bubble_outline_rounded,
          title: 'Contact support',
          subtitle: 'We are here to help',
          color: green,
          onTap: () {
            context.push(AppRoutes.contact);
          },
        ),

        _divider(),

        _settingTile(
          icon: Icons.privacy_tip_outlined,
          title: 'Privacy policy',
          subtitle: 'Your privacy matters',
          color: const Color(0xFF8B6DE8),
          onTap: () {
            context.push(AppRoutes.privacy);
          },
        ),
      ],
    );
  }

  // ============================================================
  // SECTION
  // ============================================================

  Widget _section({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2),
          child: CustomText(
            text: title,
            style: const TextStyle(
              color: textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w900,
              letterSpacing: -.2,
            ),
          ),
        ),

        const SizedBox(height: 12),

        Container(
          decoration: BoxDecoration(
            color: card,
            borderRadius: BorderRadius.circular(23),
            border: Border.all(color: border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .025),
                blurRadius: 18,
                offset: const Offset(0, 7),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  // ============================================================
  // SETTING TILE
  // ============================================================

  Widget _settingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        splashColor: lime.withValues(alpha: .08),
        highlightColor: lime.withValues(alpha: .04),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
          child: Row(
            children: [
              // ==================================================
              // ICON
              // ==================================================

              Container(
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: .09),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(icon, color: color, size: 19),
              ),

              const SizedBox(width: 12),

              // ==================================================
              // TEXT
              // ==================================================
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: title,
                      style: const TextStyle(
                        color: textPrimary,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 4),

                    CustomText(
                      text: subtitle,
                      style: const TextStyle(
                        color: textSecondary,
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // ==================================================
              // TRAILING
              // ==================================================
              trailing ??
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFFA0AAA2),
                    size: 20,
                  ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // DIVIDER
  // ============================================================

  Widget _divider() {
    return const Padding(
      padding: EdgeInsets.only(left: 70),
      child: Divider(height: 1, thickness: .7, color: border),
    );
  }

  // ============================================================
  // LOGOUT
  // ============================================================

  Widget _logoutButton() {
    return Container(
      height: 58,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4F5),
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: const Color(0xFFF5D9DD)),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.logout_rounded, color: Color(0xFFE85E70), size: 19),

          SizedBox(width: 9),

          CustomText(
            text: 'Log out',
            style: TextStyle(
              color: Color(0xFFE85E70),
              fontSize: 11,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
