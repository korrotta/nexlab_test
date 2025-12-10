import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../services/contact_service.dart';
import 'contact_event.dart';
import 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactService contactService;

  ContactBloc({required this.contactService}) : super(const ContactInitial()) {
    on<LoadContacts>(_onLoadContacts);
    on<SearchContacts>(_onSearchContacts);
    on<AddContact>(_onAddContact);
    on<UpdateContact>(_onUpdateContact);
    on<DeleteContact>(_onDeleteContact);
    on<SelectContact>(_onSelectContact);
  }

  Future<void> _onLoadContacts(
    LoadContacts event,
    Emitter<ContactState> emit,
  ) async {
    emit(const ContactLoading());

    try {
      final contacts = await contactService.getAllContacts();
      emit(ContactLoaded(contacts: contacts));
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }

  Future<void> _onSearchContacts(
    SearchContacts event,
    Emitter<ContactState> emit,
  ) async {
    emit(const ContactLoading());

    try {
      final contacts = await contactService.searchContacts(event.query);
      emit(ContactLoaded(contacts: contacts));
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }

  Future<void> _onAddContact(
    AddContact event,
    Emitter<ContactState> emit,
  ) async {
    emit(const ContactLoading());

    try {
      await contactService.addContact(event.contact);
      final contacts = await contactService.getAllContacts();
      emit(
        ContactOperationSuccess(
          message: 'Contact added successfully',
          contacts: contacts,
        ),
      );
      emit(ContactLoaded(contacts: contacts));
    } catch (e) {
      emit(ContactError(e.toString()));
      // Reload contacts after error
      final contacts = await contactService.getAllContacts();
      emit(ContactLoaded(contacts: contacts));
    }
  }

  Future<void> _onUpdateContact(
    UpdateContact event,
    Emitter<ContactState> emit,
  ) async {
    emit(const ContactLoading());

    try {
      await contactService.updateContact(event.contact);
      final contacts = await contactService.getAllContacts();
      emit(
        ContactOperationSuccess(
          message: 'Contact updated successfully',
          contacts: contacts,
        ),
      );
      emit(ContactLoaded(contacts: contacts));
    } catch (e) {
      emit(ContactError(e.toString()));
      // Reload contacts after error
      final contacts = await contactService.getAllContacts();
      emit(ContactLoaded(contacts: contacts));
    }
  }

  Future<void> _onDeleteContact(
    DeleteContact event,
    Emitter<ContactState> emit,
  ) async {
    emit(const ContactLoading());

    try {
      await contactService.deleteContact(event.contactId);
      final contacts = await contactService.getAllContacts();
      emit(
        ContactOperationSuccess(
          message: 'Contact deleted successfully',
          contacts: contacts,
        ),
      );
      emit(ContactLoaded(contacts: contacts));
    } catch (e) {
      emit(ContactError(e.toString()));
      // Reload contacts after error
      final contacts = await contactService.getAllContacts();
      emit(ContactLoaded(contacts: contacts));
    }
  }

  Future<void> _onSelectContact(
    SelectContact event,
    Emitter<ContactState> emit,
  ) async {
    try {
      final contact = await contactService.getContactById(event.contactId);
      if (state is ContactLoaded) {
        final currentState = state as ContactLoaded;
        emit(currentState.copyWith(selectedContact: contact));
      }
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }
}
