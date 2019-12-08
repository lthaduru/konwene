import 'package:flutter/material.dart';
import 'package:konwene_app/multiform/multi_form.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Konwene',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Konwene'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Card makeDashboardItem(String title, IconData icon) {
    return Card(
        elevation: 1.0,
        margin: new EdgeInsets.all(8.0),
        child: Container(
//          decoration: BoxDecoration(color: Colors.grey),
          decoration: BoxDecoration(color: Color.fromRGBO(225, 225, 225, 1.0)),
          child: new InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MultiForm()),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                    child: Icon(
                  icon,
                  size: 30.0,
                  color: Colors.blue,
                )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(title,
                      style:
                          new TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
        leading: Icon(Icons.person),
        actions: <Widget>[
          Icon(Icons.search),
          Icon(Icons.map),
          Icon(Icons.message),
          Icon(Icons.exit_to_app)
        ],
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
          child: GridView.count(
            crossAxisCount: 2,
            padding: EdgeInsets.all(3.0),
            children: <Widget>[
              makeDashboardItem("Movies", Icons.movie),
              makeDashboardItem("Restaurant", Icons.restaurant),
              makeDashboardItem("Hotels", Icons.hotel),
              makeDashboardItem("Cruise", Icons.directions_boat),
              makeDashboardItem("Book Reading", Icons.library_books),
              makeDashboardItem("Drinks", Icons.local_drink),
              makeDashboardItem('Event', Icons.event)
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Container(
          height: 40.0,
          padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: <Widget>[
              Icon(Icons.person_add),
              Icon(Icons.home),
              Icon(Icons.location_city),
              Icon(Icons.notifications),
            ],
          ),
        ),
      ),
    );
  }
}
