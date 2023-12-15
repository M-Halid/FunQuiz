//
//  QuizModel.swift
//  FunQuiz
//
//  Created by Muhammed Halid Kutsal on 16.12.23.
//

import Foundation
import FirebaseFirestoreSwift

struct Quiz: Codable, Identifiable {
   let id: String
   //@DocumentID var id: String?
    let category: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    let question: Question
    let difficulty: String
   /* let tags: [String]
    let type: String
    let regions: [String]
    let isNiche: Bool*/

    enum CodingKeys: String, CodingKey {
        case id
        case category
        case correctAnswer
        case incorrectAnswers
        case question
        case difficulty
      /*  case tags
        case type
       
        case regions
        case isNiche*/
    }
}

struct Question: Codable {
    let text: String
}
