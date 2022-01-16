import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection;
import 'package:petswala/Authentication/userClass.dart';
import 'package:petswala/CasualUser/models/productItem.dart';
import 'package:shared_preferences/shared_preferences.dart';

// This is the code where we are requesting to connect to a mongodb atlas cluster and getting a instance, and requesting updates and changes according to our bloc logics.

class DBConnection {
  static DBConnection _instance;

  final String _getConnectionString =
      "mongodb+srv://ayan:abcd1234@clusterzero.nxzak.mongodb.net/Users?retryWrites=true&w=majority";

  Db _db;

  static getInstance() {
    if (_instance == null) {
      _instance = DBConnection();
    }
    return _instance;
  }

  Future<Db> getConnection() async {
    if (_db == null) {
      try {
        _db = await Db.create(_getConnectionString);
        await _db.open();
      } catch (e) {
        print('hfd');
        print(e);
      }
    }
    return _db;
  }

  Future getAllProducts() async {
    if (_db == null) {
      await getConnection();
    }
    dynamic coll1 = _db.collection('Products');
    final products = await coll1.find().toList();
    List<ProductItem> finalList = [];
    var poignant = products.forEach((element) {
      finalList.add(ProductItem(
          name: element['productname'],
          category: 'category',
          price: double.parse(element['price']),
          rating: double.parse(element['quantity']),
          imageUrl: 'assets/cat.png'));
    });
    print(finalList[0].category);
    return finalList;
  }

  Future getShopProducts() async {
    if (_db == null) {
      await getConnection();
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = '';
    if (prefs.containsKey('name')) {
      var name = prefs.getString('name');
      var type = prefs.getString('type');
      print(name);
      print(type);
    }
    dynamic coll1 = _db.collection('Products');
    List products = await coll1.find({"storename": name}).toList();
    List<ProductItem> finalList = [];
    var poignant = products.forEach((element) {
      finalList.add(ProductItem(
          name: element['productname'],
          category: 'category',
          price: double.parse(element['price']),
          rating: double.parse(element['quantity']),
          imageUrl: 'assets/cat.png'));
    });
    return finalList;
  }

  addProduct(productName, price, quantity) async {
    if (_db == null) {
      await getConnection();
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = '';
    if (prefs.containsKey('name')) {
      var name = prefs.getString('name');
      var type = prefs.getString('type');
      print(name);
      print(type);
    }
    await _db.collection('Products').insertOne({
      "productname": productName,
      "storename": name,
      'price': price,
      'quantity': quantity
    }); //add storename and fix address capslock
  }

  addUser(name, email, password) async {
    if (_db == null) {
      await getConnection();
    }

    await _db
        .collection('Users')
        .insertOne({"name": name, "email": email, 'password': password});
  }

  Future getUsers() async {
    if (_db == null) {
      await getConnection();
    }

    dynamic coll1 = _db.collection('Users');
    List products = await coll1.find().toList();
    List<User> finalList = [];
    var poignant = products.forEach((element) {
      finalList.add(User(
          name: element['name'],
          email: element['email'],
          password: element['password']));
    });
    print("final list:");
    return finalList;
  }

  addPet(category, name, age) async {
    if (_db == null) {
      await getConnection();
    }

    await _db
        .collection('Pets')
        .insertOne({"name": name, "category": category, 'age': age});
  }

  changeUsername(curentName, newName) async {
    if (_db == null) {
      await getConnection();
    }

    dynamic coll = _db.collection('Users');

    var u = await coll.findOne({"name": curentName});
    u["name"] = newName;
    await coll.save(u);

    print('user name updated');
  }

  changePassword(curentName, newPassword) async {
    if (_db == null) {
      await getConnection();
    }

    dynamic coll = _db.collection('Users');

    var u = await coll.findOne({"name": curentName});
    u["password"] = newPassword;
    await coll.save(u);

    print('password updated');
  }

  changeEmail(currentName, newEmail) async {
    if (_db == null) {
      await getConnection();
    }

    dynamic coll = _db.collection('Users');

    var u = await coll.findOne({"name": currentName});
    u["email"] = newEmail;
    await coll.save(u);
    print('email updated');
  }

  closeConnection() {
    _db.close();
  }
}
