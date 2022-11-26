import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// TODO:
//    - fonction mot de passe oublié
//    - design

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

String barcodeNutella = "3017620422003";
String apiBaseUrl = "http://projetisenapi.zazadago.fr/";

String? firebaseToken = "";

class MyApp extends StatelessWidget {
  static User? firebaseUser;

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyHomePage',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'gl_flutter demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }
    return user;
  }

  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 250,
            width: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: usernameTextController,
                  obscureText: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nom d\'utilisateur',
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                TextField(
                  controller: passwordTextController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Mot de passe',
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    print("Login button pressed");
                    User? firebaseUser = await signInUsingEmailPassword(
                        email: usernameTextController.text,
                        password: passwordTextController.text,
                        context: context);

                    if (firebaseUser == null) {
                      print("firebaseUser null");
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const UnsuccessfullLoginScreen()));
                    } else {
                      print(
                          "firebaseUser ${usernameTextController.text} connected");
                      /*
                      firebaseUser
                          .getIdTokenResult(true)
                          .then((value) => print(value.token));*/

                      MyApp.firebaseUser = firebaseUser;
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ScanScreen()));
                    }
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

class UnsuccessfullLoginScreen extends StatelessWidget {
  const UnsuccessfullLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UnsuccessfullLoginScreen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Identifiants invalides."),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Réessayer"),
            )
          ],
        ),
      ),
    );
  }
}

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});
  //final String title;

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  String _scanBarcode = "";

  // Allergen test
  Future<void> testAllergies(String? firebaseToken, String barcodeScanRes) async {

    List userAllergens = [];
    List productAllergens = [];
    bool isSafeToEat = true;
    
    var headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer $firebaseToken'
    };

    // get user allergens
    var request = http.Request('GET', Uri.parse('${apiBaseUrl}api/v1/user/allergens'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      // response.stream.bytesToString() = allergènes de l'utilisateur
      userAllergens = json.decode(await response.stream.bytesToString());
      // convert to lowercase
      userAllergens = userAllergens.map((allergen)=>allergen.toLowerCase()).toList();
      print("User allergens: $userAllergens");
    }
    else {
      print(response.reasonPhrase);
    }

    // get product allergens
    var productRequestHeaders = {
        'accept': 'application/json',
        'Authorization': 'Bearer $firebaseToken'
      };
      var productRequest = http.Request('GET', Uri.parse('${apiBaseUrl}api/v1/product/$barcodeScanRes'));
      productRequest.headers.addAll(productRequestHeaders);
      http.StreamedResponse productResponse = await productRequest.send();
      if (productResponse.statusCode == 200) {
        String productResponseString = await productResponse.stream.bytesToString();
        Map valueMap = json.decode(productResponseString);
        var valuesReturned = valueMap.values.toList();
        String productName = valuesReturned[0];
        String productBarcode = valuesReturned[1];
        productAllergens = valuesReturned[2];
        // convert to lowercase
        productAllergens = productAllergens.map((allergen)=>allergen.toLowerCase()).toList();
        print("Product allergens: $productAllergens");
      }
      else {
        print(productResponse.reasonPhrase);
      }

    // Comparison logic
    userAllergens.forEach((element) {
      if (productAllergens.contains(element)){
        isSafeToEat = false;
      }
    });

    if(isSafeToEat){
      Fluttertoast.showToast(
        msg: "Vas-y mange gros porc",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    }
    else{
      Fluttertoast.showToast(
        msg: "Mange pas ça tu vas crever",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    }
  }

  // Unique scan
  Future<void> barcodeScan() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Annuler', true, ScanMode.BARCODE);
      queryAllergens(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  // Continuous scan
  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Annuler', true, ScanMode.BARCODE)!
        .listen((barcode) {
          queryAllergens(barcode);
        });
  }

  // Query API
  String queryAllergens(String barcodeScanRes) {
    User? firebaseUser = MyApp.firebaseUser;
    firebaseUser
        ?.getIdTokenResult(true)
        .then((value) {
          firebaseToken = value.token;
          print("firebaseToken $firebaseToken");
          testAllergies(firebaseToken, barcodeScanRes);
        });
    return "a";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ScanScreen'),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Text("Bonjour ${MyApp.firebaseUser?.uid}"),
              Text("Contenu du code-barres: $_scanBarcode"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      barcodeScan();
                    },
                    child: const Text('Scan unique'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      startBarcodeScanStream();
                    },
                    child: const Text('Scan continu'),
                  ),
                ],
              )
            ])));
  }
}
