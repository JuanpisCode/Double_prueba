import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class AddressForm extends StatefulWidget {
  static const routeName = '/address';
  const AddressForm({super.key});

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final _formKey = GlobalKey<FormState>();
  final _countryCtrl = TextEditingController();
  final _deptCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _streetCtrl = TextEditingController();

  @override
  void dispose() {
    _countryCtrl.dispose();
    _deptCtrl.dispose();
    _cityCtrl.dispose();
    _streetCtrl.dispose();
    super.dispose();
  }

  void _saveAddress() {
    if (!_formKey.currentState!.validate()) return;
    final provider = Provider.of<UserProvider>(context, listen: false);
    provider.addAddress(
      country: _countryCtrl.text,
      department: _deptCtrl.text,
      city: _cityCtrl.text,
      street: _streetCtrl.text,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Dirección agregada')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Agregar dirección'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff596AB2), width: 3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Container(
                    height: 80,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xff596AB2),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(17),
                        topRight: Radius.circular(17),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Formulario de Dirección',
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
                            controller: _countryCtrl,
                            decoration:
                                const InputDecoration(labelText: 'País'),
                            validator: (v) =>
                                v == null || v.trim().isEmpty
                                    ? 'Ingrese país'
                                    : null,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _deptCtrl,
                            decoration: const InputDecoration(
                                labelText: 'Departamento'),
                            validator: (v) =>
                                v == null || v.trim().isEmpty
                                    ? 'Ingrese departamento'
                                    : null,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _cityCtrl,
                            decoration:
                                const InputDecoration(labelText: 'Municipio'),
                            validator: (v) =>
                                v == null || v.trim().isEmpty
                                    ? 'Ingrese municipio'
                                    : null,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _streetCtrl,
                            decoration: const InputDecoration(
                                labelText: 'Dirección física'),
                            validator: (v) =>
                                v == null || v.trim().isEmpty
                                    ? 'Ingrese dirección física'
                                    : null,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  icon: const Icon(Icons.save),
                                  label:
                                      const Text('Guardar dirección'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff596AB2),
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: _saveAddress,
                                ),
                              ),
                            ],
                          ),
                        ],
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