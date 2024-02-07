//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Вадим Дзюба on 31.01.2024.
//

import Foundation
import UIKit
class AlertPresenter: AlertPresenterProtocol{
    weak var delegate: AlertPresenterDelegate?
    func show(cAnswer: Int) {
        let alert = AlertModel(title: "Раунд окончен!", message: "Ваш результат: " + String(cAnswer) + "/10", buttonText: "Сыграть еще раз")
        delegate?.showAlert(alert: alert)
    }
        //func show(quiz result: QuizResultsViewModel) {
        
        //}
        //let alert1 = AlertModel(title: result.title, message: result.text, buttonText: "Сыграть еще раз")
        //let alert = UIAlertController(
        //        title: result.title,
        //        message: result.text,
        //        preferredStyle: .alert)
        //let action = UIAlertAction(title: result.buttonText, style: .default) {[weak self] _ in
        //        guard let self = self else { return }
        //       self.currentQuestionIndex = 0
        //        self.correctAnswers = 0
        //    questionFactory?.requestNextQuestion()
        //    }
        
        //    alert.addAction(action)
        
        //   self.present(alert, animated: true, completion: nil)
        //}
        
        
    }

