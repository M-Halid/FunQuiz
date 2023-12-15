//
//  QuizView.swift
//  FunQuiz
//
//  Created by Muhammed Halid Kutsal on 17.12.23.
//

import SwiftUI

struct MenuView: View {
    @State private var selectedCategoryIndex = 0
    @State private var selectedCategoryName = ""
    @State private var categorySelected = false
    @State private var progressView = false
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

   
    var body: some View {
        NavigationView {
            VStack {
                
                Picker("Select a Category", selection: $selectedCategoryIndex) {
                    ForEach(0..<QuizViewModel.collectionNames.count, id: \.self) { index in
                        Text(QuizViewModel.collectionNames[index]).textCase(.uppercase)
                    }
                }.onChange(of: selectedCategoryIndex, {
                    categorySelected = false
                }).pickerStyle(.wheel)
                
                
                Button{
                    progressView = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5 ) {
                        categorySelected = true
                        progressView = false
                    }
                    
                    selectedCategoryName = QuizViewModel.collectionNames[selectedCategoryIndex]
                    QuizViewModel.fetchAllQuizzesFromFirestore(category: selectedCategoryName) { error in
                        if let error = error {
                            print("Failed to fetch quizzes: \(error.localizedDescription)")
                        }
                    }
                }label:{
                    Image(systemName: categorySelected ? "checkmark.circle.fill" : "checkmark.circle").foregroundColor(.green).font(.largeTitle)
                }.padding()
                Spacer()
                if progressView { ProgressView() }
                if categorySelected{
                        NavigationLink("Start Quiz" ){
                            let quiz: Quiz = QuizViewModel.getQuizElement(quizIndex: 0)
                            let shuffledOptions = QuizViewModel.prepareOptions(quiz: quiz)
                            QuizView(quiz: quiz, categoryName: selectedCategoryName, shuffledOptions: shuffledOptions)
                        }
                        .frame(width: 300, height: 30)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        .font(.title3)
                        
                    
                    }
                
                Spacer()
            
            }.onAppear(perform: {
                categorySelected = false
            })
        }
            .padding()
            .navigationTitle("Quiz Categories")
            .navigationBarBackButtonHidden(true)
        }
    }


#Preview {
    MenuView()
}
