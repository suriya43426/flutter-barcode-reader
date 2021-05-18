import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nextflow Flutter Widget Today',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Code Reader'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _scanResult = '...';
  bool _isYoutube = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: SizedBox(
          height: 200,
          width: double.infinity,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'RESULT-SCAN',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(_scanResult),
                  Spacer(),
                  _isYoutube
                      ? SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            child: Text(
                              'เพิ่ม Youtube',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.red[900],
                            onPressed: () async{
                              if ( await canLaunch(_scanResult)) {
                                await launch(_scanResult);
                              }
                            },
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: buildRaisedButton(),
    );
  }

  RaisedButton buildRaisedButton() {
    return RaisedButton(
      onPressed: () {
        startScan();
      },
      color: Colors.blueAccent.shade200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: SizedBox(
        width: 80,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.qr_code,
              color: Colors.white,
            ),
            Text('SCAN', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  startScan() async {
    var colorCode = '#00ff38';
    var cancelButtonText = 'Cancel Scan';
    var isShowFlatIcon = true;
    var scanMode = ScanMode.DEFAULT;

    var scanResult = await FlutterBarcodeScanner.scanBarcode(
        colorCode, cancelButtonText, isShowFlatIcon, scanMode);

    if (scanResult != '-1') {
      if (scanResult.contains('youtube.com')) {
        _isYoutube = true;
      }
      setState(
        () {
          _scanResult = scanResult;
        },
      );
    }

    // print('scan ${scanResult}');
  }
}
