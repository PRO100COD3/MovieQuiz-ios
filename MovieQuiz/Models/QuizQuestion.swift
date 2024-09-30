//
//  QuizQuestion.swift
//  MovieQuiz
//
//  Created by Вадим Дзюба on 22.01.2024.
//

import Foundation

struct QuizQuestion{
    let image: Data
    // строка с вопросом о рейтинге фильма
    let text: String
    // булевое значение (true, false), правильный ответ на вопрос
    let correctAnswer: Bool
    init(image: Data, text: String, correctAnswer: Bool) {
        self.image = image
        self.text = text
        self.correctAnswer = correctAnswer
    }
    
}
