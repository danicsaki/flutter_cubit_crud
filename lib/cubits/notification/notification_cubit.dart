import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationCubit extends Cubit<String> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  NotificationCubit() : super('');

  Future<void> initialize() async {
    try {
      await _firebaseMessaging.requestPermission();
      await _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        final notification = message.notification;
        emit(notification?.body ?? '');
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        final notification = message.notification;
        emit(notification?.body ?? '');
      });
    } catch (e) {
      debugPrint('Failed to configure FCM: $e');
    }
  }
}
