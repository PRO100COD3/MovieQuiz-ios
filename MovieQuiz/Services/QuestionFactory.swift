//
//  QuestionFactory.swift
//  MovieQuiz
//
//  Created by Вадим Дзюба on 22.01.2024.
//

import Foundation

class QuestionFactory: QuestionFactoryProtocol{
    private let moviesLoader: MoviesLoading
    weak var delegate: QuestionFactoryDelegate?
    private var movies: [MostPopularMovie] = []
    func requestNextQuestion() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            let index = (0..<self.movies.count).randomElement() ?? 0
            
            guard let movie = self.movies[safe: index] else { return }
            
            var imageData = Data()
            
            do {
                imageData = try Data(contentsOf: movie.resizedImageURL)
            } catch {
                print("Failed to load image")
                delegate?.restartGameWithError(message: "Не удалось загрузить изображение")
                return
            }
            
            let rating = Float(movie.rating) ?? 0
            let rnd = [5,6,7,8]
            let correctNow = rnd.randomElement()!
            let text = "Рейтинг этого фильма больше чем "+String(correctNow)+"?"
            let correctAnswer = rating > Float(correctNow)
            
            let question = QuizQuestion(image: imageData,
                                        text: text,
                                        correctAnswer: correctAnswer)
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.delegate?.didReceiveNextQuestion(question: question)
            }
        }
    }
    func loadData() {
        moviesLoader.loadMovies { [weak self] result in
            DispatchQueue.main.async{
                guard let self = self else { return }
                switch result {
                    case .success(let mostPopularMovies):
                        self.movies = mostPopularMovies.items // сохраняем фильм в нашу новую переменную
                        self.delegate?.didLoadDataFromServer() // сообщаем, что данные загрузились
                    case .failure(let error):
                        self.delegate?.didFailToLoadData(with: error) // сообщаем об ошибке нашему MovieQuizViewController
                }
            }
            
        }
    }
    init(moviesLoader: MoviesLoading, delegate: QuestionFactoryDelegate?) {
        self.moviesLoader = moviesLoader
        self.delegate = delegate
    }
}
