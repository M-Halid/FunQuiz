//
//  ContentView.swift
//  FunQuiz
//
//  Created by Muhammed Halid Kutsal on 16.12.23.
//

import SwiftUI

struct QuizView: View {
    @State var score = 0
    @State var quizIndex = 0
    @State private var correctAnswerTapped = false
    @State private var wrongAnswerTapped = false
    @State private var wrongAnswer = ""
    @State var quiz: Quiz
    @State var categoryName: String
    @State var shuffledOptions:Array<String>
    @Environment(\.dismiss) var dismiss
 
    //29 for a button limit with font title 3
    //ca. 50 for the question
    
    var body: some View {
    
            VStack {
              /*  if quiz.id == "1"{
                   ProgressView().onAppear(perform: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            quiz = QuizViewModel.getQuizElement()
                            shuffledOptions = QuizViewModel.prepareOptions(quiz: quiz)
                        }
                    })
                   
                }else {*/
                    Spacer()
                    Text(" \(quiz.question.text )")
                        .font(.title)
                        .padding()
                    Spacer()
                    
                    ForEach(0..<4) { index in
                        HStack {
                            Button(shuffledOptions[index]) {
                                if shuffledOptions[index] == quiz.correctAnswer {
                                    correctAnswerTapped = true
                                    quizIndex += 1
                                    score += 1
                                } else{
                                    wrongAnswerTapped = true
                                    wrongAnswer = quiz.incorrectAnswers[quiz.incorrectAnswers.firstIndex(of: shuffledOptions[index]) ?? 0]
                                    quizIndex += 1
                                }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                      
                                        
                                        quiz = QuizViewModel.getQuizElement(quizIndex: quizIndex)
                                        shuffledOptions = QuizViewModel.prepareOptions(quiz: quiz)
                                        correctAnswerTapped = false
                                        wrongAnswerTapped = false
                                        
                                    }
                               
                            }.disabled(correctAnswerTapped)
                                .frame(width: 300, height: 30)
                                .padding()
                                .background(correctAnswerTapped ? (shuffledOptions[index] == quiz.correctAnswer ? Color.green : Color.blue) : (wrongAnswerTapped ? (shuffledOptions[index] == wrongAnswer ? Color.red : Color.blue) : Color.blue))
                                .foregroundColor(.white)
                                .cornerRadius(25)
                                .font(.title3)
                        }
                        
                    
                }
                Spacer()
            }.navigationTitle(categoryName)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Text("\(score)").font(.largeTitle)
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Image(systemName: "chevron.backward").font(.title).onTapGesture {
                        dismiss()
                    }
                }
            }
        .navigationBarBackButtonHidden(true)
        
            }
        }
    


#Preview {
    QuizView(quiz: QuizViewModel.dummyQuiz, categoryName: "music", shuffledOptions: QuizViewModel.dummyQuiz.incorrectAnswers )
}
/*
 viewModel.fetchAllQuizzesFromFirestore(category: selectedCat){ error in
     if let error = error {
         // Handle the error (e.g., show an alert to the user)
         print("Failed to fetch quizzes: \(error.localizedDescription)")
     }
 }
 


 label :{
                    Text("\(option)")
                        .frame(width: 200, height: 50)
                        .padding()
                        .background(correctAnswer ?  Color.green : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }}
        }}
    }




 
 


import SwiftUI

struct QuizDetailView: View {
    @ObservedObject var DviewModel: QuizDetailViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(" \(DviewModel.quiz.question.text)")
                .font(.headline)
                .padding()

            ForEach(DviewModel.shuffledOptions, id: \.self) { option in
                Button(action: {
                    DviewModel.checkAnswer(selectedOption: option)
            
                    print("Selected option: \(option)")
                }) {
                    Text(option)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(DviewModel.trueOption ? Color.blue : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        .navigationTitle(DviewModel.quiz.category)
    }
}


ScrollView{
    LazyVStack{
        ForEach(viewModel.quizzes) { quiz in
            NavigationLink(destination: QuizDetailView(quiz: quiz)) {
                VStack(alignment: .leading) {
                    Text("Category: \(quiz.category)")
                        .font(.headline)
                    Text("Difficulty: \(quiz.difficulty)")
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}
}}

 Button {
 //viewModel.fetchQuizzes()
  //viewModel.performActionWithDelay()
  //viewModel.saveQuizzesToFirestore()
 viewModel.fetchQuizzesFromFirestore()
} label: {
  Text("Fetch Data")
  
}.buttonStyle(.borderedProminent)

*/


