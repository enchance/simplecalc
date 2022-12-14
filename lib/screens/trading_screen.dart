import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../main.dart';



class CryptoScreen extends StatefulWidget {
  static const route = '/crypto';
  const CryptoScreen({Key? key}) : super(key: key);

  @override
  State<CryptoScreen> createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final f = NumberFormat.decimalPattern('en_US');

  double _investment = 0;
  double _buy = 0;
  double _sell = 0;
  double _earnings = 0;
  double _percent = 0;
  final TextEditingController _invcont = TextEditingController();
  final TextEditingController _buycont = TextEditingController();
  final TextEditingController _sellcont = TextEditingController();
  final FocusNode node1 = FocusNode();

  @override
  void initState() {
    super.initState();
    _invcont.addListener(() => setState(() {}));
    _buycont.addListener(() => setState(() {}));
    _sellcont.addListener(() => setState(() {}));
  }

  void _clearForm() {
    _invcont.clear();
    _buycont.clear();
    _sellcont.clear();
    FocusScope.of(context).requestFocus(node1);
  }

  Widget buildInvestment({String error='Investment required'}) {
    return TextFormField(
      focusNode: node1,
      autofocus: true,
      controller: _invcont,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.attach_money),
        suffixIcon: _invcont.text.isEmpty
          ? Container(width: 0)
          : IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => _invcont.clear(),
            ),
        hintText: 'Spend amount'
        // labelText: 'Investment',
        // border: OutlineInputBorder(),
      ),
      validator: ([String? val='']) {
        if(val!.trim().isEmpty) return error;
        if(double.tryParse(val) == null) return error;
        if(double.parse(val) <= 0) return error;
      },
      onSaved: (val) {
        _investment = double.parse(val!);
      },
    );
  }

  Widget buildBuy({String error='Buy price required'}) {
    return TextFormField(
      controller: _buycont,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.arrow_forward),
        suffixIcon: _buycont.text.isEmpty
            ? Container(width: 0)
            : IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => _buycont.clear(),
        ),
        labelText: 'Buy price',
        // border: OutlineInputBorder(),
      ),
      validator: ([String? val='']) {
        if(val!.trim().isEmpty) return error;
        if(double.tryParse(val) == null) return error;
        if(double.parse(val) <= 0) return error;
      },
      onSaved: (val) {
        _buy = double.parse(val!);
      },
    );
  }

  Widget buildSell({String error='Sell price required'}) {
    return TextFormField(
      controller: _sellcont,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.arrow_back),
        suffixIcon: _sellcont.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => _sellcont.clear(),
              ),
        labelText: 'Sell price',
        // border: OutlineInputBorder(),
      ),
      validator: ([String? val='']) {
        if(val!.trim().isEmpty) return error;
        if(double.tryParse(val) == null) return error;
        if(double.parse(val) <= 0) return error;
      },
      onSaved: (val) {
        _sell = double.parse(val!);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // drawer: DrawerWidget(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 400,
            ),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  ...buildHeadlineText(context, 'Profit Calculator'),
                  buildInvestment(),
                  buildBuy(),
                  buildSell(),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () {
                        if(!formKey.currentState!.validate()) return;
                        formKey.currentState!.save();
                        setState(() {
                          _earnings = (_investment / _buy) * _sell - _investment;
                          _percent = _earnings / _investment * 100;
                        });
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: const Text('Calculate')
                  ),
                  const SizedBox(height: 20),

                  if(_earnings == 0)
                    const Text('0 USDT',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      )),

                  if(_earnings != 0)
                    Text('${f.format(_earnings)} USDT',
                        textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: _earnings > 0 ? Colors.green : Colors.red
                      )),

                  if(_earnings > 0)
                    Text('${f.format(_percent)}% gain',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20)
                      ),

                  if(_earnings < 0)
                    Text('${f.format(_percent)}% loss',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20)
                      ),

                  const SizedBox(height: 20),
                  TextButton.icon(
                      onPressed: () => _clearForm(),
                      icon: const Icon(Icons.clear),
                      label: const Text('Clear form', style: TextStyle(
                        fontWeight: FontWeight.bold
                      ))
                  )
                ],
              ),
            )
          ),
        ),
      )
    );
  }
}
