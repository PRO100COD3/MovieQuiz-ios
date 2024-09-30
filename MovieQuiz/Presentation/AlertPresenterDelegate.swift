//
//  AlertPresenterDelegat.swift
//  MovieQuiz
//
//  Created by Вадим Дзюба on 31.01.2024.
//

import UIKit

protocol AlertPresenterDelegate: AnyObject{
    func showAlert(newAlert: UIAlertController?)
}
