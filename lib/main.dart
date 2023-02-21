// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:quickalert/quickalert.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

String barcodeNutella = "3017620422003";
// url qui hébèrge l'api pour le moment, vu que la vm est indisponible
// hébergée chez moi
String apiBaseUrl = "http://projetisenapi.zazadago.fr/";

String? firebaseToken = "";
final FirebaseAuth auth = FirebaseAuth.instance;

// Création d'une primaryswatch à partir d'un hex de couleur
// pour la couleur verte de la charte graphique
MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

class MyApp extends StatelessWidget {
  static User? firebaseUser;

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyHomePage',
      theme: ThemeData(
        primarySwatch: buildMaterialColor(Color(0xff00bd7e)),
        fontFamily: 'Inter',
      ),
      home: const MyHomePage(title: 'Dish'),
    );
  }
}

class ForgottenPasswordScreen extends StatefulWidget {
  const ForgottenPasswordScreen({super.key});

  @override
  State<ForgottenPasswordScreen> createState() =>
      _ForgottenPasswordScreenState();
}

// Activité Mot de passe oublié
class _ForgottenPasswordScreenState extends State<ForgottenPasswordScreen> {
  final mailTextController = TextEditingController();

  void sendResetPasswordMail(String mail) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Réinitialiser le mot de passe"),
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
                  children: [
                    // ignore: prefer_const_constructors
                    TextField(
                      controller: mailTextController,
                      obscureText: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Adresse mail',
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    ElevatedButton(
                        onPressed: () => {
                              showDialog<void>(
                                context: context,
                                barrierDismissible:
                                    false, // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Confirmation'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: const <Widget>[
                                          Text(
                                              'Si l\'adresse mail renseignée est associée à un compte existant, un mail contenant les instructions pour réinitialiser son mot de passe lui sera envoyé.'),
                                          Text('Souhaitez-vous continuer ?'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text("Annuler"),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      ),
                                      TextButton(
                                        child: const Text('Confirmer'),
                                        onPressed: () {
                                          auth.sendPasswordResetEmail(
                                              email: mailTextController.text);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              )
                            },
                        child: const Text("Envoyer"))
                  ],
                ))
          ],
        )));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Activité principale au lancement de l'app
class _MyHomePageState extends State<MyHomePage> {
  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    // auth = FirebaseAuth.instance;
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
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(children: [
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
                    ]),
                    const SizedBox(width: 10),
                    Column(children: [
                      ElevatedButton(
                        onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgottenPasswordScreen()))
                        },
                        child: const Text('Mot de passe oublié'),
                      ),
                    ])
                  ],
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}

// Activité erreur de connexion
class UnsuccessfullLoginScreen extends StatelessWidget {
  const UnsuccessfullLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Erreur d\'authentification'),
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

// Activité de scan
class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});
  //final String title;

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  String _scanBarcode = "";

  // Test d'allergènes
  Future<void> testAllergies(
      String? firebaseToken, String barcodeScanRes, bool isContinuous) async {
    List userAllergens = [];
    List productAllergens = [];
    bool isSafeToEat = true;

    var headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer $firebaseToken'
    };

    // taper l'API pour avoir les allergènes de l'utilisateur
    var request =
        http.Request('GET', Uri.parse('${apiBaseUrl}api/v1/user/allergens'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      // response.stream.bytesToString() = allergènes de l'utilisateur
      userAllergens = json.decode(await response.stream.bytesToString());
      // convertir en minuscules
      userAllergens =
          userAllergens.map((allergen) => allergen.toLowerCase()).toList();
      print("User allergens: $userAllergens");
    } else {
      print(response.reasonPhrase);
    }

    // demander les allergènes du produit $barcodeScanRes à l'API
    var productRequestHeaders = {
      'accept': 'application/json',
      'Authorization': 'Bearer $firebaseToken'
    };
    var productRequest = http.Request(
        'GET', Uri.parse('${apiBaseUrl}api/v1/product/$barcodeScanRes'));
    productRequest.headers.addAll(productRequestHeaders);
    http.StreamedResponse productResponse = await productRequest.send();
    if (productResponse.statusCode == 200) {
      String productResponseString =
          await productResponse.stream.bytesToString();
      Map valueMap = json.decode(productResponseString);
      var valuesReturned = valueMap.values.toList();
      // String productName = valuesReturned[0];
      // String productBarcode = valuesReturned[1];
      productAllergens = valuesReturned[2];
      productAllergens =
          productAllergens.map((allergen) => allergen.toLowerCase()).toList();
      print("Product allergens: $productAllergens");
    } else {
      print(productResponse.reasonPhrase);
    }

    // Comparer
    userAllergens.forEach((element) {
      if (productAllergens.contains(element)) {
        isSafeToEat = false;
      }
    });

    // Boîte de dialogue après chaque scan
    // Afficher le dialogue si le scan est continu, afficher le toast sinon
    if (isSafeToEat) {
      if (isContinuous) {
        Alert(
          context: context,
          title: "Safe",
          desc: "Pas d'allergènes détéctés!",
          type: AlertType.success,
          buttons: [
            DialogButton(
              onPressed: () => {
                Navigator.pop(context),
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AllergenDetailsScreen(
                              userAllergens: userAllergens,
                              productAllergens: productAllergens,
                            )))
              },
              width: 120,
              child: const Text("Détails"),
            )
          ],
        ).show();
      } else {
        Fluttertoast.showToast(
            msg: "Pas d'allergènes détéctés !",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      if (isContinuous) {
        /*Alert(
          context: context,
          title: "Attention",
          desc: "Allergènes détéctés!",
          type: AlertType.error,
          buttons: [
            DialogButton(
              onPressed: () => {
                Navigator.pop(context),
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AllergenDetailsScreen(
                              userAllergens: userAllergens,
                              productAllergens: productAllergens,
                            )))
              },
              width: 120,
              child: const Text("Détails"),
            )
          ],
        ).show();*/
        QuickAlert.show(
          context: context,
          type: QuickAlertType.warning,
          confirmBtnText: "Détails",
          confirmBtnColor: buildMaterialColor(Color(0xff00bd7e)),
        ); // That's it to display an alert, use other properties to customize.
      } else {
        Fluttertoast.showToast(
            msg: "Attention, allergènes présents!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  // Unique scan
  Future<void> barcodeScan() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Annuler', true, ScanMode.BARCODE);
      queryAllergens(barcodeScanRes, true);
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
      queryAllergens(barcode, false);
    });
  }

  // Query API
  void queryAllergens(String barcodeScanRes, bool isContinuous) {
    User? firebaseUser = MyApp.firebaseUser;
    firebaseUser?.getIdTokenResult(true).then((value) {
      firebaseToken = value.token;
      print("firebaseToken $firebaseToken");
      testAllergies(firebaseToken, barcodeScanRes, isContinuous);
    });
    //return "a";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Scanner un produit'),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Text("Bonjour ${MyApp.firebaseUser?.email} !"),
              // Text("Contenu du code-barres: $_scanBarcode"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Row(children: [
                        ElevatedButton(
                          onPressed: () async {
                            barcodeScan();
                          },
                          child: const Text('Scan unique'),
                        )
                      ]),
                      Row(children: [
                        ElevatedButton(
                          onPressed: () async {
                            startBarcodeScanStream();
                          },
                          child: const Text('Scan continu'),
                        ),
                      ])
                    ],
                  )
                ],
              )
            ])));
  }
}

// ignore: must_be_immutable
class AllergenDetailsScreen extends StatelessWidget {
  List userAllergens;
  List productAllergens;

  AllergenDetailsScreen(
      {super.key, required this.userAllergens, required this.productAllergens});

  @override
  Widget build(BuildContext context) {
    print("userAllergens: $userAllergens");
    print("productAllergens: $productAllergens");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails du scan'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child:
                    Column(children: createUserAllergensColumn(userAllergens)),
              ),
              Expanded(
                child: Column(
                    children: createProductAllergensColumn(productAllergens)),
              )
            ],
          ),
        ],
      )),
    );
  }

  // Générer les widgets à afficher sur la page détaillant les allergènes
  createUserAllergensColumn(userAllergens) {
    var userAllergensColumn = <Widget>[];

    userAllergensColumn.add(
      const Text(
        "Vos allergènes",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
    );
    userAllergens.forEach((allergen) {
      var textWidget = Text(allergen);
      return userAllergensColumn.add(textWidget);
    });
    return userAllergensColumn;
  }

  createProductAllergensColumn(productAllergens) {
    var productAllergensColumn = <Widget>[];
    productAllergensColumn.add(
      const Text(
        "Allergènes du produit",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
    );
    productAllergens.forEach((allergen) {
      var textWidget = Text(allergen);
      return productAllergensColumn.add(textWidget);
    });
    return productAllergensColumn;
  }
}
