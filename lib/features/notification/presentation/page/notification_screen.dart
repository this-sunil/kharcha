import 'package:flutter/material.dart';

import '../../../../core/util/CustomText.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<Map<String, dynamic>> notifications = [
    {
      'type': 'emi',
      'title': 'EMI payment due soon',
      'message': 'Your Home Loan EMI of ₹12,500 is due in 3 days.',
      'time': '10 min ago',
      'isRead': false,
      'icon': Icons.calendar_month_rounded,
    },
    {
      'type': 'payment',
      'title': 'Payment successful',
      'message': 'Your payment of ₹5,000 has been successfully recorded.',
      'time': '1 hour ago',
      'isRead': false,
      'icon': Icons.check_circle_rounded,
    },
    {
      'type': 'loan',
      'title': 'Loan updated',
      'message': 'Your Personal Loan balance has been updated to ₹85,000.',
      'time': '3 hours ago',
      'isRead': true,
      'icon': Icons.account_balance_rounded,
    },
    {
      'type': 'expense',
      'title': 'Spending alert',
      'message': 'You have spent 82% of your monthly food budget.',
      'time': 'Yesterday',
      'isRead': true,
      'icon': Icons.trending_up_rounded,
    },
    {
      'type': 'security',
      'title': 'Security alert',
      'message': 'Your account password was changed successfully.',
      'time': 'Yesterday',
      'isRead': true,
      'icon': Icons.security_rounded,
    },
    {
      'type': 'reminder',
      'title': 'EMI reminder',
      'message': 'Don\'t forget to pay your Car Loan EMI this month.',
      'time': '2 days ago',
      'isRead': true,
      'icon': Icons.notifications_active_rounded,
    },
  ];

  String selectedFilter = 'All';

  final List<String> filters = ['All', 'Loans', 'Payments', 'Alerts'];

  List<Map<String, dynamic>> get filteredNotifications {
    if (selectedFilter == 'All') {
      return notifications;
    }

    return notifications.where((notification) {
      final type = notification['type'];

      if (selectedFilter == 'Loans') {
        return type == 'loan' || type == 'emi' || type == 'reminder';
      }

      if (selectedFilter == 'Payments') {
        return type == 'payment';
      }

      if (selectedFilter == 'Alerts') {
        return type == 'expense' || type == 'security';
      }

      return true;
    }).toList();
  }

  int get unreadCount {
    return notifications
        .where((notification) => notification['isRead'] == false)
        .length;
  }

  void _markAllAsRead() {
    setState(() {
      for (final notification in notifications) {
        notification['isRead'] = true;
      }
    });
  }

  void _markAsRead(int index) {
    setState(() {
      filteredNotifications[index]['isRead'] = true;
    });
  }

  void _deleteNotification(int index) {
    final notification = filteredNotifications[index];

    setState(() {
      notifications.remove(notification);
    });
  }

  @override
  Widget build(BuildContext context) {
    const background = Color(0xFFF8FAF9);
    const primary = Color(0xFF176B5B);
    const textPrimary = Color(0xFF17201D);
    const secondaryText = Color(0xFF687570);

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
          'Notifications',
          style: TextStyle(
            color: textPrimary,
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        ),

        actions: [
          if (unreadCount > 0)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: TextButton(
                onPressed: _markAllAsRead,
                child: const CustomText(text:
                  'Mark all read',
                  style: TextStyle(
                    color: primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
        ],
      ),

      body: SafeArea(
        child: Column(
          children: [
            // Notification summary
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 18),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFE8F5F1), Color(0xFFF5FAF8)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFDDECE7)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.notifications_rounded,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text:
                            unreadCount == 0
                                ? 'You\'re all caught up'
                                : '$unreadCount unread notification${unreadCount == 1 ? '' : 's'}',
                            style: const TextStyle(
                              color: textPrimary,
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const CustomText(text:
                            'Stay updated with your finances',
                            style: TextStyle(
                              color: secondaryText,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Filters
            SizedBox(
              height: 42,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final filter = filters[index];
                  final selected = selectedFilter == filter;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(horizontal: 17),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selected ? primary : Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: selected ? primary : const Color(0xFFE1E7E4),
                        ),
                      ),
                      child: CustomText(text:
                        filter,
                        style: TextStyle(
                          color: selected ? Colors.white : textPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 18),

            // Notifications
            Expanded(
              child: filteredNotifications.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                      itemCount: filteredNotifications.length,
                      itemBuilder: (context, index) {
                        final notification = filteredNotifications[index];

                        return _buildNotificationCard(notification, index);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification, int index) {
    final bool isRead = notification['isRead'];

    Color iconBackground;
    Color iconColor;

    switch (notification['type']) {
      case 'emi':
      case 'reminder':
        iconBackground = const Color(0xFFFFF3DC);
        iconColor = const Color(0xFFB77900);
        break;

      case 'payment':
        iconBackground = const Color(0xFFE7F6EF);
        iconColor = const Color(0xFF16805E);
        break;

      case 'loan':
        iconBackground = const Color(0xFFE9F0FF);
        iconColor = const Color(0xFF4169A8);
        break;

      case 'expense':
        iconBackground = const Color(0xFFFFECE8);
        iconColor = const Color(0xFFD15B43);
        break;

      case 'security':
        iconBackground = const Color(0xFFF0EAFE);
        iconColor = const Color(0xFF7351B8);
        break;

      default:
        iconBackground = const Color(0xFFEAF2EF);
        iconColor = const Color(0xFF176B5B);
    }

    return Dismissible(
      key: ValueKey('${notification['title']}_${notification['time']}'),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        _deleteNotification(index);
      },
      background: Container(
        margin: const EdgeInsets.only(bottom: 10),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 22),
        decoration: BoxDecoration(
          color: const Color(0xFFFFE9E6),
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Icon(
          Icons.delete_outline_rounded,
          color: Colors.redAccent,
        ),
      ),

      child: GestureDetector(
        onTap: () => _markAsRead(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: isRead ? Colors.white : const Color(0xFFF0F8F5),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isRead ? const Color(0xFFE5EBE8) : const Color(0xFFD5E9E1),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(notification['icon'], color: iconColor, size: 22),
              ),

              const SizedBox(width: 13),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CustomText(text:
                            notification['title'],
                            style: const TextStyle(
                              color: Color(0xFF17201D),
                              fontSize: 13.5,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),

                        if (!isRead)
                          Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.only(top: 5, left: 8),
                            decoration: const BoxDecoration(
                              color: Color(0xFF176B5B),
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    CustomText(text:
                      notification['message'],
                      style: const TextStyle(
                        color: Color(0xFF687570),
                        fontSize: 11.5,
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 8),

                    CustomText(text:
                      notification['time'],
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF2EF),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.notifications_none_rounded,
                size: 38,
                color: Color(0xFF176B5B),
              ),
            ),

            const SizedBox(height: 18),

            const CustomText(text:
              'No notifications',
              style: TextStyle(
                color: Color(0xFF17201D),
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 6),

            CustomText(text:
              'You\'re all caught up for now.',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
