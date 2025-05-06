import 'package:flutter/material.dart';
import 'package:freshkart/core/utils/colors.dart';
import 'package:freshkart/view_model/providers/notification_provider.dart';
import 'package:provider/provider.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        final RenderBox button = context.findRenderObject() as RenderBox;
        final Offset position = button.localToGlobal(Offset.zero);

        final notifications =
            context.read<NotificationProvider>().notifications;
        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(
            position.dx + button.size.width,
            position.dy + button.size.height,
            0,
            0,
          ),
          items:
              notifications.map((notification) {
                return PopupMenuItem(
                  enabled: false,
                  child: Container(
                    width: 250,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification['title'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.greenColor,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(notification['message']),
                      ],
                    ),
                  ),
                );
              }).toList(),
        );
      },
      icon: Icon(
        Icons.notifications_sharp,
        color: AppColors.notificationIconColor,
      ),
    );
  }
}
