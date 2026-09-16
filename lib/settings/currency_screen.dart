import 'package:flutter/material.dart';

import '../core/util/CustomText.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  final TextEditingController _searchController = TextEditingController();

  String selectedCurrency = 'INR';

  final List<Map<String, String>> currencies = [
    {'code': 'INR', 'name': 'Indian Rupee', 'symbol': '₹', 'country': 'India'},
    {
      'code': 'USD',
      'name': 'US Dollar',
      'symbol': '\$',
      'country': 'United States',
    },
    {'code': 'EUR', 'name': 'Euro', 'symbol': '€', 'country': 'European Union'},
    {
      'code': 'GBP',
      'name': 'British Pound',
      'symbol': '£',
      'country': 'United Kingdom',
    },
    {
      'code': 'AED',
      'name': 'UAE Dirham',
      'symbol': 'د.إ',
      'country': 'United Arab Emirates',
    },
    {
      'code': 'CAD',
      'name': 'Canadian Dollar',
      'symbol': 'C\$',
      'country': 'Canada',
    },
    {
      'code': 'AUD',
      'name': 'Australian Dollar',
      'symbol': 'A\$',
      'country': 'Australia',
    },
    {
      'code': 'SGD',
      'name': 'Singapore Dollar',
      'symbol': 'S\$',
      'country': 'Singapore',
    },
    {'code': 'JPY', 'name': 'Japanese Yen', 'symbol': '¥', 'country': 'Japan'},
    {
      'code': 'CHF',
      'name': 'Swiss Franc',
      'symbol': 'CHF',
      'country': 'Switzerland',
    },
  ];

  List<Map<String, String>> get filteredCurrencies {
    final query = _searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      return currencies;
    }

    return currencies.where((currency) {
      return currency['code']!.toLowerCase().contains(query) ||
          currency['name']!.toLowerCase().contains(query) ||
          currency['country']!.toLowerCase().contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _selectCurrency(String code) {
    setState(() {
      selectedCurrency = code;
    });
  }

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF176B5B);
    const background = Color(0xFFF8FAF9);
    const textPrimary = Color(0xFF17201D);
    const secondaryText = Color(0xFF687570);

    final selected = currencies.firstWhere(
      (currency) => currency['code'] == selectedCurrency,
    );

    return Scaffold(
      backgroundColor: background,

      appBar: AppBar(
        backgroundColor: background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,

        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_rounded, color: textPrimary),
          ),
        ),

        title: const CustomText(text:
          'Currency',
          style: TextStyle(
            color: textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),

        centerTitle: false,
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
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
                            Icons.currency_exchange_rounded,
                            color: Colors.white,
                            size: 27,
                          ),
                        ),

                        const SizedBox(width: 15),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(text:
                                'Default Currency',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: textPrimary,
                                ),
                              ),

                              const SizedBox(height: 5),

                              CustomText(text:
                                '${selected['name']} (${selected['symbol']})',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: secondaryText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Search
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: const Color(0xFFE2E8E5)),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (_) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        hintText: 'Search currency',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: Colors.grey.shade600,
                          size: 21,
                        ),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {});
                                },
                                icon: const Icon(Icons.close_rounded, size: 19),
                              )
                            : null,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 26),

                  const CustomText(text:
                    'Choose currency',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: textPrimary,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Currency list
                  ...filteredCurrencies.map(
                    (currency) => _buildCurrencyTile(
                      currency: currency,
                      isSelected: currency['code'] == selectedCurrency,
                      onTap: () => _selectCurrency(currency['code']!),
                    ),
                  ),

                  if (filteredCurrencies.isEmpty) _buildEmptyState(),
                ],
              ),
            ),

            // Bottom button
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 18),
              decoration: BoxDecoration(
                color: background,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 15,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, selectedCurrency);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                  ),
                  child: const CustomText(text:
                    'Save Currency',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencyTile({
    required Map<String, String> currency,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    const primary = Color(0xFF176B5B);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(17),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFEAF5F1) : Colors.white,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(
                color: isSelected ? primary : const Color(0xFFE5EBE8),
                width: isSelected ? 1.4 : 1,
              ),
            ),
            child: Row(
              children: [
                // Currency symbol
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isSelected ? primary : const Color(0xFFF2F5F3),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  alignment: Alignment.center,
                  child: CustomText(text:
                    currency['symbol']!,
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF34413D),
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                // Currency information
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text:
                        currency['name']!,
                        style: const TextStyle(
                          color: Color(0xFF17201D),
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      CustomText(text:
                        '${currency['code']} • ${currency['country']}',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                // Selected indicator
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? primary : Colors.transparent,
                    border: Border.all(
                      color: isSelected ? primary : Colors.grey.shade300,
                      width: 1.5,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 16,
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF1EE),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.search_off_rounded,
              size: 30,
              color: Color(0xFF687570),
            ),
          ),
          const SizedBox(height: 14),
          const CustomText(text:
            'Currency not found',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF17201D),
            ),
          ),
          const SizedBox(height: 5),
          CustomText(text:
            'Try searching by currency name or code.',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
