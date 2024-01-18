import 'package:flutter/material.dart';
import 'package:responsive_demo/constants.dart';
import 'package:responsive_demo/responsive.dart';
import 'package:responsive_demo/responsive/scale_size.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaleFactor: ScaleSize.textScaleFactor(context)),
          child: const MyHomePage(title: 'Flutter Demo Responsive Page')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _buildTextField(placeholder, width) => SizedBox(
        width: width,
        height: 50,
        child: TextField(
          // style: TextStyle(fontSize: 10),
          decoration: InputDecoration(
              hintText: placeholder, border: OutlineInputBorder()),
        ),
      );

  _getDeviceText() => Responsive.isMobile(context)
      ? 'Mobile'
      : Responsive.isTablet(context)
          ? "Tablet"
          : "Desktop";

  List<Widget> _renderAllChildren(_width, {isMobile = true}) {
    Widget separator = SizedBox(
      width: isMobile ? 0 : 10,
      height: isMobile ? 10 : 0,
    );
    return [
      _buildTextField("First Name", _width),
      separator,
      _buildTextField("Last Name", _width),
      separator,
      _buildTextField("Email Address", _width),
      separator,
      _buildTextField("Phone Number", _width)
    ];
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(children: [
          Text(_getDeviceText()),
          Responsive(
            mobile: Column(
              children: _renderAllChildren(_width),
            ),
            tablet: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTextField("First Name", _width / 2.15),
                  _buildTextField("First Name", _width / 2.15),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTextField("First Name", _width / 2.15),
                  _buildTextField("First Name", _width / 2.15),
                ],
              )
            ]),
            desktop: Row(
              children: _renderAllChildren(_width / 4.4, isMobile: false),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                    Responsive.isMobile(context)
                        ? _width
                        : Responsive.isTablet(context)
                            ? _width * 0.7
                            : 200,
                    50,
                  ),
                  backgroundColor: Colors.blue),
              onPressed: () {},
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ))
        ]),
      ),
    );
  }
}
