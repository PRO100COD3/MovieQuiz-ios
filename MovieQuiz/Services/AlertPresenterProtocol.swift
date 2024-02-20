//
//  AlertPresenterProtocol.swift
//  MovieQuiz
//
//  Created by Вадим Дзюба on 07.02.2024.
//

import UIKit

protocol AlertPresenterProtocol{
    var delegate: AlertPresenterDelegate? {get set}
    func show(alert: AlertModel, action: UIAlertAction)
}
