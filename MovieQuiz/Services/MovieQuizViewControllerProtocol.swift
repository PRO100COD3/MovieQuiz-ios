//
//  MovieQuizViewControllerProtocol.swift
//  MovieQuiz
//
//  Created by Вадим Дзюба on 20.02.2024.
//

import UIKit

protocol MovieQuizViewControllerProtocol: AnyObject {
    var alertPresenter: AlertPresenterProtocol? { get set }
    func show(quiz step: QuizStepViewModel)
    func showAlert(newAlert: UIAlertController?)
    
    func highlightImageBorder(isCorrect: Bool)
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func blockingButtons()
    func showNetworkError(message: String)
}
