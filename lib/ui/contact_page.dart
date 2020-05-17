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
  final _nameFocus = FocusNode();

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
    
        _nameController.text = _editContact.name;
        _emailController.text = _editContact.email;
        _phoneController.text = _editContact.phone;

    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(_editContact.name ?? "Novo contato"),
          centerTitle: true,
          backgroundColor: Colors.red
        ),     
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            if(_editContact.name != null && _editContact.name.isNotEmpty){
              Navigator.pop(context, _editContact);
            } else {
              FocusScope.of(context).requestFocus(_nameFocus);
            }
          },
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
                focusNode: _nameFocus,
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
      ),
    );
  }
  Future<bool> _requestPop(){
    if(_userEdit){
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Descartar alterações?"),
            content: Text("Se sair as alterações serão perdidas"),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text("Cancelar"),
              ),
              FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text("Sim"),
              ),
            ],
          );
        }
      );
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}