//
//  MovieQuizViewControllerProtocol.swift
//  MovieQuiz
//
//  Created by Вадим Дзюба on 20.02.2024.
//

import Foundation

protocol MovieQuizViewControllerProtocol: AnyObject {
    var presenter: AlertPresenterProtocol? { get set }
    func show(quiz step: QuizStepViewModel)
    func showAlert(alert: AlertModel?)
    
    func highlightImageBorder(isCorrect: Bool)
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func blockingButtons()
    func showNetworkError(message: String)
}
