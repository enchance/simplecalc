import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/nav_widget.dart';
import '../core/utils.dart';



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

  Widget buildInvestment({String error='Investment required'}) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Investment',
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

  Widget buildBuy({String error='Buy amount required'}) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Buy amount',
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

  Widget buildSell({String error='Sell amount required'}) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Sell amount',
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
    var maxWidth = MediaQuery.of(context).size.width;

    return Container(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: DrawerWidget(),
        body: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (_, constraints) => Container(
              width: maxWidth > 500 ? 500 : double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    buildInvestment(),
                    buildBuy(),
                    buildSell(),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            if(!formKey.currentState!.validate()) return;
                            formKey.currentState!.save();
                            setState(() {
                              _earnings = (_investment / _buy) * _sell - _investment;
                              _percent = _earnings / _investment * 100;
                            });
                          },
                          child: Text('Calculate')
                      ),
                    ),
                    SizedBox(height: 20),

                    if(_earnings == 0)
                      Text('0 USDT', style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                      )),

                    if(_earnings != 0)
                      Text('${f.format(_earnings)} USDT', style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: _earnings > 0 ? Colors.green : Colors.red
                      )),

                    if(_earnings > 0)
                      Text('${f.format(_percent)}% gain', style: TextStyle(
                        fontSize: 20)),

                    if(_earnings < 0)
                      Text('${f.format(_percent)}% loss', style: TextStyle(
                          fontSize: 20)),
                  ],
                ),
              )
            ),
          ),
        )
      )
    );
  }
}
