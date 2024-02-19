//
//  MovieQuizPresenterTests.swift
//  MovieQuizTests
//
//  Created by Вадим Дзюба on 20.02.2024.
//

import Foundation
import XCTest
@testable import MovieQuiz

final class MovieQuizViewControllerMock: MovieQuizViewControllerProtocol {
    var presenter: MovieQuiz.AlertPresenterProtocol?
    
    func highlightImageBorder(isCorrect: Bool) {
        
    }
    
    func blockingButtons() {
        
    }
    
    func showAlert(alert: MovieQuiz.AlertModel?) {
        
    }
    
    func show(quiz step: QuizStepViewModel) {
        
    }
    
    func showLoadingIndicator() {
        
    }
    
    func hideLoadingIndicator() {
        
    }
    
    func showNetworkError(message: String) {
        
    }
}

final class MovieQuizPresenterTests: XCTestCase {
    func testPresenterConvertModel() throws {
        let viewControllerMock = MovieQuizViewControllerMock()
        let sut = MovieQuizPresenter(viewController: viewControllerMock)
        
        let emptyData = Data()
        let question = QuizQuestion(image: emptyData, text: "Question Text", correctAnswer: true)
        let viewModel = sut.convert(model: question)
        
        XCTAssertNotNil(viewModel.image)
        XCTAssertEqual(viewModel.question, "Question Text")
        XCTAssertEqual(viewModel.questionNumber, "1/10")
    }
} 
