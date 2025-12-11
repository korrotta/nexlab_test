import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/contact_model.dart';
import '../bloc/contact_bloc.dart';
import '../bloc/contact_event.dart';
import '../widgets/contact_header.dart';
import '../widgets/contact_info_card.dart';
import '../widgets/delete_contact_dialog.dart';
import 'contact_form_page.dart';

class ContactDetailPage extends StatelessWidget {
  final ContactModel contact;

  const ContactDetailPage({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<ContactBloc>(),
                    child: ContactFormPage(contact: contact),
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _handleDelete(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ContactHeader(name: contact.name),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ContactInfoCard(
                    icon: Icons.email,
                    title: 'Email',
                    value: contact.email,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 12),
                  ContactInfoCard(
                    icon: Icons.phone,
                    title: 'Phone',
                    value: contact.phone,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 12),
                  ContactInfoCard(
                    icon: Icons.location_on,
                    title: 'Address',
                    value: contact.address,
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 12),
                  ContactInfoCard(
                    icon: Icons.badge,
                    title: 'ID',
                    value: contact.id,
                    color: Colors.purple,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleDelete(BuildContext context) {
    DeleteContactDialog.show(
      context: context,
      contactName: contact.name,
      onConfirm: () {
        context.read<ContactBloc>().add(DeleteContact(contact.id));
        Navigator.pop(context);
      },
    );
  }
}
