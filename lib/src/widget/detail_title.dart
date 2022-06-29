import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/constants.dart';
import '../model/item.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name,
              style: const TextStyle(fontSize: 24),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(45),
                    child: SvgPicture.asset(
                      'assets/icons/star.svg',
                      width: kDefaultPadding * 0.8,
                    ),
                  ),
                ),
                const SizedBox(width: kDefaultPadding * 0.1),
                Text(
                    '${item.rating.toString()} (${item.ratingCount.toString()})'),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 50,
          child: IconButton(
              icon: SvgPicture.asset('assets/icons/heart.svg'),
              onPressed: () {}),
        ),
      ],
    );
  }
}
