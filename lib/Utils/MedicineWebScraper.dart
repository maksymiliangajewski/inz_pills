import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart';

Future<List<String>> getMedicine(String medicineUrl) async {
  var client = Client();
  Response response = await client.get(medicineUrl);

  var document = parse(response.body);
  List<Element> titles = document.querySelectorAll('span.descr_head');
  List<Element> bodies = document.querySelectorAll('span.descr_body');
  List<RegExp> listOfHeadtitles = [
    RegExp('Wskazania'),
    RegExp('Dawkowanie'),
    RegExp('Uwagi'),
    RegExp('Przeciwwskazania'),
    RegExp('Ostrzeżenia specjalne / Środki ostrożności'),
    RegExp('Interakcje'),
    RegExp('Ciąża i laktacja'),
    RegExp('Działania niepożądane'),
    RegExp('Przedawkowanie'),
    RegExp('Działanie'),
    RegExp('Skład'),
  ];

  List<String> contentList = [];

  for (var regex in listOfHeadtitles) {
    for (int i = 0; i < titles.length; ++i) {
      if (regex.hasMatch(titles[i].text)) {
        contentList.add(titles[i].text + '===' + bodies[i].text);
      }
    }
  }

  return contentList;
}
