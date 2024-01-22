//
//  QuizStepViewModel.swift
//  MovieQuiz
//
//  Created by Вадим Дзюба on 22.01.2024.
//

import Foundation
import UIKit
public class QuizStepViewModel{
    // картинка с афишей фильма с типом UIImage
    let image: UIImage
    // вопрос о рейтинге квиза
    let question: String
    // строка с порядковым номером этого вопроса (ex. "1/10")
    let questionNumber: String
    init(image: UIImage, question: String, questionNumber: String) {
        self.image = image
        self.question = question
        self.questionNumber = questionNumber
    }
}
