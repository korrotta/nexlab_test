import 'package:equatable/equatable.dart';
import '../../../models/contact_model.dart';

abstract class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object?> get props => [];
}

class ContactInitial extends ContactState {
  const ContactInitial();
}

class ContactLoading extends ContactState {
  const ContactLoading();
}

class ContactLoaded extends ContactState {
  final List<ContactModel> contacts;
  final ContactModel? selectedContact;

  const ContactLoaded({
    required this.contacts,
    this.selectedContact,
  });

  @override
  List<Object?> get props => [contacts, selectedContact];

  ContactLoaded copyWith({
    List<ContactModel>? contacts,
    ContactModel? selectedContact,
  }) {
    return ContactLoaded(
      contacts: contacts ?? this.contacts,
      selectedContact: selectedContact ?? this.selectedContact,
    );
  }
}

class ContactOperationSuccess extends ContactState {
  final String message;
  final List<ContactModel> contacts;

  const ContactOperationSuccess({
    required this.message,
    required this.contacts,
  });

  @override
  List<Object> get props => [message, contacts];
}

class ContactError extends ContactState {
  final String message;

  const ContactError(this.message);

  @override
  List<Object> get props => [message];
}
