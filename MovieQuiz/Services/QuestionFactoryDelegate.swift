//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Вадим Дзюба on 27.01.2024.
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject {               // 1
    func didReceiveNextQuestion(question: QuizQuestion?)    // 2
    func didLoadDataFromServer() // сообщение об успешной загрузке
    func didFailToLoadData(with error: Error) // сообщение об ошибке загрузки
    func restartGameWithError(message:String)
}
