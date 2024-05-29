import 'dart:async';

import 'package:flutter/material.dart';

import '../service/quote_service.dart';

class QuoteWidget extends StatefulWidget {
  const QuoteWidget({super.key});

  @override
  State<QuoteWidget> createState() => _QuoteWidgetState();
}

class _QuoteWidgetState extends State<QuoteWidget> {
  Map<String, dynamic>? _quote;
  String _errorMessage = '';
  
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _fetchQuote();
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _fetchQuote();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _fetchQuote() async {
    try {
      final quote = await QuoteService.getQuoteForTheDay();
      setState(() {
        _quote = quote;
        _errorMessage = '';
       

      });
    } catch (error) {
      setState(() {
        _errorMessage = 'Failed to load quote';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _quote == null
          ? _errorMessage.isNotEmpty
          ? const Text("Could not load quotes")
          : const CircularProgressIndicator()
          : SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Card(
                    child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "“ ${_quote!['body']} ”",
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  '- ${_quote!['author']}',
                  style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                ),
              ],
            ),
                    ),
                  ),
          ),
    );
  }
}
