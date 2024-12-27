import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getnombres() async {
  List nombres = [];
  CollectionReference collectionReferencenombres = db.collection('nombres');
  QuerySnapshot Querynombres = await collectionReferencenombres.get();
  
  Querynombres.docs.forEach((documento){
     nombres.add(documento.data());
  });
  return nombres;
}