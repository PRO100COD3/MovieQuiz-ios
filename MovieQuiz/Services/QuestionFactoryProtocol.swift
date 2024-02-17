//
//  QuestionFactoryProtocol.swift
//  MovieQuiz
//
//  Created by Вадим Дзюба on 27.01.2024.
//

import Foundation

protocol QuestionFactoryProtocol {
    func requestNextQuestion()
    var delegate: QuestionFactoryDelegate? { get set }
    func loadData()
}
