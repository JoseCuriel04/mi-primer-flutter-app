import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          primary: Colors.blueAccent,
          secondary: Colors.orangeAccent,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.blueAccent,
        ),
      ),
      home: const MyHomePage(title: 'Actividad 1 Parcial 2'),
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
  int _counter = 0;
  int _selectedIndex = 0;
  bool _showCounter = true;
  bool _showList = false;
  List<dynamic> _motos = [];

  final List<Map<String, dynamic>> _drawerItems = [
    {'icon': Icons.home, 'title': 'Inicio'},
    {'icon': Icons.list, 'title': 'Lista'},
    {'icon': Icons.credit_card, 'title': 'Tarjeta'},
    {'icon': Icons.image, 'title': 'Imágenes'},
  ];

  final List<Map<String, String>> _images = [
    {
      'path': 'assets/images/images2.jpg',
      'description':
          'Ángel Triste: Una obra de arte que representa la melancolía y la belleza de la tristeza, capturando la esencia de la emoción humana en su forma más pura.'
    },
    {
      'path': 'assets/images/images3.jpg',
      'description':
          'Spider-Man 3: Una película de superhéroes llena de acción y drama, donde Peter Parker enfrenta nuevos desafíos y enemigos, incluyendo el simbionte Venom.'
    },
    {
      'path': 'assets/images/images4.jpg',
      'description':
          'Sad Boyz 4 Life: Un álbum que explora temas de amor, pérdida y superación, con una mezcla de ritmos urbanos y letras emotivas que conectan con el corazón.'
    },
    {
      'path': 'assets/images/images5.jpg',
      'description':
          'Daño al Corazón: Una canción que habla sobre el desamor y el dolor emocional, con una melodía que resuena en el alma y letras que tocan fibras sensibles.'
    },
    {
      'path': 'assets/images/images6.jpg',
      'description':
          'Halo Infinite: La última entrega de la saga Halo, ofreciendo una experiencia de juego épica con gráficos impresionantes y una narrativa envolvente que continúa la lucha del Jefe Maestro.'
    },
    {
      'path': 'assets/images/images7.jpg',
      'description':
          'Dying Light: The Beast: Un emocionante contenido descargable para Dying Light, donde los jugadores enfrentan nuevos y aterradores desafíos en un mundo postapocalíptico lleno de zombis.'
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadMotos();
  }

  Future<void> _loadMotos() async {
    String jsonString = await rootBundle.loadString('assets/motos.json');
    setState(() {
      _motos = json.decode(jsonString);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        _showCounter = true;
        _showList = false;
      } else if (index == 1) {
        _showCounter = false;
        _showList = true;
      } else {
        _showCounter = false;
        _showList = false;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Seleccionaste: ${_drawerItems[index]['title']}'),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  void _showImageDialog(
      BuildContext context, String imagePath, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(imagePath, fit: BoxFit.cover),
                const SizedBox(height: 10),
                Text(
                  description,
                  style:
                      const TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cerrar',
                  style: TextStyle(color: Colors.blueAccent)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _incrementCounter() {
    if (_counter < 20) {
      setState(() {
        _counter++;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Has alcanzado el valor máximo de 20'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  void _decrementCounter() {
    if (_counter > 0) {
      setState(() {
        _counter--;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se permiten números negativos'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  Widget _buildLeftDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.lightBlueAccent],
              ),
            ),
            child: Text(
              'Menú Principal',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ..._drawerItems.map(
            (item) => ListTile(
              leading: Icon(item['icon'], color: Colors.blueAccent),
              title: Text(item['title']),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(_drawerItems.indexOf(item));
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _showCounter
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Jose Luis Curiel Lopez:',
                    style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                  ),
                  Text(
                    '$_counter',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(color: Colors.blueAccent),
                  ),
                ],
              )
            : _showList
                ? ListView.builder(
                    itemCount: _motos.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(_motos[index]['name']),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Has seleccionado: ${_motos[index]['name']}'),
                                backgroundColor: Colors.blueAccent,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  )
                : _selectedIndex == 2
                    ? SingleChildScrollView(
                        child: Center(
                          child: Card(
                            elevation: 4.0,
                            margin: const EdgeInsets.all(16.0),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height *
                                              0.5,
                                    ),
                                    child: Image.asset(
                                      'assets/images/images1.jpg',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      'Yamaha MT-09: Una moto de alto cilindraje con un motor de 847cc, ideal para quienes buscan emociones fuertes y un manejo ágil.',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black87),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : _selectedIndex == 3
                        ? GridView.count(
                            crossAxisCount: 2,
                            padding: const EdgeInsets.all(16.0),
                            childAspectRatio: 1.0,
                            children:
                                List.generate(_images.length, (index) {
                              return GestureDetector(
                                onTap: () {
                                  _showImageDialog(
                                    context,
                                    _images[index]['path']!,
                                    _images[index]['description']!,
                                  );
                                },
                                child: Card(
                                  elevation: 4,
                                  margin: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    _images[index]['path']!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }),
                          )
                        : const Text('Selecciona una opción del menú'),
      ),
      drawer: _buildLeftDrawer(),
      floatingActionButton: _showCounter
          ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.green,
                  onPressed: _incrementCounter,
                  tooltip: 'Incrementar',
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  backgroundColor: Colors.red,
                  onPressed: _decrementCounter,
                  tooltip: 'Decrementar',
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  backgroundColor: Colors.blue,
                  onPressed: _resetCounter,
                  tooltip: 'Restablecer',
                  child: const Icon(Icons.restore),
                ),
              ],
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Lista'),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'Tarjeta',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Imágenes'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
