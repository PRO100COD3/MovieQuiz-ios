//
//  AlertPresenterProtocol.swift
//  MovieQuiz
//
//  Created by Вадим Дзюба on 07.02.2024.
//

import Foundation
protocol AlertPresenterProtocol{
    var delegate: AlertPresenterDelegate? {get set}
    func show(cAnswer: Int)
}
