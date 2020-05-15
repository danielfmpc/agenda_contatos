import 'dart:io';

import 'package:agenda_contatos/helpers/contact_helper.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {

  final Contact contact;
  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _userEdit = false;
  Contact _editContact;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.contact == null) {
      _editContact = Contact();
    } else {
      _editContact = Contact.fromMap(widget.contact.toMap());
      setState(() {
        _nameController.text = _editContact.name;
        _emailController.text = _editContact.email;
        _phoneController.text = _editContact.phone;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editContact ?? "Novo contato"),
        centerTitle: true,
        backgroundColor: Colors.red
      ),     
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.save),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          
          children: <Widget>[
            GestureDetector(
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: _editContact.img != null ?
                      FileImage(File(_editContact.img)) :
                      AssetImage("images/person.png")
                  ),
                ),
              ),
            ),
            
            TextField(
              controller: _nameController,
              onChanged: (text){
                _userEdit = true;
                setState(() {
                  _editContact.name = text;
                });
              },
              decoration: InputDecoration(
                labelText: "Nome"
              ),
            ),
            
            TextField(
              controller: _emailController,
              onChanged: (text){      
                _userEdit = true;
                _editContact.email = text;              
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email"
              ),
            ),

            TextField(
              controller: _phoneController,
              onChanged: (text){
                _userEdit = true;                
                _editContact.phone = text;
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Phone"
              ),
            ),
          ],
        ),
      ),
    );
  }
}