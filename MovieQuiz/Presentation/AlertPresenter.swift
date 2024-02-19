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
    var statistic = StatisticServiceImplementation()
    func show(cAnswer: Int) {
        let alert = AlertModel(title: "Раунд окончен!", message: "Ваш результат: " + String(cAnswer) + "/10\n" + statistic.addString(), buttonText: "Сыграть еще раз")
        delegate?.showAlert(alert: alert)
    }
    func show(alert: AlertModel){
        delegate?.showAlert(alert: alert)
    }
}

