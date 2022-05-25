import 'package:finance/common/index.dart';

enum DatabaseHandlerStatusCode { SUCCESS, FAIL }

class DatabaseHandlerResponse {
  DatabaseHandlerStatusCode statusCode;
  String message;
  String? errorDetails;
  DatabaseHandlerResponse({
    this.statusCode = DatabaseHandlerStatusCode.SUCCESS,
    this.message = "",
    this.errorDetails,
  });

  @override
  String toString() =>
      'DatabaseHandlerResponse(statusCode: $statusCode, message: $message, errorDetails: $errorDetails)';
}

class FirebaseDatabaseUtil {
  DatabaseReference? _inventoryRef;

  DatabaseReference? _cibilArticlesRef;

  static FirebaseDatabaseUtil? _instance;

  static destroyInstance() {
    print("Destroying the current Firebase DB instance.");
    _instance = null;
  }

  FirebaseDatabaseUtil._internal() {
    print("Creating all the refs.");
    FirebaseDatabase database;
    database = FirebaseDatabase.instance;
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);

    _cibilArticlesRef = _inventoryRef!.child("cibil-articles");

    // fcm-tokens/${FirebaseAuth.instance.currentUser!.uid}/ios
  }

  factory FirebaseDatabaseUtil() {
    if (_instance == null) {
      _instance = new FirebaseDatabaseUtil._internal();
    }
    return _instance!;
  }

  DatabaseReference? get inventoryRef => _inventoryRef;

  DatabaseReference? get cibilArticlesRef => _cibilArticlesRef;

  static FirebaseDatabaseUtil? get instance => _instance;
}
