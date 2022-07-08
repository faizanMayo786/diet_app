// import 'package:diet_suggestion_app/src/widget/detail_vitamin.dart';
// import 'package:flutter/material.dart';
// import '../../../core/constants/constants.dart';
// import '../../model/item.dart';
// import '../../widget/detail_ingredient.dart';
// import '../../widget/detail_price_and_buy.dart';
// import '../../widget/detail_qty_counter.dart';
// import '../../widget/detail_title.dart';

// class DetailsScreen extends StatelessWidget {
//   final Item item;

//   const DetailsScreen({Key? key, required this.item}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 52, 52, 52),
//       appBar: AppBar(
//         title: const Text('Diet Plans'),
//         centerTitle: true,
//         backgroundColor: const Color.fromARGB(255, 52, 52, 52),
//         elevation: 0,
//       ),
//       body: Stack(
//         alignment: Alignment.topCenter,
//         children: [
//           Container(
//             margin: EdgeInsets.only(top: size.height * 0.2),
//             padding: EdgeInsets.only(top: size.height * 0.2),
//             height: size.height * 0.8,
//             decoration: BoxDecoration(
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(kDefaultPadding * 5),
//                   topRight: Radius.circular(kDefaultPadding * 5),
//                 ),
//                 color: Color(item.color)),
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.fromLTRB(
//                   kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
//               child: SafeArea(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
                    
//                     TitleBar(item: item),
//                     const SizedBox(height: kDefaultPadding),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: const [
//                         Text(
//                           'Detail',
//                           style: TextStyle(fontSize: 18),
//                         ),
//                         QtyCounter(),
//                       ],
//                     ), //
//                     const SizedBox(height: kDefaultPadding),
//                     Text(
//                       item.description,
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                     const SizedBox(height: kDefaultPadding),
//                     Vitamins(item: item),
//                     const SizedBox(height: kDefaultPadding),
//                     const Text(
//                       'Ingredients',
//                       style: TextStyle(fontSize: 18),
//                     ),
//                     const SizedBox(height: kDefaultPadding),
//                     Ingredients(item: item),
//                     const SizedBox(height: kDefaultPadding * 2),
//                     PriceAndBuy(item: item)
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Hero(
//             tag: item.id,
//             child: Image.asset(
//               item.image,
//               height: size.height * 0.4,
//               fit: BoxFit.fitHeight,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
