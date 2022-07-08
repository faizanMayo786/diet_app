// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../core/constants/constants.dart';
// import '../model/item.dart';
// import '../screens/detail/detail_screen.dart';

// class ItemCard extends StatelessWidget {
//   const ItemCard({
//     Key? key,
//     required this.item,
//     required this.index,
//   }) : super(key: key);

//   final Item item;
//   final int index;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => DetailsScreen(item: item)));
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(45),
//           color: Color(item.color),
//         ),
//         margin: EdgeInsets.only(
//           top: index.isOdd ? 10 : 10,
//           bottom: index.isOdd ? 10 : 10,
//           left: 10,
//           right: 10,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Hero(
//               tag: item.id,
//               child: Image.asset(
//                 item.image,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: SizedBox(
//                 height: 50,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: kDefaultPadding * 2),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             item.name,
//                             style: const TextStyle(
//                               fontSize: 22,
//                             ),
//                           ),
//                           Text(
//                             '\$ ${item.price}',
//                             style: const TextStyle(
//                               color: kRedColor,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ],
//                       ),
//                       IconButton(
//                           icon: SvgPicture.asset('assets/icons/heart.svg'),
//                           onPressed: () {}),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
