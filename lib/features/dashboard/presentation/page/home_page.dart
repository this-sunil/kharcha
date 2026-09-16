import 'package:flutter/material.dart';
import 'package:kharcha/core/util/CustomAnimation.dart';

import '../../../../core/util/CustomText.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ============================================================
  // COLORS
  // ============================================================

  static const Color background = Color(0xFFF6F8F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color dark = Color(0xFF172019);
  static const Color darkSoft = Color(0xFF263129);
  static const Color secondary = Color(0xFF718078);

  static const Color green = Color(0xFF8BCF3F);
  static const Color greenDark = Color(0xFF5D9827);
  static const Color greenLight = Color(0xFFEAF7DA);

  static const Color orange = Color(0xFFF2A94A);
  static const Color blue = Color(0xFF5A9BEF);
  static const Color purple = Color(0xFF9478E8);
  static const Color red = Color(0xFFE45B68);

  static const Color border = Color(0xFFE2E9E0);

  int selectedBottomNav = 0;

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildHeader(),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 120),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    _buildHeroBalanceCard(),

                    const SizedBox(height: 18),

                    _buildQuickActions(),

                    const SizedBox(height: 28),

                    _buildSectionHeader(
                      title: 'Upcoming payment',
                      action: 'Calendar',
                    ),

                    const SizedBox(height: 12),

                    _buildUpcomingPayment(),

                    const SizedBox(height: 28),

                    _buildSectionHeader(
                      title: 'My loans',
                      action: 'View all',
                    ),

                    const SizedBox(height: 12),

                    _buildLoanCarousel(),

                    const SizedBox(height: 28),

                    _buildSectionHeader(
                      title: 'Repayment progress',
                      action: 'Details',
                    ),

                    const SizedBox(height: 12),

                    _buildRepaymentCard(),

                    const SizedBox(height: 28),

                    _buildSectionHeader(
                      title: 'Recent activity',
                      action: 'View all',
                    ),

                    const SizedBox(height: 12),

                    _buildRecentActivity(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: _buildFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    return SliverAppBar(
      backgroundColor: background,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      pinned: true,
      toolbarHeight: 78,
      automaticallyImplyLeading: false,

      titleSpacing: 18,

      title: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: greenLight,
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFD6E9C5),
              ),
            ),
            child: const Center(
              child: CustomText(text:
                'S',
                style: TextStyle(
                  color: greenDark,
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(text:
                  'Good evening 👋',
                  style: TextStyle(
                    color: secondary,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 3),

                const CustomText(text:
                  'Welcome back, Sunil',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: dark,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
          ),

          _iconButton(
            icon: Icons.notifications_none_rounded,
            badge: true,
            onTap: () {},
          ),

          const SizedBox(width: 8),

          _iconButton(
            icon: Icons.more_horiz_rounded,
            onTap: () {},
          ),
        ],
      ),
    );
  }
  Widget _iconButton({
    required IconData icon,
    required VoidCallback onTap,
    bool badge = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 43,
        height: 43,
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: border),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              icon,
              color: dark,
              size: 21,
            ),

            if (badge)
              Positioned(
                top: 9,
                right: 9,
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: red,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: surface,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HERO BALANCE CARD
  // ============================================================

  Widget _buildHeroBalanceCard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(21, 21, 21, 19),
      decoration: BoxDecoration(
        color: dark,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: dark.withValues(alpha: .16),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -55,
            top: -70,
            child: Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(
                color: green.withValues(alpha: .10),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Positioned(
            right: -10,
            bottom: -95,
            child: Container(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                color: green.withValues(alpha: .06),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .08),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: green,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const CustomText(text:
                          'LOAN OVERVIEW',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 8,
                            fontWeight: FontWeight.w900,
                            letterSpacing: .7,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: green.withValues(alpha: .13),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.trending_down_rounded,
                          color: green,
                          size: 14,
                        ),
                        SizedBox(width: 4),
                        CustomText(text:
                          'On track',
                          style: TextStyle(
                            color: green,
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              const CustomText(text:
                'Total outstanding',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 5),

              const CustomAnimation(amount:
                2126500,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 33,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.2,
                ),
              ),

              const SizedBox(height: 5),

              const CustomText(text:
                'Across 2 active loans',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 22),

              Container(
                height: 1,
                color: Colors.white.withValues(alpha: .08),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _heroStat(
                      title: 'Monthly EMI',
                      value: '₹37,450',
                      icon: Icons.payments_outlined,
                    ),
                  ),

                  Container(
                    height: 38,
                    width: 1,
                    color: Colors.white.withValues(alpha: .08),
                  ),

                  const SizedBox(width: 17),

                  Expanded(
                    child: _heroStat(
                      title: 'Paid so far',
                      value: '₹15.04L',
                      icon: Icons.check_circle_outline_rounded,
                    ),
                  ),

                  Container(
                    height: 38,
                    width: 1,
                    color: Colors.white.withValues(alpha: .08),
                  ),

                  const SizedBox(width: 17),

                  Expanded(
                    child: _heroStat(
                      title: 'Progress',
                      value: '56%',
                      icon: Icons.pie_chart_outline_rounded,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _heroStat({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: green,
          size: 17,
        ),

        const SizedBox(width: 8),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text:
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 8,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 3),

              CustomText(text:
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
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
  // QUICK ACTIONS
  // ============================================================

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _quickAction(
            icon: Icons.currency_rupee_rounded,
            title: 'Pay EMI',
            color: greenDark,
            onTap: () {},
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: _quickAction(
            icon: Icons.add_rounded,
            title: 'Add Loan',
            color: blue,
            onTap: _showAddLoanSheet,
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: _quickAction(
            icon: Icons.receipt_long_outlined,
            title: 'Payments',
            color: purple,
            onTap: () {},
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: _quickAction(
            icon: Icons.analytics_outlined,
            title: 'Insights',
            color: orange,
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget _quickAction({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 53,
            width: double.infinity,
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: border),
            ),
            child: Center(
              child: Container(
                width: 31,
                height: 31,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: .10),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 17,
                ),
              ),
            ),
          ),

          const SizedBox(height: 7),

          CustomText(text:
            title,
            style: const TextStyle(
              color: darkSoft,
              fontSize: 9,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION HEADER
  // ============================================================

  Widget _buildSectionHeader({
    required String title,
    required String action,
  }) {
    return Row(
      children: [
        Expanded(
          child: CustomText(text:
            title,
            style: const TextStyle(
              color: dark,
              fontSize: 17,
              fontWeight: FontWeight.w900,
              letterSpacing: -.3,
            ),
          ),
        ),

        GestureDetector(
          onTap: () {},
          child: Row(
            children: [
              CustomText(text:
                action,
                style: const TextStyle(
                  color: greenDark,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(width: 3),

              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: greenDark,
                size: 9,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // UPCOMING PAYMENT
  // ============================================================

  Widget _buildUpcomingPayment() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .025),
            blurRadius: 15,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 62,
            decoration: BoxDecoration(
              color: orange.withValues(alpha: .10),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomText(text:
                  'SEP',
                  style: TextStyle(
                    color: orange,
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                    letterSpacing: .5,
                  ),
                ),

                const SizedBox(height: 2),

                const CustomText(text:
                  '18',
                  style: TextStyle(
                    color: dark,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(text:
                  'HDFC Personal Loan',
                  style: TextStyle(
                    color: dark,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                const SizedBox(height: 5),

                Row(
                  children: [
                    Icon(
                      Icons.schedule_rounded,
                      color: secondary,
                      size: 12,
                    ),

                    const SizedBox(width: 4),

                    const CustomText(text:
                      'Due in 6 days',
                      style: TextStyle(
                        color: secondary,
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const CustomText(text:
                '₹12,850',
                style: TextStyle(
                  color: dark,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 6),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: orange.withValues(alpha: .10),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const CustomText(text:
                  'UPCOMING',
                  style: TextStyle(
                    color: orange,
                    fontSize: 7,
                    fontWeight: FontWeight.w900,
                    letterSpacing: .4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // LOAN CAROUSEL
  // ============================================================

  Widget _buildLoanCarousel() {
    return SizedBox(
      height: 215,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          _loanCard(
            bank: 'HDFC BANK',
            loanName: 'Personal Loan',
            outstanding: '₹2,84,500',
            emi: '₹12,850',
            progress: .42,
            color: red,
            icon: Icons.account_balance_rounded,
          ),

          const SizedBox(width: 12),

          _loanCard(
            bank: 'STATE BANK OF INDIA',
            loanName: 'Home Loan',
            outstanding: '₹18,42,000',
            emi: '₹24,600',
            progress: .68,
            color: blue,
            icon: Icons.home_work_outlined,
          ),
        ],
      ),
    );
  }

  Widget _loanCard({
    required String bank,
    required String loanName,
    required String outstanding,
    required String emi,
    required double progress,
    required Color color,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 290,
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(23),
          border: Border.all(color: border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .025),
              blurRadius: 16,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 43,
                  height: 43,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: .10),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 20,
                  ),
                ),

                const SizedBox(width: 11),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text:
                        loanName,
                        style: const TextStyle(
                          color: dark,
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        ),
                      ),

                      const SizedBox(height: 3),

                      CustomText(text:
                        bank,
                        style: const TextStyle(
                          color: secondary,
                          fontSize: 8,
                          fontWeight: FontWeight.w800,
                          letterSpacing: .3,
                        ),
                      ),
                    ],
                  ),
                ),

                const Icon(
                  Icons.more_horiz_rounded,
                  color: secondary,
                  size: 20,
                ),
              ],
            ),

            const SizedBox(height: 17),

            const CustomText(text:
              'Outstanding balance',
              style: TextStyle(
                color: secondary,
                fontSize: 9,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 3),

            CustomText(text:
              outstanding,
              style: const TextStyle(
                color: dark,
                fontSize: 21,
                fontWeight: FontWeight.w900,
                letterSpacing: -.5,
              ),
            ),

            const SizedBox(height: 13),

            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 6,
                      backgroundColor: const Color(0xFFEDF1EB),
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                    ),
                  ),
                ),

                const SizedBox(width: 9),

                CustomText(text:
                  '${(progress * 100).round()}%',
                  style: TextStyle(
                    color: color,
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                _smallLoanStat(
                  label: 'Monthly EMI',
                  value: emi,
                ),

                const Spacer(),

                _smallLoanStat(
                  label: 'Next due',
                  value: loanName == 'Personal Loan'
                      ? '18 Sep'
                      : '05 Oct',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _smallLoanStat({
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text:
          label,
          style: const TextStyle(
            color: secondary,
            fontSize: 8,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 3),

        CustomText(text:
          value,
          style: const TextStyle(
            color: dark,
            fontSize: 10,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // REPAYMENT CARD
  // ============================================================

  Widget _buildRepaymentCard() {
    return Container(
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: border),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 116,
            height: 116,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 108,
                  height: 108,
                  child: CircularProgressIndicator(
                    value: .56,
                    strokeWidth: 11,
                    strokeCap: StrokeCap.round,
                    backgroundColor: const Color(0xFFE9EFE6),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      green,
                    ),
                  ),
                ),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CustomText(text:
                      '56%',
                      style: TextStyle(
                        color: dark,
                        fontSize: 23,
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    const CustomText(text:
                      'repaid',
                      style: TextStyle(
                        color: secondary,
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              children: [
                _repaymentItem(
                  title: 'Principal paid',
                  value: '₹11,80,000',
                  color: greenDark,
                ),

                const SizedBox(height: 13),

                _repaymentItem(
                  title: 'Interest paid',
                  value: '₹3,24,500',
                  color: purple,
                ),

                const SizedBox(height: 13),

                _repaymentItem(
                  title: 'Remaining',
                  value: '₹9,46,500',
                  color: orange,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _repaymentItem({
    required String title,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),

        const SizedBox(width: 8),

        Expanded(
          child: CustomText(text:
            title,
            style: const TextStyle(
              color: secondary,
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        CustomText(text:
          value,
          style: const TextStyle(
            color: dark,
            fontSize: 10,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // RECENT ACTIVITY
  // ============================================================

  Widget _buildRecentActivity() {
    return Container(
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(color: border),
      ),
      child: Column(
        children: [
          _activityItem(
            icon: Icons.check_rounded,
            title: 'HDFC Personal Loan',
            subtitle: 'EMI payment completed',
            date: '18 Aug 2026',
            amount: '₹12,850',
            color: greenDark,
          ),

          _divider(),

          _activityItem(
            icon: Icons.check_rounded,
            title: 'SBI Home Loan',
            subtitle: 'EMI payment completed',
            date: '05 Aug 2026',
            amount: '₹24,600',
            color: blue,
          ),

          _divider(),

          _activityItem(
            icon: Icons.add_rounded,
            title: 'HDFC Personal Loan',
            subtitle: 'Loan added to account',
            date: '01 Aug 2026',
            amount: '₹3,50,000',
            color: purple,
          ),
        ],
      ),
    );
  }

  Widget _activityItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String date,
    required String amount,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withValues(alpha: .10),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: color,
              size: 19,
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
                    color: dark,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                const SizedBox(height: 4),

                CustomText(text:
                  subtitle,
                  style: const TextStyle(
                    color: secondary,
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 3),

                CustomText(text:
                  date,
                  style: const TextStyle(
                    color: secondary,
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          CustomText(text:
            amount,
            style: const TextStyle(
              color: dark,
              fontSize: 11,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return const Padding(
      padding: EdgeInsets.only(left: 69),
      child: Divider(
        height: 1,
        thickness: 1,
        color: border,
      ),
    );
  }

  // ============================================================
  // FLOATING ADD BUTTON
  // ============================================================

  Widget _buildFloatingButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: SizedBox(
        height: 54,
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: _showAddLoanSheet,
          style: ElevatedButton.styleFrom(
            backgroundColor: dark,
            foregroundColor: Colors.white,
            elevation: 10,
            shadowColor: dark.withValues(alpha: .25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          icon: const Icon(
            Icons.add_rounded,
            size: 20,
          ),
          label: const CustomText(text:
            'Add New Loan',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // ADD LOAN BOTTOM SHEET
  // ============================================================

  void _showAddLoanSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
            decoration: const BoxDecoration(
              color: background,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 42,
                    height: 5,
                    decoration: BoxDecoration(
                      color: border,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  const SizedBox(height: 22),

                  Row(
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: greenLight,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.account_balance_rounded,
                          color: greenDark,
                          size: 21,
                        ),
                      ),

                      const SizedBox(width: 12),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text:
                              'Add new loan',
                              style: TextStyle(
                                color: dark,
                                fontSize: 19,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(height: 3),
                            CustomText(text:
                              'Keep your repayment organized',
                              style: TextStyle(
                                color: secondary,
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      GestureDetector(
                        onTap: () => Navigator.pop(sheetContext),
                        child: Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: surface,
                            shape: BoxShape.circle,
                            border: Border.all(color: border),
                          ),
                          child: const Icon(
                            Icons.close_rounded,
                            color: secondary,
                            size: 17,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  _sheetInput(
                    icon: Icons.account_balance_outlined,
                    hint: 'Lender / Bank name',
                  ),

                  const SizedBox(height: 11),

                  _sheetInput(
                    icon: Icons.currency_rupee_rounded,
                    hint: 'Loan amount',
                    keyboardType: TextInputType.number,
                  ),

                  const SizedBox(height: 11),

                  Row(
                    children: [
                      Expanded(
                        child: _sheetInput(
                          icon: Icons.calendar_today_outlined,
                          hint: 'Start date',
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: _sheetInput(
                          icon: Icons.event_outlined,
                          hint: 'Due date',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 11),

                  Row(
                    children: [
                      Expanded(
                        child: _sheetInput(
                          icon: Icons.payments_outlined,
                          hint: 'Monthly EMI',
                          keyboardType: TextInputType.number,
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: _sheetInput(
                          icon: Icons.percent_rounded,
                          hint: 'Interest rate',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(sheetContext);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: greenDark,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                      ),
                      child: const CustomText(text:
                        'Save Loan',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _sheetInput({
    required IconData icon,
    required String hint,
    TextInputType? keyboardType,
  }) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: border),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: secondary,
            size: 18,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: TextField(
              keyboardType: keyboardType,
              style: const TextStyle(
                color: dark,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(
                  color: secondary,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}