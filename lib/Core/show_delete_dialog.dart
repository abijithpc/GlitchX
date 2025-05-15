import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Order_page/Data/Models/address_model.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/address_bloc.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/address_event.dart';

void showAddressDeleteDialog(BuildContext context, AddressModel item) {
  showCupertinoDialog(
    context: context,
    builder: (dialogContext) {
      return CupertinoAlertDialog(
        title: const Text("Delete Address"),
        content: const Text("Are you sure you want to delete this Address?"),
        actions: [
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.of(dialogContext).pop(); // Close the dialog

              final userId = FirebaseAuth.instance.currentUser?.uid;

              if (userId != null) {
                Future.delayed(const Duration(milliseconds: 100), () {
                  context.read<AddressBloc>().add(DeleteAddressEvent(item.id));
                });
              }
            },
            child: const Text("Delete"),
          ),
          CupertinoDialogAction(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text("Cancel"),
          ),
        ],
      );
    },
  );
}
