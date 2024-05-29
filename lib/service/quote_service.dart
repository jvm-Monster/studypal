import 'dart:convert';

import 'package:http/http.dart' as http;

class QuoteService{

  static Future<Map<String, dynamic>> getQuoteForTheDay() async {
    try{
          final url = Uri.parse('https://favqs.com/api/qotd');
          final response = await http.get(url);

          if (response.statusCode == 200) {
            final Map<String, dynamic> data = json.decode(response.body);
            return data['quote'];
          }else{
             throw "An error occured while getting quote";
          }
   
    }catch(e){
      return {};
    }
  }

 /* static Future<Map<String,dynamic>> getQuoteForTheDay()async{
    final url = Uri.parse('https://favqs.com/api/qotd');

    // Make the GET request
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print('request successfull');
      // Parse the JSON response
      final Map<String, dynamic> data = json.decode(response.body);


      final String qotdDate = data['qotd_date'];
      final Map<String, dynamic> quote = data['quote'];

      // Extract details from the quote map
      final int id = quote['id'];
      final bool dialogue = quote['dialogue'];
      final bool isPrivate = quote['private'];
      final List<String> tags = List<String>.from(quote['tags']);
      final String url = quote['url'];
      final int favoritesCount = quote['favorites_count'];
      final int upvotesCount = quote['upvotes_count'];
      final int downvotesCount = quote['downvotes_count'];
      final String author = quote['author'];
      final String authorPermalink = quote['author_permalink'];
      final String body = quote['body'];

      print('Quote of the Day Date: $qotdDate');
      print('Quote ID: $id');
      print('Quote: "$body" - $author');
      return quote;
    } else {
      print('Failed to fetch quote');
      return {};
    }

  }*/

}


/*
*
*
*   static Future<Map<String, dynamic>> getQuoteForTheDay() async {
    final url = Uri.parse('https://favqs.com/api/qotd');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['quote'];
    } else {
      throw Exception('Failed to load quote');
    }
  }*/


