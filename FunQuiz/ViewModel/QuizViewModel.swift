//
//  QuizViewModel.swift
//  FunQuiz
//
//  Created by Muhammed Halid Kutsal on 16.12.23.
//import Foundation
import Firebase
import SwiftUI

class QuizViewModel: ObservableObject {
     static var quizzes: [Quiz] = []
    static var collectionNames = ["society and culture",
                                  "arts and literature",
                                      "film and tv",
                                      "food and drink",
                                      "general knowledge",
                                      "geography",
                                      "history",
                                      "music",
                                      "science",
                                      "sport and leisure"]
    @Published var shuffledOptions: [String] = []
    @Published var trueOption = ""
    @Published var correctAnswer = false
    
    static func fetchAllQuizzesFromFirestore(category:String ,completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        
        var fetchedQuizzes: [Quiz] = []
        
        
        db.collection(category).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents from collection \(category): \(error)")
                completion(error)
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No documents in collection \(category)")
                completion(nil)
                return
            }
            
            let quizzesInCollection: [Quiz] = documents.compactMap { document in
                do {
                    let quiz = try document.data(as: Quiz.self)
                    return quiz
                } catch {
                    print("Error decoding quiz document in collection \(category): \(error)")
                    return nil
                }
            }
            
            fetchedQuizzes.append(contentsOf: quizzesInCollection)
            
            let filteredQuizzes = fetchedQuizzes.filter { $0.question.text.count <= 90 }
            
            var uniqueQuizzes: [Quiz]  = []
            
            for quiz in filteredQuizzes {
                if !uniqueQuizzes.contains(where: { $0.id == quiz.id }) {
                    if quiz.incorrectAnswers.contains(where: {$0.count>30}) || quiz.correctAnswer.count>30  {
                        continue
                    }
                    else{
                        uniqueQuizzes.append(quiz)
                    }
                }
            }

          
            DispatchQueue.main.async {
                self.quizzes = uniqueQuizzes
                self.quizzes.shuffle()
                completion(nil)
                    
            }
            
        }// Databank
      
    } // fetching
  
    
   
        
    static func getQuizElement(quizIndex:Int) -> Quiz{
        if quizIndex >= quizzes.count{
            return quizzes[quizIndex % quizzes.count]
        }
            return quizzes[quizIndex]
         
    }
    
    
    static func prepareOptions(quiz:Quiz) ->   Array<String>{
        var allOptions = quiz.incorrectAnswers + [quiz.correctAnswer]
                allOptions.shuffle()
              return allOptions
            }
    
    static let dummyQuiz: Quiz = Quiz(
        id: "1",
        category: "music",
        correctAnswer: "Oh Yeah",
        incorrectAnswers: ["False", "Kind of", "Might be!"],
        question: Question(text: "Is the Earth round?"),
        difficulty: "Easy"
    )

}
 
   /*
    class QuizDetailViewModel: ObservableObject {
        
        @ObservedObject var quizViewModel = QuizViewModel()
        @Published var quiz: Quiz
      
        
        init(quiz: Quiz) {
            self.quiz = quiz
            //prepareOptions()
            self.quiz = quizViewModel.quizzes.randomElement()!
        }
        
       
        
       
    }
    

    
     func fetchQuizzes() {
        guard let url = URL(string: "https://the-trivia-api.com/v2/questions/") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error fetching quizzes: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([Quiz].self, from: data)
                DispatchQueue.main.async {
                   self.quizzes = decodedData
                    self.saveQuizzesToFirestore()
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        
        task.resume()
    }
    
    func saveQuizzesToFirestore() {
        let db = Firestore.firestore()
        
        for quiz in self.quizzes {
            if quiz.difficulty == "easy" {
                let collectionName = quiz.category.lowercased().replacingOccurrences(of: " ", with: " ")
                
                // Check if a quiz with the same question text already exists
                let query = db.collection(collectionName)
                    .whereField("question.id", isEqualTo: quiz.id)
                
                query.getDocuments { (querySnapshot, error) in
                    if let error = error {
                        print("Error checking for existing quiz: \(error)")
                        return
                    }
                    
                    guard let documents = querySnapshot?.documents, documents.isEmpty else {
                        print("Quiz with the same question already exists. Skipping.")
                        return
                    }
                    
                    // No existing quiz found, proceed to add the new quiz
                    do {
                        try db.collection(collectionName).addDocument(from: quiz)
                        print("Document added successfully")
                    } catch {
                        print("Error adding document: \(error)")
                    }
                }
            }
        }
    }
    */
    

