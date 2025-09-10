// screens/contact_recovery.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
class ContactRecoveryScreen extends StatefulWidget {
  const ContactRecoveryScreen({super.key});

  @override
  State<ContactRecoveryScreen> createState() => _ContactRecoveryScreenState();
}

class _ContactRecoveryScreenState extends State<ContactRecoveryScreen> {
  List<Contact> _contacts = [];
  bool _isLoading = true;
  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    try {
      final Iterable<Contact> contacts = await ContactsService.getContacts();
      setState(() {
        _contacts = contacts.toList();
        _isLoading = false;
        _hasPermission = true;
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        setState(() {
          _hasPermission = false;
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _requestPermission() async {
    try {
      await ContactsService.getContacts();
      _loadContacts();
    } on PlatformException catch (e) {
      // Handle permission error
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Contact Recovery'),
      ),
      child: SafeArea(
        child: _isLoading
            ? const Center(child: CupertinoActivityIndicator())
            : _hasPermission
                ? _buildContactList()
                : _buildPermissionRequest(),
      ),
    );
  }

  Widget _buildContactList() {
    return ListView.builder(
      itemCount: _contacts.length,
      itemBuilder: (context, index) {
        final contact = _contacts[index];
        return CupertinoListTile(
          leading: const CircleAvatar(
            child: Icon(CupertinoIcons.person),
          ),
          title: Text(contact.displayName ?? 'Unknown'),
          subtitle: Text(contact.phones?.isNotEmpty == true
              ? contact.phones!.first.value ?? ''
              : 'No phone number'),
        );
      },
    );
  }

  Widget _buildPermissionRequest() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(CupertinoIcons.person, size: 64),
          const SizedBox(height: 16),
          const Text('Contact Access Required'),
          const SizedBox(height: 8),
          CupertinoButton(
            onPressed: _requestPermission,
            child: const Text('Grant Permission'),
          ),
        ],
      ),
    );
  }
}