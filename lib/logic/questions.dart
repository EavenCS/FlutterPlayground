import 'package:flutter_application_1/model/quiz_model.dart';

QuizModel loadQuestion(int questionIndex) {
  List<QuizModel> questionList = [
    QuizModel("Was ist die Hauptstadt von Frankreich?", "Paris", [
      "Lyon",
      "Marseille",
      "Nizza",
    ]),
    QuizModel("Welches Element hat das chemische Symbol O?", "Sauerstoff", [
      "Gold",
      "Silber",
      "Wasserstoff",
    ]),
    QuizModel("In welchem Jahr endete der Zweite Weltkrieg?", "1945", [
      "1939",
      "1941",
      "1944",
    ]),
    QuizModel("Wer schrieb 'Faust'?", "Johann Wolfgang von Goethe", [
      "Friedrich Schiller",
      "Heinrich Heine",
      "Thomas Mann",
    ]),
    QuizModel("Was ist 5 mal 6?", "30", ["11", "35", "15"]),
    QuizModel("Welcher Planet ist der Sonne am nächsten?", "Merkur", [
      "Venus",
      "Erde",
      "Mars",
    ]),
    QuizModel("Wasser siedet bei wie vielen Grad Celsius?", "100", [
      "90",
      "80",
      "120",
    ]),
    QuizModel("Wie viele Kontinente gibt es?", "7", ["5", "6", "8"]),
    QuizModel("Was ist die Quadratwurzel aus 81?", "9", ["8", "7", "3"]),
    QuizModel("Wer malte die Mona Lisa?", "Leonardo da Vinci", [
      "Vincent van Gogh",
      "Pablo Picasso",
      "Claude Monet",
    ]),
    QuizModel("Was ist das größte derzeit lebende Säugetier?", "Blauwal", [
      "Elefant",
      "Giraffe",
      "Pottwal",
    ]),
    QuizModel("Welcher Fluss gilt als der längste der Welt?", "Nil", [
      "Amazonas",
      "Yangtse",
      "Mississippi",
    ]),
    QuizModel("Welches Land gewann die Fußball-WM 2014?", "Deutschland", [
      "Brasilien",
      "Argentinien",
      "Spanien",
    ]),
    QuizModel("Wie viele Tage hat ein Schaltjahr?", "366", [
      "364",
      "365",
      "360",
    ]),
    QuizModel("In welchem Land liegt die Stadt Tokio?", "Japan", [
      "China",
      "Südkorea",
      "Thailand",
    ]),
    QuizModel("Wer gilt als Erfinder des Telefons?", "Alexander Graham Bell", [
      "Thomas Edison",
      "Nikola Tesla",
      "Guglielmo Marconi",
    ]),
    QuizModel("Welcher Ozean ist der größte?", "Pazifischer Ozean", [
      "Atlantischer Ozean",
      "Indischer Ozean",
      "Arktischer Ozean",
    ]),
    QuizModel("Wie viele Planeten hat unser Sonnensystem?", "8", [
      "9",
      "7",
      "10",
    ]),
    QuizModel("Wer schrieb 'Die Verwandlung'?", "Franz Kafka", [
      "Max Frisch",
      "Hermann Hesse",
      "Thomas Mann",
    ]),
    QuizModel("Was ist die chemische Formel von Wasser?", "H2O", [
      "CO2",
      "O2",
      "NaCl",
    ]),
    QuizModel("Welcher Kontinent ist flächenmäßig der größte?", "Asien", [
      "Afrika",
      "Europa",
      "Nordamerika",
    ]),
    QuizModel("Wer war der erste Mensch auf dem Mond?", "Neil Armstrong", [
      "Buzz Aldrin",
      "Michael Collins",
      "Yuri Gagarin",
    ]),
    QuizModel("Was ist 12 geteilt durch 3?", "4", ["3", "6", "2"]),
    QuizModel("Welches Tier ist das schnellste Landtier?", "Gepard", [
      "Löwe",
      "Tiger",
      "Gazelle",
    ]),
    QuizModel("Wie heißt der höchste Berg der Erde?", "Mount Everest", [
      "K2",
      "Kangchendzönga",
      "Lhotse",
    ]),
    QuizModel(
      "In welcher Stadt wurde Jesus laut Überlieferung geboren?",
      "Bethlehem",
      ["Nazareth", "Jerusalem", "Damaskus"],
    ),
    QuizModel(
      "Wer komponierte Beethovens 9. Sinfonie (Ode an die Freude)?",
      "Ludwig van Beethoven",
      ["Johann Sebastian Bach", "Wolfgang A. Mozart", "Franz Schubert"],
    ),
    QuizModel(
      "Welcher Tag markiert den längsten Tag des Jahres auf der Nordhalbkugel?",
      "Sommer-Sonnenwende",
      [
        "Wintersonnenwende",
        "Herbst-Tagundnachtgleiche",
        "Frühlingstagundnachtgleiche",
      ],
    ),
    QuizModel(
      "Welcher Planet ist der größte in unserem Sonnensystem?",
      "Jupiter",
      ["Saturn", "Uranus", "Neptun"],
    ),
    QuizModel("Wer schrieb die 'Harry Potter'-Reihe?", "J. K. Rowling", [
      "Stephen King",
      "G. R. R. Martin",
      "Terry Pratchett",
    ]),
  ];

  return questionList[questionIndex];
}
