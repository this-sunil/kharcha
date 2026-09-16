import 'package:flutter/material.dart';

import '../../../../core/util/CustomText.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  int selectedFilter = 0;

  static const Color background = Color(0xFFF5F9EE);
  static const Color card = Colors.white;

  static const Color lime = Color(0xFFB7E63B);
  static const Color limeDark = Color(0xFF6D991A);
  static const Color green = Color(0xFF19B85B);

  static const Color textPrimary = Color(0xFF172019);
  static const Color textSecondary = Color(0xFF69756B);
  static const Color muted = Color(0xFF9AA49C);

  static const Color border = Color(0xFFE3EAD9);

  final List<String> filters = [
    'All',
    'Received',
    'Paid',
  ];

  @override
  Widget build(BuildContext context) {
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
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    18,
                    20,
                    30,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      _buildHeader(),

                      const SizedBox(height: 22),

                      _buildSummaryCard(),

                      const SizedBox(height: 20),

                      _buildSearchBar(),

                      const SizedBox(height: 14),

                      _buildFilters(),

                      const SizedBox(height: 26),

                      _buildMonthHeader(
                        'September 2026',
                        '₹18,420',
                      ),

                      const SizedBox(height: 12),

                      _transactionItem(
                        icon: Icons.person_rounded,
                        title: 'Rahul Patil',
                        subtitle: 'Today • 12:42 PM',
                        amount: '+₹5,000',
                        color: const Color(0xFF4D98E8),
                        received: true,
                      ),

                      _transactionItem(
                        icon: Icons.account_balance_wallet_rounded,
                        title: 'Personal Loan',
                        subtitle: 'Today • 09:15 AM',
                        amount: '-₹2,500',
                        color: const Color(0xFFE85E70),
                        received: false,
                      ),

                      _transactionItem(
                        icon: Icons.person_outline_rounded,
                        title: 'Amit Sharma',
                        subtitle: 'Yesterday • 06:32 PM',
                        amount: '+₹3,200',
                        color: const Color(0xFF8B6DE8),
                        received: true,
                      ),

                      _transactionItem(
                        icon: Icons.payments_rounded,
                        title: 'Loan Repayment',
                        subtitle: 'Yesterday • 04:10 PM',
                        amount: '-₹1,800',
                        color: const Color(0xFFE6A72E),
                        received: false,
                      ),

                      const SizedBox(height: 22),

                      _buildMonthHeader(
                        'August 2026',
                        '₹24,680',
                      ),

                      const SizedBox(height: 12),

                      _transactionItem(
                        icon: Icons.person_rounded,
                        title: 'Suresh More',
                        subtitle: '28 Aug • 10:20 AM',
                        amount: '+₹7,500',
                        color: green,
                        received: true,
                      ),

                      _transactionItem(
                        icon: Icons.credit_card_rounded,
                        title: 'EMI Payment',
                        subtitle: '27 Aug • 08:42 PM',
                        amount: '-₹4,680',
                        color: const Color(0xFFE85E70),
                        received: false,
                      ),

                      _transactionItem(
                        icon: Icons.account_balance_rounded,
                        title: 'Bank Loan',
                        subtitle: '25 Aug • 11:30 AM',
                        amount: '+₹15,000',
                        color: green,
                        received: true,
                      ),

                      _transactionItem(
                        icon: Icons.currency_rupee_rounded,
                        title: 'Loan Settlement',
                        subtitle: '23 Aug • 06:15 PM',
                        amount: '-₹2,140',
                        color: const Color(0xFF66A7FF),
                        received: false,
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
            top: 360,
            left: -140,
            child: Container(
              width: 230,
              height: 230,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFDDF3A8)
                    .withValues(alpha: .16),
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
                color: const Color(0xFFBFEA6A)
                    .withValues(alpha: .08),
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

  Widget _buildHeader() {
    return Row(
      children: [


        const SizedBox(width: 14),

        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text:
                'Loan Transactions',
                style: TextStyle(
                  color: textPrimary,
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -.5,
                ),
              ),

              SizedBox(height: 3),

              CustomText(text:
                'Track your lending and borrowing activity',
                style: TextStyle(
                  color: textSecondary,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        _headerButton(
          icon: Icons.tune_rounded,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _headerButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: card,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: border,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .035),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: textSecondary,
            size: 20,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SUMMARY
  // ============================================================

  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(27),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF0F8D9),
            Color(0xFFFFFFFF),
          ],
        ),
        border: Border.all(
          color: Color(0xFFDCE9BB),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF7EA52D),
            blurRadius: 24,
            offset: Offset(0, 9),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(text:
            'LOAN OVERVIEW',
            style: TextStyle(
              color: textSecondary,
              fontSize: 9,
              fontWeight: FontWeight.w800,
              letterSpacing: .8,
            ),
          ),

          const SizedBox(height: 7),

          const CustomText(text:
            '₹18,420',
            style: TextStyle(
              color: textPrimary,
              fontSize: 29,
              fontWeight: FontWeight.w900,
              letterSpacing: -.7,
            ),
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              Expanded(
                child: _summaryItem(
                  icon: Icons.arrow_downward_rounded,
                  title: 'Received',
                  value: '₹52,000',
                  color: green,
                ),
              ),

              Container(
                height: 36,
                width: 1,
                color: Color(0xFFDCE5D7),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: _summaryItem(
                  icon: Icons.arrow_upward_rounded,
                  title: 'Paid',
                  value: '₹18,420',
                  color: Color(0xFFE85E70),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryItem({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: color.withValues(alpha: .10),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 15,
          ),
        ),

        const SizedBox(width: 9),

        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              CustomText(text:
                title,
                style: const TextStyle(
                  color: textSecondary,
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 3),

              CustomText(text:
                value,
                style: const TextStyle(
                  color: textPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SEARCH
  // ============================================================

  Widget _buildSearchBar() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(17),
        child: Container(
          height: 52,
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          decoration: BoxDecoration(
            color: card,
            borderRadius: BorderRadius.circular(17),
            border: Border.all(
              color: border,
            ),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.search_rounded,
                color: textSecondary,
                size: 20,
              ),

              SizedBox(width: 10),

              CustomText(text:
                'Search loan transactions',
                style: TextStyle(
                  color: textSecondary,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),

              Spacer(),

              Icon(
                Icons.keyboard_arrow_right_rounded,
                color: muted,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // FILTERS
  // ============================================================

  Widget _buildFilters() {
    return Row(
      children: List.generate(
        filters.length,
            (index) {
          final bool selected =
              selectedFilter == index;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedFilter = index;
                });
              },
              child: AnimatedContainer(
                duration:
                const Duration(milliseconds: 220),
                margin: EdgeInsets.only(
                  right:
                  index == filters.length - 1
                      ? 0
                      : 8,
                ),
                height: 41,
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFFEAF6C8)
                      : card,
                  borderRadius:
                  BorderRadius.circular(14),
                  border: Border.all(
                    color: selected
                        ? const Color(0xFFCFE698)
                        : border,
                  ),
                ),
                child: Center(
                  child: CustomText(text:
                    filters[index],
                    style: TextStyle(
                      color: selected
                          ? limeDark
                          : textSecondary,
                      fontSize: 10,
                      fontWeight: selected
                          ? FontWeight.w900
                          : FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // MONTH HEADER
  // ============================================================

  Widget _buildMonthHeader(
      String month,
      String amount,
      ) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: limeDark,
            shape: BoxShape.circle,
          ),
        ),

        const SizedBox(width: 8),

        CustomText(text:
          month,
          style: const TextStyle(
            color: textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w900,
          ),
        ),

        const Spacer(),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFEDF3E7),
            borderRadius: BorderRadius.circular(10),
          ),
          child: CustomText(text:
            amount,
            style: const TextStyle(
              color: textSecondary,
              fontSize: 9,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // LOAN TRANSACTION
  // ============================================================

  Widget _transactionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String amount,
    required Color color,
    required bool received,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(19),
        splashColor: lime.withValues(alpha: .06),
        child: Container(
          margin: const EdgeInsets.only(
            bottom: 9,
          ),
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: card,
            borderRadius: BorderRadius.circular(19),
            border: Border.all(
              color: border,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .022),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: .09),
                  borderRadius:
                  BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    CustomText(text:
                      title,
                      style: const TextStyle(
                        color: textPrimary,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 4),

                    CustomText(text:
                      subtitle,
                      style: const TextStyle(
                        color: textSecondary,
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment:
                CrossAxisAlignment.end,
                children: [
                  CustomText(text:
                    amount,
                    style: TextStyle(
                      color: received
                          ? green
                          : textPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Container(
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: received
                          ? const Color(0xFFEAF8EF)
                          : const Color(0xFFFFF0F2),
                      borderRadius:
                      BorderRadius.circular(7),
                    ),
                    child: CustomText(text:
                      received
                          ? 'Received'
                          : 'Paid',
                      style: TextStyle(
                        color: received
                            ? green
                            : const Color(
                          0xFFE85E70,
                        ),
                        fontSize: 7,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
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