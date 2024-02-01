import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int currentQuestionIdex = 0;
  String? selectedAnswer;
  bool? isCorrect;

  final List<Map<String, dynamic>> questions = [
    {
    'question':  'Quantos estômagos tem os golfinhos?',
      'answers': ['1', '2', '3', '4'],
      'correctAnswer': '2',
    },
    {
    'question':  'Qual é o maior oceano, em quilômetros quadrados (km²), da superfície terrestre?',
      'answers': [
        'Oceano Índico',
         'Oceano Pacífico',
          'Oceano atlântico',
           'Oceano Glacial Ártico'
        ],
      'correctAnswer': 'Oceano Pacífico',
    },
  ];

  void nextQuestion() {
    if(currentQuestionIdex < questions.length - 1){
      setState(() {
        currentQuestionIdex++;
      });
    }
  }

  void handleAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
      isCorrect = answer == questions[currentQuestionIdex]['correctAnswer'];
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        selectedAnswer = null;
        isCorrect = null;
        if(currentQuestionIdex < questions.length - 1) {
          currentQuestionIdex++;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentQuestion = questions[currentQuestionIdex];
    return Scaffold(
      appBar: AppBar(title: Text('Quiz marítimo!', style: GoogleFonts.roboto(fontWeight: FontWeight.bold))
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            color: Colors.deepPurple[50],
            width: double.infinity,
            height: 400,
            child: Center(
              child: Text(currentQuestion['question'],
               style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 18),     
              ),
            ),
          ),
          Wrap(
            children: currentQuestion['answers'].map<Widget>((resposta){
              bool isSelected = selectedAnswer == resposta;
              Color? buttonColor;
              if(isSelected){
                buttonColor = isCorrect! ? Colors.green : Colors.red;
                isCorrect!? print('acertou') : print("erro");
              }

              return meuBtn(resposta, () => handleAnswer(resposta), buttonColor);
            })
            .toList(),
          )
        ],
        ),
    );
  }
}

Widget meuBtn(String resposta, VoidCallback onPressed, Color? color) =>
 Container(
  margin: const EdgeInsets.all(16),
  width: 160,
  child: ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
    ),
    child: Text(resposta),
  ),
);