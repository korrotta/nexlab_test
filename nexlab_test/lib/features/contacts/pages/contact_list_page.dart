import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/contact_bloc.dart';
import '../bloc/contact_event.dart';
import '../bloc/contact_state.dart';
import '../widgets/contact_list_tile.dart';
import '../widgets/contact_search_bar.dart';
import '../widgets/delete_contact_dialog.dart';
import '../widgets/empty_contacts_view.dart';
import 'contact_detail_page.dart';
import 'contact_form_page.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({super.key});

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ContactBloc>().add(const LoadContacts());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    if (query.isEmpty) {
      context.read<ContactBloc>().add(const LoadContacts());
    } else {
      context.read<ContactBloc>().add(SearchContacts(query));
    }
  }

  void _onClearSearch() {
    _searchController.clear();
    _onSearch('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: ContactSearchBar(
            controller: _searchController,
            onChanged: _onSearch,
            onClear: _onClearSearch,
          ),
        ),
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
          if (state is ContactLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ContactLoaded) {
            if (state.contacts.isEmpty) {
              return const EmptyContactsView();
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<ContactBloc>().add(const LoadContacts());
              },
              child: ListView.builder(
                itemCount: state.contacts.length,
                itemBuilder: (context, index) {
                  final contact = state.contacts[index];
                  return ContactListTile(
                    contact: contact,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<ContactBloc>(),
                            child: ContactDetailPage(contact: contact),
                          ),
                        ),
                      );
                    },
                    onEdit: () {
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
                    onDelete: () {
                      DeleteContactDialog.show(
                        context: context,
                        contactName: contact.name,
                        onConfirm: () {
                          context.read<ContactBloc>().add(
                            DeleteContact(contact.id),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            );
          }

          return const Center(child: Text('Something went wrong'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<ContactBloc>(),
                child: const ContactFormPage(),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
