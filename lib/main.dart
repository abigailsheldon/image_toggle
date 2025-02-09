import 'package:flutter/material.dart';

/*
- Initial image displayed using an Image widget
- Toggle button
- Boolean variable to track current image state
- Animation for smooth transitions
 */

// Starts the Flutter app by rendering MyApp
void main() {
  runApp(const MyApp());
}

// Root widget, stateless widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      // Title of the app
      title: 'Image Toggle App',
      theme: ThemeData(
        // Sets the theme
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

    // MyHomePage set as the home screen
      home: const MyHomePage(title: 'Image Toggle App'),
    );
  }
}

// Stateful widget that allows changes in UI over time
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// This class can control animations
// Manages logic of home page
class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  int _counter = 0;
  bool _isFirstImage = true; // Tracks which image is displayed
  late AnimationController _animationController; // Controls animation
  late Animation<double> _fadeAnimation; // Controls fade transition effect
  
  @override
  // Runs once the widget is created
  void initState(){
    super.initState();
    
    _animationController = AnimationController(
      // Prevents unnecessary animations when screen isn't visible
      vsync: this,
      // Duration of animation, set to 0.5s
      duration: const Duration(milliseconds: 500),
    );
    
    // Ease-in-out smooth fade transition
    _fadeAnimation = CurvedAnimation(
      parent: _animationController, 
      curve: Curves.easeInOut,
    );

    _animationController.forward(); // Starts fade-in animation immediately
  }
  

  // Method
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // Method to toggle between two images
  void _toggleImage(){
    _animationController.reverse().then((_){
      setState(() {
        _isFirstImage = !_isFirstImage;
      });
      // Plays fade-in animation
      _animationController.forward();
    });
  }

  // Method to clean up animation resources
  @override
  void dispose(){
    _animationController.dispose();
    super.dispose();
  }

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
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height:30),
            
            FadeTransition(
              opacity: _fadeAnimation,
              child: Image.asset(
                _isFirstImage ? 'assets/image1.png' : 'assets/image2.png',
                width: 200,
                height: 200,
              ),
            ),
            const SizedBox(height: 20),
            
            // Pressing this switches the displayed image
            ElevatedButton(
              onPressed: _toggleImage, 
              child: const Text('Toggle Image'),
            ),
          ],
        ),
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
