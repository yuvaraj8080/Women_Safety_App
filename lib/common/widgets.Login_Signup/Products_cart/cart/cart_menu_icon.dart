// import 'package:ecommerceapp/features/shop/screens/cart/car.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
//
// import '../../../../utils/constants/colors.dart';
//
// class TCardCounterIcon extends StatelessWidget {
//   const TCardCounterIcon({
//     super.key,
//      this.iconColor = TColors.darkGrey,
//     required this.onPressed
//   });
//
//
//   final Color iconColor;
//   final VoidCallback onPressed;
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(children: [
//       IconButton(onPressed:()=> Get.to(()=> CartScreen()),
//           icon: Icon(Iconsax.shopping_bag, color:iconColor)),
//       Positioned(
//           right: 0,
//           child: Container(
//               width: 18,
//               height: 18,
//               decoration: BoxDecoration(
//                 color: TColors.black,
//                 borderRadius: BorderRadius.circular(100),
//               ),
//               child: Center(
//                 child: Text("2",
//                     style: Theme.of(context)
//                         .textTheme
//                         .labelLarge!
//                         .apply(
//                         color: TColors.white,
//                         fontSizeFactor: 0.8)),
//               )))
//     ]);
//   }
// }
