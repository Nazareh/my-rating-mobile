import 'package:flutter/material.dart';

enum MessageType { error, success }

void showFlashMessage(
    BuildContext context, String message, MessageType type) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: SizedBox(
        height: 30, // Adjust the height as needed
        child: Row(
          children: [
            Icon(type == MessageType.error ? Icons.error : Icons.done,
                color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: type == MessageType.error ? Colors.red : Colors.green,
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
        label: 'Dismiss',
        textColor: Colors.white,
        backgroundColor: Colors.black,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ),
  );
}