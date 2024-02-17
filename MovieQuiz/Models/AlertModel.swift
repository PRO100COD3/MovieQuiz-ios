//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Вадим Дзюба on 31.01.2024.
//

import Foundation

struct AlertModel{
    var title: String
    var message: String
    var buttonText: String
    func completion(){
        
    }
    init(title: String, message: String, buttonText: String) {
        self.title = title
        self.message = message
        self.buttonText = buttonText
    }
}
