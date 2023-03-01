// ignore_for_file: use_build_context_synchronously, must_be_immutable, avoid_function_literals_in_foreach_calls, avoid_print, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quickalert/quickalert.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

String barcodeNutella = "3017620422003";

String apiBaseUrl = "http://vps-6d160f31.vps.ovh.net:8082/dishapi/";

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
        primarySwatch: buildMaterialColor(const Color(0xff00bd7e)),
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

  //void sendResetPasswordMail(String mail) {}

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
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)))),
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
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        QuickAlert.show(
          title: "Oups ...",
          text: "Cette adresse mail n'est associée à aucun utilisateur.",
          context: context,
          type: QuickAlertType.error,
          confirmBtnText: "Retour",
          confirmBtnColor: buildMaterialColor(const Color(0xff00bd7e)),
        );
        print('FirebaseAuthException: No user found for that email.');
      } else if (e.code == 'wrong-password') {
        QuickAlert.show(
          title: "Oups ...",
          text: "Mot de passe invalide.",
          context: context,
          type: QuickAlertType.error,
          confirmBtnText: "Retour",
          confirmBtnColor: buildMaterialColor(const Color(0xff00bd7e)),
        );
        print('FirebaseAuthException: Wrong password provided.');
      } else if (e.code == 'user-disabled') {
        QuickAlert.show(
          title: "Oups ...",
          text: "Ce compte utilisateur a été désactivé par un administrateur.",
          context: context,
          type: QuickAlertType.error,
          confirmBtnText: "Retour",
          confirmBtnColor: buildMaterialColor(const Color(0xff00bd7e)),
        );
        print(
            "FirebaseAuthException: The user account has been disabled by an administrator.");
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
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              repeat: ImageRepeat.repeat,
              image: Svg(
                'assets/svg/i-like-food.svg',
                color: Colors.green,
              ),
            ),
          ),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: SizedBox(
                    height: 250,
                    width: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 280,
                          child: TextField(
                            controller: usernameTextController,
                            obscureText: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Adresse mail',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        SizedBox(
                          width: 280,
                          child: TextField(
                            controller: passwordTextController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Mot de passe',
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)))),
                                onPressed: () async {
                                  print("Login button pressed");
                                  User? firebaseUser =
                                      await signInUsingEmailPassword(
                                          email: usernameTextController.text,
                                          password: passwordTextController.text,
                                          context: context);

                                  if (firebaseUser == null) {
                                    print("firebaseUser null");
                                  } else {
                                    print(
                                        "firebaseUser ${usernameTextController.text} connected");

                                    MyApp.firebaseUser = firebaseUser;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ScanScreen()));
                                  }
                                },
                                child: const Text('Se connecter'),
                              ),
                            ]),
                            const SizedBox(width: 10),
                            Column(children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)))),
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
                  )),
            ],
          )),
        ));
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
      String? firebaseToken, String barcodeScanRes, bool isUnique) async {
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

    // Si l'API renvoie un statusCode 200, la requête est bien passée
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

      // Comparer
      userAllergens.forEach((element) {
        if (productAllergens.contains(element)) {
          isSafeToEat = false;
        }
      });

      // Boîte de dialogue après chaque scan
      // Afficher le dialogue si le scan est continu, afficher le toast sinon
      if (isSafeToEat) {
        if (isUnique) {
          QuickAlert.show(
            title: "Sûr!",
            text: "Pas d'allergènes détéctés!",
            context: context,
            type: QuickAlertType.success,
            confirmBtnText: "Détails",
            confirmBtnColor: buildMaterialColor(const Color(0xff00bd7e)),
            onConfirmBtnTap: () => {
              Navigator.pop(context),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AllergenDetailsScreen(
                            userAllergens: userAllergens,
                            productAllergens: productAllergens,
                          )))
            },
          );
        } else {
          Fluttertoast.showToast(
              msg: "Pas d'allergènes détéctés !",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.black,
              fontSize: 16.0);
        }
      } else {
        if (isUnique) {
          QuickAlert.show(
            text: "Allergènes détéctés!",
            title: "Attention!",
            context: context,
            type: QuickAlertType.warning,
            confirmBtnText: "Détails",
            confirmBtnColor: buildMaterialColor(const Color(0xff00bd7e)),
            onConfirmBtnTap: () => {
              Navigator.pop(context),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AllergenDetailsScreen(
                            userAllergens: userAllergens,
                            productAllergens: productAllergens,
                          )))
            },
          );
        } else {
          Fluttertoast.showToast(
              msg: "Attention, allergènes présents!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    }
    // mail admin: matg29@protonmail.com
    // Sinon il y a erreur. Générer un popup d'erreur
    else {
      if (isUnique) {
        QuickAlert.show(
          text: "Nous avons rencontré une erreur, veuillez réessayer.",
          title: "Oups ...",
          context: context,
          type: QuickAlertType.error,
          confirmBtnText: "Retour",
          confirmBtnColor: buildMaterialColor(const Color(0xff00bd7e)),
        );
      } else {
        Fluttertoast.showToast(
            msg: "Nous avons rencontré une erreur, veuillez réessayer.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.orange,
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
  void queryAllergens(String barcodeScanRes, bool isUnique) {
    User? firebaseUser = MyApp.firebaseUser;
    firebaseUser?.getIdTokenResult(true).then((value) {
      firebaseToken = value.token;
      print("firebaseToken $firebaseToken");
      if (barcodeScanRes == "-1") {
        print("Nothing scanned");
      } else {
        testAllergies(firebaseToken, barcodeScanRes, isUnique);
      }
    });
    //return "a";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dish'),
        ),
        body: Center(
            child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              repeat: ImageRepeat.repeat,
              image: Svg(
                'assets/svg/i-like-food.svg',
                color: Colors.green,
              ),
            ),
          ),
          //color: Colors.yellow,
          child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Text("Bonjour ${MyApp.firebaseUser?.displayName} !"),
                // Text("Contenu du code-barres: $_scanBarcode"),
                Card(
                  //margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  margin: const EdgeInsets.all(20),
                  clipBehavior: Clip.antiAlias,
                  //elevation: 5,
                  child: Container(
                    margin: const EdgeInsets.all(6),
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                //color: Colors.black54,
                                child: const Text("Bienvenue sur Dish!",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    )),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                //color: Colors.black54,
                                child: const Text(
                                    "On ne mange pas n'importe quoi !",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    )),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                //color: Colors.black54,
                                child: const Text(
                                    "Le but du projet a été de développer un service en réalité augmentée permettant d'identifier facilement si un produit alimentaire contient des allergènes.",
                                    textAlign: TextAlign.justify),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                //color: Colors.black54,
                                child: const Text("Développement web",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    )),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                //color: Colors.black54,
                                child: const Text(
                                    "Nous avons développé et déployé une application web de gestion des abonnés au service. À partir de cette interface, il est possible de gérer les droits d'utilisation, de télécharger l'application mobile, de configurer ses allergènes, de lire la FAQ associée au service ou encore de contacter les développeurs du service. Chaque client doit avoir un compte sur le serveur pour pouvoir utiliser le service avec son smartphone.",
                                    textAlign: TextAlign.justify),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                //color: Colors.black54,
                                child: const Text("Développement Android",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    )),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                //color: Colors.black54,
                                child: const Text(
                                    "Nous avons également développé cette application Android pour que les utilisateurs puissent scanner le code-barre des aliments, puis être alertés si ces éléments contiennent des allergènes que l'utilisateur ne tolère pas et qu'il aura renseigné à l'avance sur le portail web du service.",
                                    textAlign: TextAlign.justify),
                              ),
                            ),
                          ],
                        ))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                      //color: Colors.red,
                      ),
                ),
                Center(
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    //elevation: 5,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "connecté en tant que ${MyApp.firebaseUser?.displayName}",
                              style: const TextStyle(
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Column(children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15)))),
                                    onPressed: () async {
                                      barcodeScan();
                                    },
                                    child: const Text('Scan unique'),
                                  )
                                ]),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15)))),
                                    onPressed: () async {
                                      startBarcodeScanStream();
                                    },
                                    child: const Text('Scan continu'),
                                  ),
                                ])
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ]),
        )));
  }
}

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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            repeat: ImageRepeat.repeat,
            image: Svg(
              'assets/svg/i-like-food.svg',
              color: Colors.green,
            ),
          ),
        ),
        child: Card(
            margin: const EdgeInsets.all(20),
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  createDetailsWidgets(userAllergens, productAllergens)
                ]
              ),
            )),
      ),
    );
  }

  createDetailsWidgets(userAllergens, productAllergens) {
    var userAllergensColumn = <Widget>[];
    userAllergensColumn.add(
      const Text(
        "Vos allergènes",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
    );

    var productAllergensColumn = <Widget>[];
    productAllergensColumn.add(
      const Text(
        "Allergènes du produit",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
    );

    userAllergens.forEach((allergen) {
      if(productAllergens.contains(allergen)) {
        var textWidget = Text(allergen, style: const TextStyle(color: Colors.red));
        return userAllergensColumn.add(
          textWidget
        );
      }
      else {
        var textWidget = Text(allergen);
        return userAllergensColumn.add(textWidget);
      }
    });

  productAllergens.forEach((allergen) {
    if(userAllergens.contains(allergen)) {
      var textWidget = Text(allergen, style: const TextStyle(color: Colors.red));
      return productAllergensColumn.add(
          textWidget
      );
    }
    else {
      var textWidget = Text(allergen);
      return productAllergensColumn.add(textWidget);
    }
  });

  var row = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Column(
        children: userAllergensColumn,
      )),
      Expanded(child: Column(
        children: productAllergensColumn,
      )),
    ],
  );
  
  return row;
  }
}
