import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/nav_widget.dart';
import '../core/utils.dart';
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
  TextEditingController _invcont = TextEditingController();
  TextEditingController _buycont = TextEditingController();
  TextEditingController _sellcont = TextEditingController();

  @override
  void initState() {
    super.initState();
    _invcont.addListener(() => setState(() {}));
    _buycont.addListener(() => setState(() {}));
    _sellcont.addListener(() => setState(() {}));
  }

  Widget buildInvestment({String error='Investment required'}) {
    return TextFormField(
      autofocus: true,
      controller: _invcont,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.attach_money),
        suffixIcon: _invcont.text.isEmpty
          ? Container(width: 0)
          : IconButton(
              icon: Icon(Icons.close),
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
        prefixIcon: Icon(Icons.currency_bitcoin),
        suffixIcon: _buycont.text.isEmpty
            ? Container(width: 0)
            : IconButton(
          icon: Icon(Icons.close),
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
        prefixIcon: Icon(Icons.currency_bitcoin),
        suffixIcon: _sellcont.text.isEmpty
            ? Container(width: 0)
            : IconButton(
          icon: Icon(Icons.close),
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
                    SizedBox(height: 20),
                    ...buildHeadlineText(context, 'Crypto'),
                    buildInvestment(),
                    buildBuy(),
                    buildSell(),
                    SizedBox(height: 10),
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
