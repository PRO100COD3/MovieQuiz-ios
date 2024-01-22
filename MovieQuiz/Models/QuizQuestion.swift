//
//  QuizQuestion.swift
//  MovieQuiz
//
//  Created by Вадим Дзюба on 22.01.2024.
//

import Foundation
class QuizQuestion{
    let image: String
    // строка с вопросом о рейтинге фильма
    let text: String
    // булевое значение (true, false), правильный ответ на вопрос
    let correctAnswer: Bool
    init(image: String, text: String, correctAnswer: Bool) {
        self.image = image
        self.text = text
        self.correctAnswer = correctAnswer
    }
    
}
