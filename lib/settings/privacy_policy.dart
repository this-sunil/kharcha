import 'package:flutter/material.dart';

import '../core/util/CustomText.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  static const Color primary = Color(0xFF176B5B);
  static const Color background = Color(0xFFF8FAF9);
  static const Color textPrimary = Color(0xFF17201D);
  static const Color secondaryText = Color(0xFF687570);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded, color: textPrimary),
        ),
        title: const CustomText(text:
          'Privacy Policy',
          style: TextStyle(
            color: textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 35),
        children: [
          _header(),

          const SizedBox(height: 25),

          _section(
            '1. Introduction',
            'Kharcha respects your privacy and is committed to protecting your personal information. This Privacy Policy explains how information may be collected, used and protected when you use the Kharcha application.',
          ),

          _section(
            '2. Information We Collect',
            'Depending on the features you use, Kharcha may process information such as your name, phone number, account information, loan details, repayment information, expenses and application preferences.',
          ),

          _section(
            '3. How We Use Information',
            'Information may be used to provide and improve Kharcha services, manage your account, display loan and expense information, provide reminders, communicate with you and maintain application security.',
          ),

          _section(
            '4. Financial Information',
            'Financial information entered into Kharcha is intended to help you manage personal loans, repayments and expenses. You should only enter information that you are authorized to provide.',
          ),

          _section(
            '5. Data Security',
            'We use reasonable technical and organizational safeguards to help protect information against unauthorized access, alteration, disclosure or destruction. No internet-based service can guarantee absolute security.',
          ),

          _section(
            '6. Data Sharing',
            'We do not intend to sell your personal information. Information may be processed or disclosed where necessary to provide the service, comply with applicable law, prevent fraud or protect the security and rights of users and the service.',
          ),

          _section(
            '7. Notifications',
            'Kharcha may send notifications related to loan repayments, EMI due dates, account activity, security events and other financial reminders.',
          ),

          _section(
            '8. Your Choices',
            'You may update certain account information and application preferences from within Kharcha. You can also contact support regarding questions about your information or account.',
          ),

          _section(
            '9. Policy Updates',
            'This Privacy Policy may be updated from time to time to reflect changes to the application, legal requirements or our practices. Updated versions will be made available through the application.',
          ),

          _section(
            '10. Contact Us',
            'If you have questions, concerns or requests regarding this Privacy Policy, please contact the Kharcha support team through the Contact Support section of the application.',
          ),

          const SizedBox(height: 5),

          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF3F0),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline_rounded, color: primary, size: 20),
                SizedBox(width: 10),
                Expanded(
                  child: CustomText(text:
                    'Last updated: September 2026\n\n'
                    'Review this policy against your actual data practices and applicable laws before publishing the application.',
                    style: TextStyle(
                      color: secondaryText,
                      fontSize: 11,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _header() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE8F5F1), Color(0xFFF5FAF8)],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFDDECE7)),
      ),
      child: const Row(
        children: [
          Icon(Icons.privacy_tip_rounded, color: primary, size: 38),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text:
                  'Your privacy matters',
                  style: TextStyle(
                    color: textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 5),
                CustomText(text:
                  'Learn how Kharcha handles information and protects your account.',
                  style: TextStyle(
                    color: secondaryText,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _section(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(text:
            title,
            style: const TextStyle(
              color: textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 7),
          CustomText(text:
            content,
            style: const TextStyle(
              color: secondaryText,
              fontSize: 12,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
