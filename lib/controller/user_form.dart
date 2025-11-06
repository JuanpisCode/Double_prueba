import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'address_form.dart';
import 'user_detail.dart';

class UserForm extends StatefulWidget {
  static const routeName = '/';
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  final _firstController = TextEditingController();
  final _lastController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    _firstController.dispose();
    _lastController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime(now.year - 18),
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _saveForm() {
    if (!_formKey.currentState!.validate()) return;
    final provider = Provider.of<UserProvider>(context, listen: false);
    provider.updateName(firstName: _firstController.text, lastName: _lastController.text);
    if (_selectedDate != null) provider.updateBirthDate(_selectedDate!);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Usuario guardado en memoria')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Crear usuario'),
        actions: [
Container(
  decoration: BoxDecoration(
    color: const Color(0xff596AB2),
      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(17),
                        bottomLeft: Radius.circular(17),
                      ), // o 50 para hacerlo circular
  ),
  child: IconButton(
    icon: const Icon(Icons.person, color: Colors.white),
    tooltip: 'Ver usuario',
    onPressed: () => Navigator.pushNamed(context, UserDetail.routeName),
  ),
),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff596AB2), width: 3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Container(
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Color(0xff596AB2),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(17),
                        topRight: Radius.circular(17),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Formulario de Usuario',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _firstController,
                            decoration: const InputDecoration(labelText: 'Nombre'),
                            validator: (v) => v == null || v.trim().isEmpty ? 'Ingrese nombre' : null,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _lastController,
                            decoration: const InputDecoration(labelText: 'Apellido'),
                            validator: (v) => v == null || v.trim().isEmpty ? 'Ingrese apellido' : null,
                          ),
                          const SizedBox(height: 12),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Fecha de nacimiento'),
                            subtitle: Text(
                              _selectedDate == null
                                  ? 'No seleccionada'
                                  : _selectedDate!.toLocal().toString().split(' ')[0],
                            ),
                            trailing: ElevatedButton(
                              onPressed: _pickDate,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff596AB2),
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Seleccionar'),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  icon: const Icon(Icons.save),
                                  label: const Text('Guardar usuario'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff596AB2),
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: _saveForm,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.add_location),
                            label: const Text('Agregar dirección'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff596AB2),
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () => Navigator.pushNamed(context, AddressForm.routeName),
                          ),
                          const SizedBox(height: 20),
                          const Divider(),
                          const SizedBox(height: 8),
                          const Text(
                            'Información de usuario',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text('Nombre: ${provider.user.firstName}'),
                          Text('Apellido: ${provider.user.lastName}'),
                          Text(
                            'Nacimiento: ${provider.user.birthDate == null ? '' : provider.user.birthDate!.toLocal().toString().split(' ')[0]}',
                          ),
                          const SizedBox(height: 8),
                          Text('Direcciones: ${provider.user.addresses.length}'),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 70,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xff596AB2),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(17),
                        bottomRight: Radius.circular(17),
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      child: InkWell(
                        onTap: _saveForm,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              'Guardar',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}