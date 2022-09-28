import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rxdart/rxdart.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //create our behavior subject every time widget is re-build
   final subject = useMemoized(() => BehaviorSubject<String>(), [key],);
   //dispose of the old subject every time widget is re-build
   useEffect(() => subject.close, [subject],);
    return Scaffold(
      appBar: AppBar(title: StreamBuilder<String>(
        stream: subject.stream.distinct().debounceTime(const Duration(seconds: 1),),
        initialData: 'Please start typing...',
        builder: (context, snapshot) {
            return Text(snapshot.requireData);
        },
      ),),
      body: TextField(
        onChanged: (string) {
          subject.sink.add(string);
        },
      ),
    );
  }
}
