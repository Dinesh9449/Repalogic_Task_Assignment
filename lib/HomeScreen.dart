import 'package:flutter/material.dart';
import 'package:flutter_application_assignment/Products/ProductListItems.dart';
import 'package:flutter_application_assignment/Weather/weather_screen.dart';
import 'package:flutter_application_assignment/TODO/TodoScreen.dart';
import 'package:flutter_application_assignment/TicTacToeGame/Tic_Tac_Toe.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Assignment'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildCard(
              context,
              title: 'Weather',
              icon: Icons.cloud,
              color: Colors.blue,
              screen: const WeatherScreen(),
            ),
            _buildCard(
              context,
              title: 'To-Do',
              icon: Icons.check_circle,
              color: Colors.green,
              screen: const Todoscreen(),
            ),
            _buildCard(
              context,
              title: 'Game',
              icon: Icons.games,
              color: Colors.orange,
              screen: const TicTacToeScreen(),
            ),
            _buildCard(
              context,
              title: 'Products',
              icon: Icons.shopping_cart,
              color: Colors.purple,
              screen: const ProductListItems(),
            ),
          ],
        ),
      ),

      /*  ListView(
        children: [
          _buildTile(
            context,
            title: 'Weather Forecast',
            icon: Icons.cloud,
            screen: const WeatherScreen(),
          ),
          _buildTile(
            context,
            title: 'To-Do App',
            icon: Icons.check_circle_outline,
            screen: const Todoscreen(),
          ),
          _buildTile(
            context,
            title: 'Game',
            icon: Icons.games,
            screen: const TicTacToeScreen(),
          ),
          _buildTile(
            context,
            title: 'Products',
            icon: Icons.shopping_cart,
            screen: const ProductListItems(),
          ),
        ],
      ),*/
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required Widget screen,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: color.withOpacity(0.1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: color,
              child: Icon(icon, color: Colors.white, size: 30),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildTile(
  BuildContext context, {
  required String title,
  required IconData icon,
  required Widget screen,
}) {
  return Card(
    margin: const EdgeInsets.all(12),
    child: ListTile(
      leading: Icon(icon, size: 30),
      title: Text(title, style: const TextStyle(fontSize: 18)),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
      },
    ),
  );
}
