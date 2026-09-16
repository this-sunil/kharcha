import 'package:flutter/material.dart';

import '../core/util/CustomText.dart';

class ContactSupportScreen extends StatefulWidget {
  const ContactSupportScreen({super.key});

  @override
  State<ContactSupportScreen> createState() => _ContactSupportScreenState();
}

class _ContactSupportScreenState extends State<ContactSupportScreen> {
  static const Color primary = Color(0xFF176B5B);
  static const Color background = Color(0xFFF8FAF9);
  static const Color textPrimary = Color(0xFF17201D);
  static const Color secondaryText = Color(0xFF687570);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _subjectController = TextEditingController();

  final TextEditingController _messageController = TextEditingController();

  String selectedCategory = 'General';

  bool isSending = false;

  final List<String> categories = [
    'General',
    'Loan',
    'EMI / Repayment',
    'Payment',
    'Account',
    'Technical Issue',
  ];

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isSending = true;
    });

    // TODO: Replace this with your API call.
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    setState(() {
      isSending = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        content: const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: Colors.white),
            SizedBox(width: 10),
            Expanded(child: CustomText(text:'Support request sent successfully.')),
          ],
        ),
      ),
    );

    _subjectController.clear();
    _messageController.clear();

    setState(() {
      selectedCategory = 'General';
    });
  }

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
          'Contact Support',
          style: TextStyle(
            color: textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 35),
          children: [
            _buildHeader(),

            const SizedBox(height: 24),

            const CustomText(text:
              'Support category',
              style: TextStyle(
                color: textPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 9),

            _buildCategoryDropdown(),

            const SizedBox(height: 20),

            _label('Subject'),

            const SizedBox(height: 9),

            TextFormField(
              controller: _subjectController,
              textInputAction: TextInputAction.next,
              decoration: _inputDecoration(
                hint: 'Enter your subject',
                icon: Icons.subject_rounded,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a subject';
                }

                return null;
              },
            ),

            const SizedBox(height: 20),

            _label('Message'),

            const SizedBox(height: 9),

            TextFormField(
              controller: _messageController,
              minLines: 5,
              maxLines: 7,
              decoration: _inputDecoration(
                hint: 'Describe your issue or question...',
                icon: Icons.chat_bubble_outline_rounded,
                topIcon: true,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please describe your issue';
                }

                if (value.trim().length < 10) {
                  return 'Please provide more details';
                }

                return null;
              },
            ),

            const SizedBox(height: 22),

            _buildSupportInfo(),

            const SizedBox(height: 24),

            SizedBox(
              height: 55,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isSending ? null : _sendMessage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: primary.withValues(alpha: 0.5),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                ),
                child: isSending
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.3,
                          color: Colors.white,
                        ),
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.send_rounded, size: 19),
                          SizedBox(width: 9),
                          CustomText(text:
                            'Send Request',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
              ),
            ),

            const SizedBox(height: 14),

            const Center(
              child: CustomText(text:
                'We usually respond within 1–2 business days.',
                style: TextStyle(color: secondaryText, fontSize: 10.5),
              ),
            ),
          ],
        ),
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
      child: const Row(
        children: [
          CircleAvatar(
            radius: 27,
            backgroundColor: primary,
            child: Icon(
              Icons.support_agent_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text:
                  'Need assistance?',
                  style: TextStyle(
                    color: textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 5),
                CustomText(text:
                  'Tell us what happened and our team will help you.',
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

  Widget _buildCategoryDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFE2E8E5)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCategory,
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: secondaryText,
          ),
          items: categories.map((category) {
            return DropdownMenuItem<String>(
              value: category,
              child: CustomText(text:
                category,
                style: const TextStyle(color: textPrimary, fontSize: 13),
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value == null) return;

            setState(() {
              selectedCategory = value;
            });
          },
        ),
      ),
    );
  }

  Widget _buildSupportInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF3F0),
        borderRadius: BorderRadius.circular(17),
      ),
      child: const Column(
        children: [
          Row(
            children: [
              Icon(Icons.schedule_rounded, color: primary, size: 19),
              SizedBox(width: 10),
              Expanded(
                child: CustomText(text:
                  'Support hours: Monday – Friday, 9:00 AM – 6:00 PM',
                  style: TextStyle(color: secondaryText, fontSize: 11.5),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.email_outlined, color: primary, size: 19),
              SizedBox(width: 10),
              Expanded(
                child: CustomText(text:
                  'support@kharcha.app',
                  style: TextStyle(color: secondaryText, fontSize: 11.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _label(String text) {
    return CustomText(text:
      text,
      style: const TextStyle(
        color: textPrimary,
        fontSize: 13,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    bool topIcon = false,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 13),
      prefixIcon: Padding(
        padding: EdgeInsets.only(top: topIcon ? 14 : 0),
        child: Icon(icon, color: Colors.grey.shade600, size: 20),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xFFE2E8E5)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xFFE2E8E5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: primary, width: 1.4),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.4),
      ),
    );
  }
}
