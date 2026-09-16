import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:kharcha/core/util/CustomAnimation.dart';
import '../../../../core/util/CustomText.dart';

class InsightPage extends StatefulWidget {
  const InsightPage({super.key});

  @override
  State<InsightPage> createState() => _InsightPageState();
}

class _InsightPageState extends State<InsightPage> {
  int selectedPeriod = 0;

  // ============================================================
  // COLORS
  // ============================================================

  final Color background = const Color(0xFFF5F8F3);
  final Color card = const Color(0xFFFFFFFF);
  final Color cardLight = const Color(0xFFF0F5EE);

  final Color green = const Color(0xFF8BCF3F);
  final Color greenDark = const Color(0xFF65A52A);

  final Color primaryText = const Color(0xFF172016);
  final Color secondaryText = const Color(0xFF687267);
  final Color borderColor = const Color(0xFFE1E9DE);

  final Color expenseColor = const Color(0xFFE45564);
  final Color blueColor = const Color(0xFF559BEE);
  final Color purpleColor = const Color(0xFF9477E8);
  final Color orangeColor = const Color(0xFFF2A94A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Stack(
        children: [
          _buildBackgroundGlow(),

          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    20,
                    20,
                    40,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        _header(),

                        const SizedBox(height: 24),

                        _loanHealthCard(),

                        const SizedBox(height: 26),

                        _sectionTitle(
                          'Loan analytics',
                          'Monthly overview',
                        ),

                        const SizedBox(height: 14),

                        _loanChart(),

                        const SizedBox(height: 28),

                        _sectionTitle(
                          'Your loan portfolio',
                          'Current loans',
                        ),

                        const SizedBox(height: 14),

                        _loanBreakdown(),

                        const SizedBox(height: 28),

                        _sectionTitle(
                          'Loan insights',
                          'Smart analysis',
                        ),

                        const SizedBox(height: 14),

                        _insightCards(),

                        const SizedBox(height: 28),

                        _sectionTitle(
                          'Repayment comparison',
                          'Last 6 months',
                        ),

                        const SizedBox(height: 14),

                        _monthlyComparison(),
                      ],
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

  // ============================================================
  // BACKGROUND GLOW
  // ============================================================

  Widget _buildBackgroundGlow() {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: green.withValues(alpha: .10),
                    blurRadius: 140,
                    spreadRadius: 35,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 430,
            left: -150,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFB9E68B).withValues(alpha: .10),
                    blurRadius: 120,
                    spreadRadius: 30,
                  ),
                ],
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
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: borderColor,
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
            Icons.account_balance_rounded,
            color: greenDark,
            size: 23,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              CustomText(text:
                'Your borrowing',
                style: TextStyle(
                  color: Color(0xFF687267),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 3),
              CustomText(text:
                'Loan Insights',
                style: TextStyle(
                  color: Color(0xFF172016),
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),

        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: borderColor,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            Icons.notifications_none_rounded,
            color: secondaryText,
            size: 20,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // LOAN HEALTH
  // ============================================================

  Widget _loanHealthCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFEAF8D9),
            Color(0xFFDFF2C9),
            Color(0xFFF5F9F1),
          ],
        ),
        border: Border.all(
          color: Color(0xFFCDE5B5),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF8BCF3F).withValues(alpha: .11),
            blurRadius: 30,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: CustomText(text:
                  'Loan repayment health',
                  style: TextStyle(
                    color: Color(0xFF172016),
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF8BCF3F).withValues(alpha: .14),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const CustomText(text:
                  'Excellent',
                  style: TextStyle(
                    color: Color(0xFF65A52A),
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 108,
                height: 108,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 108,
                      height: 108,
                      child: CircularProgressIndicator(
                        value: .78,
                        strokeWidth: 9,
                        backgroundColor:
                        const Color(0xFFBFD5AE).withValues(alpha: .35),
                        valueColor:
                        AlwaysStoppedAnimation<Color>(greenDark),
                      ),
                    ),

                    const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomAnimation(amount:
                          78,
                          style: TextStyle(
                            color: Color(0xFF172016),
                            fontSize: 29,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        CustomText(text:
                          '/ 100',
                          style: TextStyle(
                            color: Color(0xFF788377),
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 22),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _healthRow(
                      'Repayment rate',
                      '82%',
                      greenDark,
                    ),

                    const SizedBox(height: 13),

                    _healthRow(
                      'EMI discipline',
                      'Good',
                      blueColor,
                    ),

                    const SizedBox(height: 13),

                    _healthRow(
                      'Loan cleared',
                      '42%',
                      orangeColor,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .60),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFD6E7C8),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: green.withValues(alpha: .14),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.account_balance_wallet_rounded,
                    color: greenDark,
                    size: 19,
                  ),
                ),

                const SizedBox(width: 11),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      CustomText(text:
                        'Outstanding balance',
                        style: TextStyle(
                          color: Color(0xFF687267),
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 3),
                      CustomAnimation(amount:
                        68420,
                        style: TextStyle(
                          color: Color(0xFF172016),
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),

                const CustomText(text:
                  '₹12,580 paid',
                  style: TextStyle(
                    color: Color(0xFF65A52A),
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _healthRow(
      String title,
      String value,
      Color color,
      ) {
    return Row(
      children: [
        Container(
          width: 7,
          height: 7,
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
              color: Color(0xFF687267),
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        CustomText(text:
          value,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SECTION TITLE
  // ============================================================

  Widget _sectionTitle(
      String title,
      String subtitle,
      ) {
    return Row(
      children: [
        Expanded(
          child: CustomText(text:
            title,
            style: const TextStyle(
              color: Color(0xFF172016),
              fontSize: 17,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),

        CustomText(text:
          subtitle,
          style: const TextStyle(
            color: Color(0xFF7B8679),
            fontSize: 9,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // LOAN CHART
  // ============================================================

  Widget _loanChart() {
    return Container(
      height: 310,
      padding: const EdgeInsets.fromLTRB(
        16,
        18,
        18,
        12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: borderColor,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .035),
            blurRadius: 20,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text:
                    '₹12,580',
                    style: TextStyle(
                      color: Color(0xFF172016),
                      fontSize: 23,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  SizedBox(height: 3),

                  CustomText(text:
                    'Total repayments',
                    style: TextStyle(
                      color: Color(0xFF7B8679),
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: cardLight,
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(
                    color: borderColor,
                  ),
                ),
                child: Row(
                  children: [
                    _period('7D', 0),
                    _period('30D', 1),
                    _period('6M', 2),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Expanded(
            child: LineChart(
              _lineChartData(),
              duration: const Duration(
                milliseconds: 500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  LineChartData _lineChartData() {
    return LineChartData(
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: 7000,

      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 2000,
        getDrawingHorizontalLine: (_) {
          return const FlLine(
            color: Color(0xFFE7EEE4),
            strokeWidth: 1,
          );
        },
      ),

      borderData: FlBorderData(
        show: false,
      ),

      titlesData: FlTitlesData(
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),

        rightTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),

        topTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),

        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 25,
            getTitlesWidget: (value, meta) {
              const labels = [
                'Mon',
                'Tue',
                'Wed',
                'Thu',
                'Fri',
                'Sat',
                'Sun',
              ];

              final index = value.toInt();

              if (index < 0 || index >= labels.length) {
                return const SizedBox();
              }

              return Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                ),
                child: CustomText(text:
                  labels[index],
                  style: const TextStyle(
                    color: Color(0xFF788377),
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
          ),
        ),
      ),

      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (_) {
            return const Color(0xFF172016);
          },

          tooltipBorderRadius: BorderRadius.circular(10),

          getTooltipItems: (spots) {
            return spots.map(
                  (spot) {
                return LineTooltipItem(
                  '₹${spot.y.toInt()}',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 11,
                  ),
                );
              },
            ).toList();
          },
        ),
      ),

      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 1800),
            FlSpot(1, 3200),
            FlSpot(2, 2600),
            FlSpot(3, 4200),
            FlSpot(4, 3600),
            FlSpot(5, 5200),
            FlSpot(6, 3900),
          ],

          isCurved: true,
          curveSmoothness: .3,
          barWidth: 3,
          color: Color(0xFF8BCF3F),
          isStrokeCapRound: true,

          dotData: const FlDotData(
            show: false,
          ),

          belowBarData: BarAreaData(
            show: true,
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0x338BCF3F),
                Color(0x008BCF3F),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // PERIOD
  // ============================================================

  Widget _period(
      String text,
      int index,
      ) {
    final selected = selectedPeriod == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPeriod = index;
        });
      },

      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 200,
        ),

        padding: const EdgeInsets.symmetric(
          horizontal: 9,
          vertical: 6,
        ),

        decoration: BoxDecoration(
          color: selected
              ? green.withValues(alpha: .14)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),

        child: CustomText(text:
          text,
          style: TextStyle(
            color: selected
                ? greenDark
                : const Color(0xFF788377),
            fontSize: 9,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // LOAN BREAKDOWN
  // ============================================================

  Widget _loanBreakdown() {
    final loans = [
      _LoanData(
        name: 'Personal Loan',
        amount: '₹42,500',
        percentage: 62,
        icon: Icons.person_rounded,
        color: purpleColor,
      ),

      _LoanData(
        name: 'Home Loan',
        amount: '₹18,200',
        percentage: 27,
        icon: Icons.home_rounded,
        color: blueColor,
      ),

      _LoanData(
        name: 'Vehicle Loan',
        amount: '₹7,720',
        percentage: 11,
        icon: Icons.directions_car_filled_rounded,
        color: orangeColor,
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: borderColor,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .03),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          for (int i = 0; i < loans.length; i++) ...[
            _loanRow(loans[i]),

            if (i != loans.length - 1)
              const SizedBox(height: 20),
          ],
        ],
      ),
    );
  }

  Widget _loanRow(
      _LoanData loan,
      ) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: loan.color.withValues(alpha: .10),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(
            loan.icon,
            color: loan.color,
            size: 19,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomText(text:
                    loan.name,
                    style: const TextStyle(
                      color: Color(0xFF172016),
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const Spacer(),

                  CustomText(text:
                    loan.amount,
                    style: const TextStyle(
                      color: Color(0xFF172016),
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: loan.percentage / 100,
                  minHeight: 5,
                  backgroundColor: const Color(0xFFEAF0E7),
                  valueColor:
                  AlwaysStoppedAnimation<Color>(loan.color),
                ),
              ),

              const SizedBox(height: 5),

              CustomText(text:
                '${loan.percentage}% of outstanding balance',
                style: const TextStyle(
                  color: Color(0xFF8A9488),
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // INSIGHTS
  // ============================================================

  Widget _insightCards() {
    return Column(
      children: [
        _insight(
          icon: Icons.trending_down_rounded,
          title: 'Your loan balance is decreasing',
          description:
          'Your outstanding balance reduced by 8.6% compared with last month.',
          color: greenDark,
        ),

        const SizedBox(height: 10),

        _insight(
          icon: Icons.payments_rounded,
          title: 'Repayment is on track',
          description:
          'You paid ₹12,580 toward your loans this month.',
          color: blueColor,
        ),

        const SizedBox(height: 10),

        _insight(
          icon: Icons.event_available_rounded,
          title: 'Next EMI is approaching',
          description:
          'Your upcoming EMI of ₹6,420 is scheduled for 15 Sep.',
          color: orangeColor,
        ),

        const SizedBox(height: 10),

        _insight(
          icon: Icons.check_circle_rounded,
          title: 'One loan is nearly complete',
          description:
          'Your vehicle loan is 82% repaid. Keep going.',
          color: purpleColor,
        ),
      ],
    );
  }

  Widget _insight({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: borderColor,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .025),
            blurRadius: 14,
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
              color: color.withValues(alpha: .10),
              borderRadius: BorderRadius.circular(14),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text:
                  title,
                  style: const TextStyle(
                    color: Color(0xFF172016),
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                const SizedBox(height: 4),

                CustomText(text:
                  description,
                  style: const TextStyle(
                    color: Color(0xFF788377),
                    fontSize: 9,
                    height: 1.4,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          const Icon(
            Icons.chevron_right_rounded,
            color: Color(0xFFA0AAA0),
            size: 20,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MONTHLY COMPARISON
  // ============================================================

  Widget _monthlyComparison() {
    return Container(
      height: 260,
      padding: const EdgeInsets.fromLTRB(
        14,
        18,
        18,
        12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: borderColor,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .03),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _legend(
                color: greenDark,
                label: 'Repaid',
              ),

              const SizedBox(width: 16),

              _legend(
                color: expenseColor,
                label: 'Outstanding',
              ),
            ],
          ),

          const SizedBox(height: 10),

          Expanded(
            child: BarChart(
              _barChartData(),
              duration: const Duration(
                milliseconds: 500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _legend({
    required Color color,
    required String label,
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

        const SizedBox(width: 6),

        CustomText(text:
          label,
          style: const TextStyle(
            color: Color(0xFF687267),
            fontSize: 9,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  BarChartData _barChartData() {
    return BarChartData(
      maxY: 90000,
      minY: 0,

      alignment: BarChartAlignment.spaceAround,

      groupsSpace: 12,

      borderData: FlBorderData(
        show: false,
      ),

      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 30000,
        getDrawingHorizontalLine: (_) {
          return const FlLine(
            color: Color(0xFFE7EEE4),
            strokeWidth: 1,
          );
        },
      ),

      titlesData: FlTitlesData(
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),

        rightTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),

        topTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),

        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 24,
            getTitlesWidget: (value, meta) {
              const months = [
                'Apr',
                'May',
                'Jun',
                'Jul',
                'Aug',
                'Sep',
              ];

              final index = value.toInt();

              if (index < 0 || index >= months.length) {
                return const SizedBox();
              }

              return Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                ),
                child: CustomText(text:
                  months[index],
                  style: const TextStyle(
                    color: Color(0xFF788377),
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
          ),
        ),
      ),

      barGroups: [
        _bar(0, 18000, 72000),
        _bar(1, 24000, 68000),
        _bar(2, 31000, 59000),
        _bar(3, 36000, 51000),
        _bar(4, 42000, 43000),
        _bar(5, 48500, 34200),
      ],
    );
  }

  BarChartGroupData _bar(
      int x,
      double repaid,
      double outstanding,
      ) {
    return BarChartGroupData(
      x: x,

      barsSpace: 5,

      barRods: [
        BarChartRodData(
          toY: repaid,
          width: 7,
          borderRadius: BorderRadius.circular(5),
          color: greenDark,
        ),

        BarChartRodData(
          toY: outstanding,
          width: 7,
          borderRadius: BorderRadius.circular(5),
          color: expenseColor,
        ),
      ],
    );
  }
}

// ============================================================
// LOAN MODEL
// ============================================================

class _LoanData {
  final String name;
  final String amount;
  final double percentage;
  final IconData icon;
  final Color color;

  const _LoanData({
    required this.name,
    required this.amount,
    required this.percentage,
    required this.icon,
    required this.color,
  });
}