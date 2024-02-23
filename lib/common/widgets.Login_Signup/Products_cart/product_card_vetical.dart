// import 'package:flutter/material.dart';
// import 'package:flutter_women_safety_app/common/widgets.Login_Signup/Products_cart/product_price_text.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
//
// import '../../../utils/constants/colors.dart';
// import '../../../utils/halpers/helper_function.dart';
// import '../images/t_Rounded_image.dart';
// import '../texts/product_title_text.dart';
//
// import '../../../common/shadow.dart';
// import '../texts/t_brand_title_and_verify.dart';
//
// class TProductCardVertical extends StatelessWidget {
//   const TProductCardVertical({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final dark = THelperFunction.isDarkMode(context);
//
//     return Card(
//       elevation:3,shadowColor:dark? Colors.white : Colors.black,
//       child: GestureDetector(
//         onTap: ()=> Get.to(()=>const ProductDetailScreen()),
//         child: Container(
//           height: 260,
//           width: 180,
//           padding: const EdgeInsets.all(1),
//           decoration: BoxDecoration(
//             boxShadow: [TShadowStyle.VerticalProductShadow],
//             borderRadius: BorderRadius.circular(16),
//             color: dark ? TColors.dark : TColors.light,
//           ),
//           child: Column(
//             children: [
//               Container(
//                 height: 180,
//                 padding: const EdgeInsets.all(8),
//                 child: Stack(
//                   children: [
//                     const TRoundedImage(
//                       imageUlr: "assets/images/products/product2.png",
//                       applyImageRadius: true,
//                     ),
//                     Positioned(
//                       child: Container(
//                         height: 30,
//                         decoration: BoxDecoration(
//                           color: Colors.yellow.shade400,
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//                         child: Text(
//                           "25%",
//                           style: Theme.of(context).textTheme.titleSmall!.apply(color: TColors.black),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       top: 0,
//                       right: 0,
//                       child: IconButton(
//                         onPressed: () {},
//                         icon: const Icon(Iconsax.heart),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.only(left: 8),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     TProductTitleText(
//
//                       title: "Adidas New sale",
//                       smallSize: true,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         TBrandTitleWithVerifiedIcon(title:"Adidas",),
//                         SizedBox(width: 5),
//                         Icon(Iconsax.verify, color: TColors.primaryColor, size: 20),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//
//               const Spacer(),
//               /// Price ans Button
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const TProductPriceText(price: '35',),
//                   Container(
//                     decoration: const BoxDecoration(
//                       color:Colors.blue,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(10),
//                         topRight: Radius.circular(10),
//                       ),
//                     ),
//                     child: const SizedBox(
//                       width: 30,
//                       height: 30,
//                       child: Center(
//                         child: Icon(Iconsax.add, color: TColors.white, size:20),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
