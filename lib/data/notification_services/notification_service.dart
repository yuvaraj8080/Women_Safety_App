// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter/material.dart';
// import '../../Widget_Screen/ChildScreeen/Bottom_Screens/ChildHome_Screen.dart';
// import '../../app.dart';
// import '../../utils/constants/image_string.dart';
//
// Future<void> initializeNotification() async {
//   await AwesomeNotifications().initialize(
//     null,
//     [
//       NotificationChannel(
//         channelGroupKey: 'high_importance_channel_group',
//         channelKey: 'high_importance_channel',
//         channelName: 'Basic Notification',
//         channelDescription: 'Notification channel for basic task',
//         defaultColor: Colors.deepPurple,
//         ledColor: Colors.red,
//         importance: NotificationImportance.Max,
//         channelShowBadge: true,
//         onlyAlertOnce: true,
//         playSound: true,
//         criticalAlerts: true,
//       )
//     ],
//     channelGroups: [
//       NotificationChannelGroup(
//         channelGroupkey: 'high_importance_channel_group',
//         channelGroupName: "Group 1",
//       )
//     ],
//     debug: true,
//   );
//
//   await AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
//     if (!isAllowed) {
//       await AwesomeNotifications().requestPermissionToSendNotifications();
//     }
//   });
//
//   // AwesomeNotifications().setListeners(
//   //   onActionReceivedMethod: onActionReceivedMethod,
//   //   onNotificationCreatedMethod: onNotificationCreatedMethod,
//   //   onNotificationDisplayedMethod: onNotificationDisplayedMethod,
//   //   onDismissActionReceivedMethod: onDismissActionReceivedMethod,
//   // );
//
// }
//
// Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
//   final payload = receivedAction.payload ?? {};
//   if (payload['TestResult'] == 'true') {
//     App.navigatorKey.currentState?.push(MaterialPageRoute(
//       builder: (_) => HomeScreen(),
//     ));
//   }
// }
//
// Future<void> onNotificationCreatedMethod(
//     ReceivedNotification notification) async {
//   debugPrint("On Notification Created Method");
// }
//
// Future<void> onNotificationDisplayedMethod(
//     ReceivedNotification receivedNotification) async {
//   debugPrint("On Notification Displayed");
// }
//
// Future<void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {
//   debugPrint("On Notification Dismissed");
// }
//
// Future<void> showNotification({
//   required final String title,
//   required final String body,
//   final String? summary,
//   final Map<String, String>? payload,
//   final NotificationLayout notificationLayout = NotificationLayout.Default,
//   final NotificationCategory? category,
//   final String? bigPicture,
//   final List<NotificationActionButton>? actionButtons,
//   final bool scheduled = false,
//   final int? interval,
// }) async {
//   assert(!scheduled || (scheduled && interval != null));
//   await AwesomeNotifications().createNotification(
//     content: NotificationContent(
//       id: -1,
//       channelKey: 'high_importance_channel',
//       title: title,
//       body: body,
//       notificationLayout: notificationLayout,
//       summary: summary,
//       category: category,
//       payload: payload ?? {'TestResult': 'true'},
//       bigPicture: bigPicture,
//     ),
//     actionButtons: actionButtons ??
//         [
//           NotificationActionButton(
//             key: 'OPEN_TEST',
//             label: 'View Test',
//             autoDismissible: true,
//           ),
//         ],
//     schedule: scheduled
//         ? NotificationInterval(
//       interval: interval!,
//       timeZone: await AwesomeNotifications.localTimeZoneIdentifier,
//       preciseAlarm: true,
//     )
//         : null,
//   );
// }