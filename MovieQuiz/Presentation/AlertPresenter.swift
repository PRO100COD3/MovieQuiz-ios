//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Вадим Дзюба on 31.01.2024.
//

import Foundation
import UIKit

class AlertPresenter: AlertPresenterProtocol{
    var delegate: AlertPresenterDelegate?
    var statistic = StatisticServiceImplementation()
    func show(alert: AlertModel, action: UIAlertAction){
        DispatchQueue.main.async { [weak self] in
            let message = alert.message
            let newAlert = UIAlertController(
                title: alert.title,
                message: message,
                preferredStyle: .alert)
            newAlert.view.accessibilityIdentifier = "Game results"
            
            
            newAlert.addAction(action)
            
            
            self?.delegate?.showAlert(newAlert: newAlert)
            
        }
    }
}
