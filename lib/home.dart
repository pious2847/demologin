// lib/screens/home.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../service/api_service.dart';
import '../widgets/messages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _coursesData = 'Loading...';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchCourses();
  }

  Future<void> _fetchCourses() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final result = await ApiService.getData('/courses/get-All-Courses');
      
      if (result['success']) {
        setState(() {
          _coursesData = result['data'].toString();
        });
      } else {
        ToastMsg.showErrorToast(result['message']);
        setState(() {
          _coursesData = 'Failed to load courses.';
        });
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Courses',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Raw JSON Data:',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _coursesData,
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchCourses,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}