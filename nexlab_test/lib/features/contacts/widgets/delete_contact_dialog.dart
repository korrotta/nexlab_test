import 'package:flutter/material.dart';

class DeleteContactDialog extends StatelessWidget {
  final String contactName;
  final VoidCallback onConfirm;

  const DeleteContactDialog({
    super.key,
    required this.contactName,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Contact'),
      content: Text('Are you sure you want to delete $contactName?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onConfirm();
          },
          style: TextButton.styleFrom(foregroundColor: Colors.red),
          child: const Text('Delete'),
        ),
      ],
    );
  }

  static Future<void> show({
    required BuildContext context,
    required String contactName,
    required VoidCallback onConfirm,
  }) {
    return showDialog(
      context: context,
      builder: (context) => DeleteContactDialog(
        contactName: contactName,
        onConfirm: onConfirm,
      ),
    );
  }
}
