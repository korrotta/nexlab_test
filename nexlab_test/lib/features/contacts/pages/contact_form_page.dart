import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/contact_model.dart';
import '../bloc/contact_bloc.dart';
import '../bloc/contact_event.dart';
import '../bloc/contact_state.dart';
import '../widgets/contact_form_field.dart';
import '../widgets/submit_button.dart';

class ContactFormPage extends StatefulWidget {
  final ContactModel? contact;

  const ContactFormPage({super.key, this.contact});

  @override
  State<ContactFormPage> createState() => _ContactFormPageState();
}

class _ContactFormPageState extends State<ContactFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;

  bool get isEditing => widget.contact != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contact?.name ?? '');
    _emailController = TextEditingController(text: widget.contact?.email ?? '');
    _phoneController = TextEditingController(text: widget.contact?.phone ?? '');
    _addressController = TextEditingController(
      text: widget.contact?.address ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final contact = ContactModel(
        id: widget.contact?.id ?? '',
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        address: _addressController.text.trim(),
      );

      if (isEditing) {
        context.read<ContactBloc>().add(UpdateContact(contact));
      } else {
        context.read<ContactBloc>().add(AddContact(contact));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Contact' : 'Add Contact'),
      ),
      body: BlocConsumer<ContactBloc, ContactState>(
        listener: (context, state) {
          if (state is ContactOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          } else if (state is ContactError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is ContactLoading;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ContactFormField(
                    controller: _nameController,
                    label: 'Name',
                    hint: 'Enter full name',
                    icon: Icons.person,
                    enabled: !isLoading,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ContactFormField(
                    controller: _emailController,
                    label: 'Email',
                    hint: 'Enter email address',
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    enabled: !isLoading,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ContactFormField(
                    controller: _phoneController,
                    label: 'Phone',
                    hint: 'Enter phone number',
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    enabled: !isLoading,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ContactFormField(
                    controller: _addressController,
                    label: 'Address',
                    hint: 'Enter address',
                    icon: Icons.location_on,
                    maxLines: 3,
                    enabled: !isLoading,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  SubmitButton(
                    onPressed: _handleSubmit,
                    label: isEditing ? 'Update Contact' : 'Add Contact',
                    isLoading: isLoading,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
