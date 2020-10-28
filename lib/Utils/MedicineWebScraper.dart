import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart';

Future<List<String>> getMedicine(String medicineUrl) async {
  var client = Client();
  Response response = await client.get(medicineUrl);

  var document = parse(response.body);
  List<Element> titles = document.querySelectorAll('span.descr_section');
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

  for (var title in titles) {
    for (var regex in listOfHeadtitles) {
      if (regex.hasMatch(title.text)) {
        String text = title.text;
        contentList.add(regex.pattern + '===' + text.split(regex)[1]);
      }
    }
  }

  return contentList;
}
