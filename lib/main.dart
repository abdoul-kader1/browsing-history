import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_web/modeles/commande_m.dart';
import 'package:navigation_web/page_one.dart';
import 'package:navigation_web/page_two.dart';
import 'package:url_strategy/url_strategy.dart';
import 'observer.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
        routerConfig: GoRouter(
            initialLocation:'/',
            routes: [
              ShellRoute(
                  observers: [RouteObservers()],
                  routes: [
                    GoRoute(path: '/',builder: (context,state)=>const MyHomePage(title: 'Flutter Demo Home Page')),
                    GoRoute(path: '/page-one',builder: (context,state)=>PageOne()),
                    GoRoute(path: '/page-two',builder: (context,state)=>PageTwo(commande: state.extra as CommandeModele)),
                  ],
                  builder: (context,state,child){
                    return Scaffold(
                      body: Row(
                        children: [
                          Expanded(
                            flex: 2,
                              child: Container(
                                color: Colors.brown,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(onPressed: (){context.go("/");}, child: Text("MyHomePage")),
                                    const SizedBox(height: 10),
                                    ElevatedButton(onPressed: (){context.go("/page-one");}, child: Text("page one")),
                                  ],
                                ),
                              )
                          ),
                          Expanded(
                              flex: 10,
                              child: Container(
                                child: child,
                              )
                          )
                        ],
                      ),
                    );
                  }
              ),
            ]
        )
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'My home page',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
