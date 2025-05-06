import 'package:flutter/material.dart';
import 'package:freshkart/core/utils/colors.dart';
import 'package:freshkart/view/widgets/home_section/notification_button.dart';
import 'package:freshkart/view_model/providers/auth/location_provider.dart';
import 'package:freshkart/view_model/services/user_services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TopSection extends StatefulWidget {
  const TopSection({super.key});

  @override
  State<TopSection> createState() => _TopSectionState();
}

class _TopSectionState extends State<TopSection> {
  @override
  void initState() {
    if (UserServices.currentUser != null &&
        UserServices.currentUser!.location == 'Unknown') {
      context.read<LocationProvider>().getLocation(context);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = UserServices.currentUser;
    final userPhoto = UserServices.user?.photoURL;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 23,
                backgroundColor: Colors.grey[200],
                backgroundImage:
                    userPhoto != null ? NetworkImage(userPhoto) : null,
                child:
                    userPhoto == null
                        ? const Icon(Icons.person, color: Colors.grey)
                        : null,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'helo, ',
                          style: GoogleFonts.aBeeZee(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        TextSpan(
                          text: user?.name.split(' ').first ?? 'User',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.greenColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Consumer<LocationProvider>(
                        builder: (context, value, _) {
                          return Text(
                            value.isLoading
                                ? 'Searching Location...'
                                : user?.location ?? 'Unknown location',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: () {
                          context.read<LocationProvider>().getLocation(context);
                        },
                        child: const Icon(Icons.refresh, size: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const NotificationButton(),
        ],
      ),
    );
  }
}
