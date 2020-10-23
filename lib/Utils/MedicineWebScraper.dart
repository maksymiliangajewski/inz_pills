import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart';
import 'package:inz_pills/Models/Medicine.dart';

Future<Medicine> getMedicine() async {
  Medicine medicine;
  var client = Client();
  Response response = await client.get(
      'http://bazalekow.leksykon.com.pl/informacja-o-lekach-Controloc-Control%C2%AE-10278968.html');

  var document = parse(response.body);
  Element name = document.querySelector('div.name');
  List<Element> titles = document.querySelectorAll('span.descr_section');
  List<Element> bodies = document.querySelectorAll('span.descr_body');
  List<RegExp> listOfHeadtitles = [
    RegExp('Wskazania.+'),
    RegExp('Dawkowanie.+'),
    RegExp('Uwagi.+'),
    RegExp('Przeciwwskazania.+'),
    RegExp('Ostrzeżenia specjalne.+'),
    RegExp('Interakcje.+'),
    RegExp('Ciąża i laktacja.+'),
    RegExp('Działania niepożądane.+'),
    RegExp('Przedawkowanie.+'),
    RegExp('Działanie.+'),
    RegExp('Skład.+'),
  ];

  List<String> titlesList = [];
  List<String> descriptionsList = [];

  for (var title in titles) {
    for (var regex in listOfHeadtitles) {
      if (regex.hasMatch(title.text)) {
        titlesList.add(title.text);
      }
    }
  }

  for (var body in bodies) {
    descriptionsList.add(body.text);
  }

  medicine = new Medicine(
    name.text,
    descriptionsList[0],
    descriptionsList[1],
    descriptionsList[2],
    descriptionsList[3],
    descriptionsList[4],
    descriptionsList[5],
    descriptionsList[6],
    descriptionsList[7],
    descriptionsList[8],
    descriptionsList[9],
    descriptionsList[10],
  );

  return medicine;
}
