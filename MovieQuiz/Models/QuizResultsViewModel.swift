//
//  QuizResultsViewModel.swift
//  MovieQuiz
//
//  Created by Вадим Дзюба on 22.01.2024.
//

import Foundation

struct QuizResultsViewModel{
    // строка с заголовком алерта
    let title: String
    // строка с текстом о количестве набранных очков
    let text: String
    // текст для кнопки алерта
    let buttonText: String
    
    init(title: String, text: String, buttonText: String) {
        self.title = title
        self.text =  text
        self.buttonText = buttonText
    }
}
