import '../models/contact_model.dart';

class ContactService {
  // Mock contact database
  final List<ContactModel> _contacts = [
    ContactModel(
      id: '1',
      name: 'John Doe',
      email: 'john.doe@example.com',
      phone: '+1 (555) 123-4567',
      address: '123 Main St, New York, NY 10001',
    ),
    ContactModel(
      id: '2',
      name: 'Jane Smith',
      email: 'jane.smith@example.com',
      phone: '+1 (555) 234-5678',
      address: '456 Oak Ave, Los Angeles, CA 90001',
    ),
    ContactModel(
      id: '3',
      name: 'Bob Johnson',
      email: 'bob.johnson@example.com',
      phone: '+1 (555) 345-6789',
      address: '789 Pine Rd, Chicago, IL 60601',
    ),
    ContactModel(
      id: '4',
      name: 'Alice Williams',
      email: 'alice.williams@example.com',
      phone: '+1 (555) 456-7890',
      address: '321 Elm St, Houston, TX 77001',
    ),
    ContactModel(
      id: '5',
      name: 'Charlie Brown',
      email: 'charlie.brown@example.com',
      phone: '+1 (555) 567-8901',
      address: '654 Maple Dr, Phoenix, AZ 85001',
    ),
  ];

  Future<List<ContactModel>> getAllContacts() async {
    await Future.delayed(const Duration(seconds: 2));
    return List.from(_contacts);
  }

  Future<ContactModel> getContactById(String id) async {
    await Future.delayed(const Duration(seconds: 2));

    try {
      return _contacts.firstWhere((contact) => contact.id == id);
    } catch (e) {
      throw Exception('Contact not found');
    }
  }

  Future<ContactModel> addContact(ContactModel contact) async {
    await Future.delayed(const Duration(seconds: 2));

    // Validate
    if (contact.name.isEmpty) {
      throw Exception('Name is required');
    }
    if (contact.email.isEmpty) {
      throw Exception('Email is required');
    }

    // Generate new ID
    final newId = (_contacts.length + 1).toString();
    final newContact = ContactModel(
      id: newId,
      name: contact.name,
      email: contact.email,
      phone: contact.phone,
      address: contact.address,
    );

    _contacts.add(newContact);
    return newContact;
  }

  Future<ContactModel> updateContact(ContactModel contact) async {
    await Future.delayed(const Duration(seconds: 2));

    final index = _contacts.indexWhere((c) => c.id == contact.id);
    if (index == -1) {
      throw Exception('Contact not found');
    }

    // Validate
    if (contact.name.isEmpty) {
      throw Exception('Name is required');
    }
    if (contact.email.isEmpty) {
      throw Exception('Email is required');
    }

    _contacts[index] = contact;
    return contact;
  }

  Future<void> deleteContact(String id) async {
    await Future.delayed(const Duration(seconds: 2));

    final index = _contacts.indexWhere((c) => c.id == id);
    if (index == -1) {
      throw Exception('Contact not found');
    }

    _contacts.removeAt(index);
  }

  Future<List<ContactModel>> searchContacts(String query) async {
    await Future.delayed(const Duration(seconds: 2));

    if (query.isEmpty) {
      return List.from(_contacts);
    }

    final lowerQuery = query.toLowerCase();
    return _contacts.where((contact) {
      return contact.name.toLowerCase().contains(lowerQuery) ||
          contact.email.toLowerCase().contains(lowerQuery) ||
          contact.phone.contains(query);
    }).toList();
  }
}
