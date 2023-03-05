import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:squatva/models/models.dart';
import 'package:squatva/services/auth_service.dart';

class ExerciseDatabase {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final CollectionReference _collectionRef = _db.collection('exercises');

  static Future create(BuildContext context, {required Exercise exercise}) async {
    DocumentReference _docRef = _collectionRef.doc();

    Exercise newExercise = exercise.copy(id: _docRef.id);

    await _docRef.set(newExercise.toJSON());
  }

  static Future<List<Exercise>> readMyExercises(BuildContext context) async {
    Query query = _collectionRef.where(ExerciseFields.userID, isEqualTo: AuthService.currentUserId);
    QuerySnapshot querySnapshot = await query.get();

    List<Exercise> exerciseList = [];

    for (var doc in querySnapshot.docs) {
      Exercise exercise = Exercise.fromJSON(doc.data());
      exerciseList.add(exercise);
    }

    return exerciseList;
  }

  static Future read(BuildContext context) async {}
  static Future update(BuildContext context) async {}
  static Future delete(BuildContext context) async {}
}
