//
//  AlertPresenterDelegat.swift
//  MovieQuiz
//
//  Created by Вадим Дзюба on 31.01.2024.
//

import Foundation

protocol AlertPresenterDelegate: AnyObject{
    func showAlert(alert: AlertModel?)
}
