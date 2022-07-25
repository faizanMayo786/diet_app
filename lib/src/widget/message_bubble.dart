// ignore_for_file: deprecated_member_use, use_key_in_widget_constructors, overridden_fields

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  @override
  final Key key;
  final String username;
  const MessageBubble(
    this.message,
    this.isMe,
    this.username, {
    required this.key,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: !isMe
                    ? Colors.grey[300]
                    : Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft:
                      !isMe ? const Radius.circular(0) : const Radius.circular(12),
                  bottomRight:
                      isMe ? const Radius.circular(0) : const Radius.circular(12),
                ),
              ),
              width: 140,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: !isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.bodyText1!.color,
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                        color: !isMe
                            ? Colors.black
                            : Theme.of(context)
                                .accentTextTheme
                                .bodyText1!
                                .color),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: isMe ? null : 120,
          right: isMe ? 120 : null,
          child: CircleAvatar(
            backgroundColor: !isMe
                ? Theme.of(context).colorScheme.primary
                : Colors.grey[300],
            child: SvgPicture.asset('assets/icons/profile.svg'),
          ),
        ),
      ],
    );
  }
}
