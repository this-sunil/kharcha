import 'package:flutter/material.dart';

import '../core/util/CustomText.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

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
          'Help & Support',
          style: TextStyle(
            color: textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
        children: [
          _buildHeader(),

          const SizedBox(height: 25),

          const CustomText(text:
            'How can we help?',
            style: TextStyle(
              color: textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 12),

          _helpItem(
            icon: Icons.account_balance_rounded,
            title: 'Loan Management',
            subtitle: 'Manage loans, EMI and repayments',
          ),

          _helpItem(
            icon: Icons.payments_rounded,
            title: 'Payments & Transactions',
            subtitle: 'Understand payments and transactions',
          ),

          _helpItem(
            icon: Icons.receipt_long_rounded,
            title: 'Expenses',
            subtitle: 'Track and manage your expenses',
          ),

          _helpItem(
            icon: Icons.notifications_active_rounded,
            title: 'Notifications',
            subtitle: 'EMI reminders and financial alerts',
          ),

          _helpItem(
            icon: Icons.person_outline_rounded,
            title: 'Account & Profile',
            subtitle: 'Manage your account settings',
          ),

          const SizedBox(height: 22),

          const CustomText(text:
            'Frequently Asked Questions',
            style: TextStyle(
              color: textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 12),

          _faq(
            'How do I add a new loan?',
            'Open Loans from the dashboard and tap Add Loan. Enter the loan amount, interest rate, tenure and payment details.',
          ),

          _faq(
            'How can I record an EMI payment?',
            'Open the relevant loan and select repayment. Enter the amount paid and save the transaction.',
          ),

          _faq(
            'How do I change my password?',
            'Go to Profile → Security → Change Password and enter your current and new password.',
          ),

          _faq(
            'How do I change my currency?',
            'Go to Profile → Currency, select your preferred currency and tap Save Currency.',
          ),

          _faq(
            'How can I contact support?',
            'Open Contact Support and send your issue or question to our support team.',
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text:
                        'Still need help?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 5),
                      CustomText(text:
                        'Our support team is ready to help you.',
                        style: TextStyle(color: Colors.white70, fontSize: 11),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/contact-support');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const CustomText(text:
                    'Contact',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE8F5F1), Color(0xFFF5FAF8)],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFDDECE7)),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(17),
            ),
            child: const Icon(
              Icons.support_agent_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 15),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text:
                  'We are here to help',
                  style: TextStyle(
                    color: textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 5),
                CustomText(text:
                  'Find answers to common questions or contact our support team.',
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

  Widget _helpItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: const Color(0xFFE5EBE8)),
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF3F0),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: primary, size: 22),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text:
                  title,
                  style: const TextStyle(
                    color: textPrimary,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                CustomText(text:
                  subtitle,
                  style: const TextStyle(color: secondaryText, fontSize: 11),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: Color(0xFF9AA6A2)),
        ],
      ),
    );
  }

  Widget _faq(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE4EAE7)),
      ),
      child: Theme(
        data: ThemeData(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: CustomText(text:
            question,
            style: const TextStyle(
              color: textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          iconColor: primary,
          collapsedIconColor: secondaryText,
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: CustomText(text:
                answer,
                style: const TextStyle(
                  color: secondaryText,
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
