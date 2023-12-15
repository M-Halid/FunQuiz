//
//  questionLists.swift
//  FunQuiz
//
//  Created by Muhammed Halid Kutsal on 03.01.24.
//

import SwiftUI

struct questionLists: View {
    @Environment(\.dismiss) var dismiss
 
    var body: some View {
        NavigationView{
            List (QuizViewModel.quizzes){ quiz in
                
                NavigationLink(quiz.question.text){
                    QuizView(quiz: quiz, categoryName: quiz.category, shuffledOptions: QuizViewModel.prepareOptions(quiz: quiz))
                }
            }
        } .navigationBarBackButtonHidden(true)
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Image(systemName: "chevron.backward").font(.title).onTapGesture {
                        dismiss()
                    }
                }
            }
    }
}

#Preview {
    questionLists()
}
