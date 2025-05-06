// import 'package:flutter/material.dart';
// import 'package:freshkart/main.dart';
// import 'package:freshkart/view_model/providers/auth_provider.dart';
// import 'package:freshkart/view_model/providers/location_provider.dart';
// import 'package:freshkart/core/utils/colors.dart';
// import 'package:freshkart/core/utils/images.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';

// class LocationScreen extends StatelessWidget {
//   const LocationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<LocationProvider>();

//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 35),
//         child: Column(
//           spacing: 30,
//           children: [
//             SizedBox(height: MediaQuery.of(context).size.height * 0.1),
//             SizedBox(
//               width: 150,
//               height: 150,
//               child: Image.asset(AppImages.locationImage),
//             ),
//             const Text(
//               'Your location?',
//               style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
//             ),

//             Container(
//               padding: const EdgeInsets.all(17),
//               width: MediaQuery.of(context).size.width * 0.8,
//               decoration: BoxDecoration(
//                 border: Border.all(),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Consumer<LocationProvider>(
//                 builder: (context, value, child) {
//                   if (value.isLoading == true) {
//                     return Center(
//                       child: SizedBox(
//                         width: 15,
//                         height: 15,
//                         child: CircularProgressIndicator(
//                           strokeWidth: 2,
//                           color: AppColors.greenColor,
//                         ),
//                       ),
//                     );
//                   } else {
//                     return Text(value.userLocation ?? 'Unknown location');
//                   }
//                 },
//               ),
//             ),

//             Align(
//               alignment: Alignment.center,
//               child: IconButton(
//                 onPressed:
//                     () => context.read<LocationProvider>().getLocation(context),
//                 icon: const Icon(Icons.refresh),
//               ),
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height * 0.15),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 InkWell(
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 19,
//                       vertical: 14,
//                     ),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                     ),

//                     child: const Text('Skip', style: TextStyle(fontSize: 15)),
//                   ),
//                   onTap: () {
//                     context.read<AuthenticatioProvider>().saveUserData(
//                       provider.userLocation ?? 'Unknown location',
//                     );
//                     context.go(Routes.landing);
//                   },
//                 ),
//                 InkWell(
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 12,
//                       horizontal: 20,
//                     ),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: AppColors.greenColor),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Text(
//                       'Get started',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: AppColors.greenColor,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ),
//                   onTap: () {
//                     if (provider.userLocation != null) {
//                       context.read<AuthenticatioProvider>().saveUserData(
//                         provider.userLocation ?? '',
//                       );
//                       context.go(Routes.landing);
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
