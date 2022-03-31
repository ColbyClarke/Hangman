// import 'package:flutter/material.dart';

// abstract class BaseBloc {
//   BuildContext? context;

//   Future init();

//   Future close();
// }

// class BaseScreen<B> extends StatefulWidget {
//   const BaseScreen(
//       {Key? key,
//       this.title,
//       this.bloc,
//       this.initState,
//       required this.child,
//       this.floatingActionButton,
//       this.onWillPop})
//       : super(key: key);
//   final String? title;
//   final B? bloc;
//   Future init();
//   final Widget child;
//   final Widget? floatingActionButton;
//   final WillPopCallback? onWillPop;

//   @override
//   State<BaseScreen> createState() => _BaseScreenState();
// }

// class _BaseScreenState extends State<BaseScreen> {
//   @override
//   void initState() {
//     super.initState();

//     if (mounted) {
//       if (widget.initState != null) {
//         widget.initState;
//       }
//       // if (widget.bloc.submitState != null && widget.onStateChanged != null) {
//       //   widget.bloc.submitState
//       //       .listen(widget.onStateChanged, onError: widget.onSubmitError);
//       // }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//         onWillPop: () async {
//           // bool pop = true;
//           // if (widget.onWillPop != null) {
//           //   pop = await widget.onWillPop();
//           // }

//           // if (pop == true) {
//           //   ScreenMap().onPop();
//           //   return true;
//           // }
//           return true;
//         },
//         child: Scaffold(
//           appBar: AppBar(
//             // Here we take the value from the HomeScreen object that was created by
//             // the App.build method, and use it to set our appbar title.
//             title: Text(widget.title ?? ""),
//           ),
//           floatingActionButton: widget.floatingActionButton,
//           body: widget.child,
//         ));
//   }
// }
