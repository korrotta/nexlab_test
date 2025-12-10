import 'package:equatable/equatable.dart';
import '../../../models/contact_model.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

class LoadContacts extends ContactEvent {
  const LoadContacts();
}

class SearchContacts extends ContactEvent {
  final String query;

  const SearchContacts(this.query);

  @override
  List<Object> get props => [query];
}

class AddContact extends ContactEvent {
  final ContactModel contact;

  const AddContact(this.contact);

  @override
  List<Object> get props => [contact];
}

class UpdateContact extends ContactEvent {
  final ContactModel contact;

  const UpdateContact(this.contact);

  @override
  List<Object> get props => [contact];
}

class DeleteContact extends ContactEvent {
  final String contactId;

  const DeleteContact(this.contactId);

  @override
  List<Object> get props => [contactId];
}

class SelectContact extends ContactEvent {
  final String contactId;

  const SelectContact(this.contactId);

  @override
  List<Object> get props => [contactId];
}
