import 'package:flutter/material.dart';

import '../../../../core/util/CustomText.dart';

class WalletInfo extends StatelessWidget {
  const WalletInfo({super.key});

  static const Color primary = Color(0xFF5B4BDB);
  static const Color bg = Color(0xFFF7F7FB);
  static const Color textDark = Color(0xFF171725);
  static const Color textMuted = Color(0xFF858596);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bg,
        foregroundColor: textDark,
        title: const CustomText(text:
          'Wallet',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _walletCard(),

              const SizedBox(height: 22),

              _actionButtons(),

              const SizedBox(height: 28),

              _sectionHeader(
                'Money Overview',
                'This month',
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _overviewCard(
                      icon: Icons.arrow_downward_rounded,
                      iconColor: const Color(0xFF159A68),
                      title: 'Money In',
                      amount: '₹42,500',
                      subtitle: '+12.4%',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _overviewCard(
                      icon: Icons.arrow_upward_rounded,
                      iconColor: const Color(0xFFE05252),
                      title: 'Money Out',
                      amount: '₹18,250',
                      subtitle: '-8.2%',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              _sectionHeader(
                'Linked Accounts',
                'Manage',
              ),

              const SizedBox(height: 12),

              _accountTile(
                icon: Icons.account_balance_rounded,
                iconBackground: const Color(0xFFE9E7FF),
                title: 'HDFC Bank',
                subtitle: '•••• 4582',
                trailing: 'Primary',
              ),

              const SizedBox(height: 10),

              _accountTile(
                icon: Icons.account_balance_wallet_rounded,
                iconBackground: const Color(0xFFE4F7EF),
                title: 'Kharcha Wallet',
                subtitle: 'Digital Wallet',
                trailing: 'Active',
              ),

              const SizedBox(height: 28),

              _sectionHeader(
                'Recent Transactions',
                'View all',
              ),

              const SizedBox(height: 12),

              _transactionTile(
                icon: Icons.add_circle_rounded,
                iconBackground: const Color(0xFFE7F7EF),
                title: 'Money Added',
                subtitle: 'Today, 9:25 AM',
                amount: '+ ₹5,000',
                amountColor: const Color(0xFF159A68),
              ),

              _transactionTile(
                icon: Icons.account_balance_rounded,
                iconBackground: const Color(0xFFE8F0FF),
                title: 'Bank Deposit',
                subtitle: '12 Sep, 11:40 AM',
                amount: '+ ₹10,000',
                amountColor: const Color(0xFF159A68),
              ),

              _transactionTile(
                icon: Icons.payments_rounded,
                iconBackground: const Color(0xFFEAF8D9),
                title: 'Cash Deposit',
                subtitle: '11 Sep, 4:20 PM',
                amount: '+ ₹3,500',
                amountColor: const Color(0xFF159A68),
              ),

              _transactionTile(
                icon: Icons.account_balance_wallet_rounded,
                iconBackground: const Color(0xFFF0EAFE),
                title: 'Wallet Top Up',
                subtitle: '10 Sep, 2:15 PM',
                amount: '+ ₹2,000',
                amountColor: const Color(0xFF159A68),
              ),




              const SizedBox(height: 20),

              _securityCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _walletCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF6C5CE7),
            Color(0xFF4D3CCF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: primary.withValues(alpha: .22),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .15),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(
                  Icons.account_balance_wallet_rounded,
                  color: Colors.white,
                  size: 21,
                ),
              ),
              const SizedBox(width: 11),
              const CustomText(text:
                'Kharcha Wallet',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .14),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.verified_rounded,
                      color: Colors.white,
                      size: 13,
                    ),
                    SizedBox(width: 4),
                    CustomText(text:
                      'Active',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          const CustomText(text:
            'Total Balance',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 6),

          const CustomText(text:
            '₹24,250.00',
            style: TextStyle(
              color: Colors.white,
              fontSize: 31,
              fontWeight: FontWeight.w800,
              letterSpacing: -.8,
            ),
          ),

          const SizedBox(height: 22),

          Row(
            children: [
              const Expanded(
                child: _BalanceInfo(
                  label: 'Available',
                  value: '₹21,850',
                ),
              ),
              Container(
                width: 1,
                height: 35,
                color: Colors.white24,
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: _BalanceInfo(
                    label: 'Pending',
                    value: '₹2,400',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionButtons() {
    return Row(
      children: [
        Expanded(
          child: _actionButton(
            icon: Icons.add_rounded,
            label: 'Add Money',
            filled: true,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _actionButton(
            icon: Icons.arrow_upward_rounded,
            label: 'Withdraw',
            filled: false,
          ),
        ),
      ],
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    required bool filled,
  }) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: filled ? primary : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: filled
            ? null
            : Border.all(
          color: const Color(0xFFE6E5ED),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
            color: filled ? Colors.white : primary,
          ),
          const SizedBox(width: 8),
          CustomText(text:
            label,
            style: TextStyle(
              color: filled ? Colors.white : textDark,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title, String action) {
    return Row(
      children: [
        CustomText(text:
          title,
          style: const TextStyle(
            color: textDark,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Spacer(),
        CustomText(text:
          action,
          style: const TextStyle(
            color: primary,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _overviewCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String amount,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFECEBF1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: .10),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 18,
            ),
          ),
          const SizedBox(height: 13),
          CustomText(text:
            title,
            style: const TextStyle(
              color: textMuted,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          CustomText(text:
            amount,
            style: const TextStyle(
              color: textDark,
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          CustomText(text:
            subtitle,
            style: TextStyle(
              color: iconColor,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _accountTile({
    required IconData icon,
    required Color iconBackground,
    required String title,
    required String subtitle,
    required String trailing,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFECEBF1),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: primary,
              size: 22,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text:
                  title,
                  style: const TextStyle(
                    color: textDark,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                CustomText(text:
                  subtitle,
                  style: const TextStyle(
                    color: textMuted,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          CustomText(text:
            trailing,
            style: const TextStyle(
              color: primary,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 5),
          const Icon(
            Icons.chevron_right_rounded,
            color: textMuted,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _transactionTile({
    required IconData icon,
    required Color iconBackground,
    required String title,
    required String subtitle,
    required String amount,
    required Color amountColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 4,
        ),
        child: Row(
          children: [
            Container(
              height: 43,
              width: 43,
              decoration: BoxDecoration(
                color: iconBackground,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(
                icon,
                color: textDark,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text:
                    title,
                    style: const TextStyle(
                      color: textDark,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  CustomText(text:
                    subtitle,
                    style: const TextStyle(
                      color: textMuted,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            CustomText(text:
              amount,
              style: TextStyle(
                color: amountColor,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _securityCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFEEFF),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.lock_rounded,
              color: primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text:
                  'Your wallet is secure',
                  style: TextStyle(
                    color: textDark,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 3),
                CustomText(text:
                  'Protected with secure authentication',
                  style: TextStyle(
                    color: textMuted,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.verified_user_rounded,
            color: primary,
            size: 21,
          ),
        ],
      ),
    );
  }
}

class _BalanceInfo extends StatelessWidget {
  final String label;
  final String value;

  const _BalanceInfo({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text:
          label,
          style: const TextStyle(
            color: Colors.white60,
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 3),
        CustomText(text:
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}