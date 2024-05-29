import 'package:shared_preferences/shared_preferences.dart';
import 'package:studypal/memory/user_prefrences/shared_prefrence_services.dart';

class QuoteCache{

  static final SharedPreferences _preferences = SharedPreferencesService.preferences;
  static const String cacheName = "quote_cache_list";

  static Future<bool> caceQuote(String quote)async{
      List<String>? cachedQuoteList = _preferences.getStringList(cacheName);

      cachedQuoteList!.add(quote);
      bool success = await _preferences.setStringList(cacheName, cachedQuoteList);

      if(success){
        return true;
      }else{
        return false;
      }
  }

  static Future<List<String>> getCachedQuoteList()async{
    List<String>? cachedQuoteList = _preferences.getStringList(cacheName);
    if(cachedQuoteList==null||cachedQuoteList.isEmpty){
          return [];
    }
    return cachedQuoteList;
  }

  static Future<void> initializeQuoteCache()async{
      List<String>? cachedQuoteList = _preferences.getStringList(cacheName);
      if(cachedQuoteList==null|| cachedQuoteList.isEmpty){
       await _preferences.setStringList(cacheName,[]);
      }
  }
}