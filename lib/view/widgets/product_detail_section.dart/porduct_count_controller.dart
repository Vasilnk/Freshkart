// import 'package:flutter/material.dart';
// import 'package:freshkart/core/utils/colors.dart';

// class PorductCountController extends StatefulWidget {
//   const PorductCountController({super.key});

//   @override
//   State<PorductCountController> createState() => _PorductCountControllerState();
// }

// class _PorductCountControllerState extends State<PorductCountController> {
//   int productCount = 1;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       spacing: 15,
//       children: [
//         InkWell(
//           onTap: () {
//             if (productCount > 1) {
//               setState(() {
//                 productCount--;
//               });
//             }
//           },
//           child: const Icon(Icons.remove),
//         ),
//         Container(
//           padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: const Color.fromARGB(255, 204, 201, 201),
//               width: 2,
//             ),
//             borderRadius: BorderRadius.circular(11),
//           ),
//           child: Text(
//             productCount.toString(),
//             style: const TextStyle(fontWeight: FontWeight.bold),
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             setState(() {
//               productCount++;
//             });
//           },
//           child: Icon(Icons.add, color: AppColors.greenColor),
//         ),
//       ],
//     );
//   }
// }
