//
//  MovieQuizPresenter.swift
//  MovieQuiz
//
//  Created by Вадим Дзюба on 20.02.2024.
//

import UIKit

final class MovieQuizPresenter: QuestionFactoryDelegate{
    func didLoadDataFromServer() {
        questionFactory?.requestNextQuestion()
        viewController?.hideLoadingIndicator()
    }
    
    private let questionsAmount: Int = 10
    private var correctAnswers = 0
    private var currentQuestionIndex: Int = 0
    private var currentQuestion: QuizQuestion?
    weak var viewController: MovieQuizViewControllerProtocol?
    private var alertPresenter: AlertPresenterProtocol?
    private var statisticService: StatisticService
    private var questionFactory: QuestionFactoryProtocol?
    func didFailToLoadData(with error: Error) {
        let message = error.localizedDescription
        viewController?.showNetworkError(message: message)
    }
    
    private func didRecieveNextQuestion(question: QuizQuestion?) {
        guard let question = question else {
            return
        }
        
        currentQuestion = question
        let viewModel = convert(model: question)
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.show(quiz: viewModel)
        }
    }
    func yesButtonClicked() {
        didAnswer(isYes: true)
    }
    func noButtonClicked() {
        didAnswer(isYes: false)
    }
    func convert(model: QuizQuestion) -> QuizStepViewModel {
        return QuizStepViewModel(
            // try, потому что загрузка данных по URL может быть и не успешной
            image: UIImage(data: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)")
    }
    private func isLastQuestion() -> Bool {
        currentQuestionIndex == questionsAmount - 1
    }
    
    private func resetQuestionIndex() {
        currentQuestionIndex = 0
    }
    
    private func switchToNextQuestion() {
        currentQuestionIndex += 1
    }
    private func didAnswer(isYes: Bool) {
        guard let currentQuestion = currentQuestion else {
            return
        }
        
        let givenAnswer = isYes
        
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
    func didReceiveNextQuestion(question: QuizQuestion?) {
        guard let question else {
            return
        }
        currentQuestion = question
        let viewModel = convert(model: question)
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.show(quiz: viewModel)
        }
    }
    private func showNextQuestionOrResults() {
        if isLastQuestion() { // 1
            
            show(cAnswer: correctAnswers)
            // идём в состояние "Результат квиза"
        } else { // 2
            self.switchToNextQuestion()
            questionFactory?.requestNextQuestion()
            // идём в состояние "Вопрос показан"
        }
    }
    func restartGameWithError(message:String){
        correctAnswers = 0
        resetQuestionIndex()
        let alert = AlertModel(title: "Ошибка", message: message, buttonText: "Попробовать еще раз")
        let action = UIAlertAction(title: alert.buttonText, style: .default) {[weak self] _ in
            guard let self = self else { return }
            restartGame()
            questionFactory?.loadData()
        }
        alertPresenter?.show(alert: alert, action: action)
        //questionFactory?.requestNextQuestion()
    }
    func restartGame(){
        correctAnswers = 0
        resetQuestionIndex()
        questionFactory?.requestNextQuestion()
    }
    private func didAnswer(isCorrect: Bool){
        if(isCorrect == true){
            correctAnswers += 1
            viewController?.highlightImageBorder(isCorrect: isCorrect) // делаем рамку зеленой
        }
        else{
            viewController?.highlightImageBorder(isCorrect: isCorrect)// даём разрешение на рисование рамки
        }
    }
    private func showStat(){
        statisticService.store(count: correctAnswers, amount: questionsAmount)
        show(cAnswer: correctAnswers)
    }
    private func makeResultsMessage() -> String {
        statisticService.store(count: correctAnswers, amount: questionsAmount)
        
        let bestGame = statisticService.bestGame
        
        let totalPlaysCountLine = "Количество сыгранных квизов: \(statisticService.gamesCount)"
        let currentGameResultLine = "Ваш результат: \(correctAnswers)\\\(questionsAmount)"
        let bestGameInfoLine = "Рекорд: \(bestGame.correct)\\\(bestGame.total)"
        + " (\(String(describing: bestGame.date.dateTimeString)))"
        let averageAccuracyLine = "Средняя точность: \(String(format: "%.2f", statisticService.totalAccuracy))%"

        let resultMessage = [
            currentGameResultLine, totalPlaysCountLine, bestGameInfoLine, averageAccuracyLine
        ].joined(separator: "\n")
        
        return resultMessage
    }
    private func showAnswerResult(isCorrect: Bool) {
        didAnswer(isCorrect: isCorrect)
        viewController?.blockingButtons()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {[weak self] in
            guard let self = self else { return }
            // код, который мы хотим вызвать через 1 секунду
            showNextQuestionOrResults()
        }
    }
    func show(cAnswer: Int) {
        let alert = AlertModel(title: "Раунд окончен!", message: makeResultsMessage(), buttonText: "Сыграть еще раз")
        let action = UIAlertAction(title: alert.buttonText, style: .default) {[weak self] _ in
            guard let self = self else { return }
            restartGame()
            questionFactory?.loadData()
        }
        alertPresenter = viewController?.alertPresenter
        alertPresenter?.show(alert: alert, action: action)
    }
    init(viewController: MovieQuizViewControllerProtocol) {
        self.viewController = viewController
        
        statisticService = StatisticServiceImplementation()
        
        questionFactory = QuestionFactory(moviesLoader: MoviesLoader(), delegate: self)
        questionFactory?.loadData()
        viewController.showLoadingIndicator()
    }
}
