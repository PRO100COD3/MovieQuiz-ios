//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Вадим Дзюба on 11.02.2024.
//

import Foundation

struct GameRecord: Codable {
    let correct: Int
    let total: Int
    let date: Date
    func compareRecord(newRecord: GameRecord) -> Bool{
        if newRecord.correct > correct
        {
            return true}
        else{
            return false}
    }
}
protocol StatisticService{
    var totalAccuracy: Double { get }
    var gamesCount: Int { get }
    var bestGame: GameRecord { get }
    func store(count: Int, amount: Int)
    func addString() -> String
}
class StatisticServiceImplementation: StatisticService{
    private enum Keys: String {
        case correct, total, bestGame, gamesCount, correctAnswer, amount
    }
    private let userDefaults = UserDefaults.standard
    var totalCorrectAnswer: Int {
        get {
            guard let data = userDefaults.data(forKey: Keys.correctAnswer.rawValue), let correctAnswer = try? JSONDecoder().decode(Int.self, from: data)
            else {
                return 0
            }
            
            return correctAnswer
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                print("Невозможно сохранить результат")
                return
            }
            
            userDefaults.set(data, forKey: Keys.correctAnswer.rawValue)
        }
    }
    var totalAmount: Int {
        get {
            guard let data = userDefaults.data(forKey: Keys.amount.rawValue), let amount = try? JSONDecoder().decode(Int.self, from: data)
            else {
                return 0
            }
            
            return amount
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                print("Невозможно сохранить результат")
                return
            }
            
            userDefaults.set(data, forKey: Keys.amount.rawValue)
        }
    }
    var totalAccuracy: Double {
        get {
            guard let data = userDefaults.data(forKey: Keys.total.rawValue), let accuracy = try? JSONDecoder().decode(Double.self, from: data)
            else {
                return 0
            }
            
            return accuracy
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                print("Невозможно сохранить результат")
                return
            }
            
            userDefaults.set(data, forKey: Keys.total.rawValue)
        }
    }
    var gamesCount: Int {
        get {
            guard let data = userDefaults.data(forKey: Keys.gamesCount.rawValue), let count = try? JSONDecoder().decode(Int.self, from: data)
            else {
                return 0
            }
            
            return count
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                print("Невозможно сохранить результат")
                return
            }
            
            userDefaults.set(data, forKey: Keys.gamesCount.rawValue)
        }
    }
    var bestGame: GameRecord {
        get {
            guard let data = userDefaults.data(forKey: Keys.bestGame.rawValue),
                  let record = try? JSONDecoder().decode(GameRecord.self, from: data) else {
                return .init(correct: 0, total: 0, date: Date())
            }
            
            return record
        }
        
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                print("Невозможно сохранить результат")
                return
            }
            
            userDefaults.set(data, forKey: Keys.bestGame.rawValue)
        }
    }
    func store(count: Int, amount: Int) {
        let newRecord = GameRecord(correct: count, total: amount, date: Date())
        if bestGame.compareRecord(newRecord: newRecord){
            bestGame = newRecord
        }
        gamesCount+=1
        totalCorrectAnswer += count
        totalAmount += amount
        totalAccuracy = (Double(totalCorrectAnswer)/Double(totalAmount))*100
    }
    func addString() -> String{
        return "Количество сыгранных квизов: \(String(gamesCount))\n"+"Рекорд: \(String(bestGame.correct))/\(String(bestGame.total)) \(bestGame.date.dateTimeString)\nСредняя точность: \(String(format: "%.2f", totalAccuracy))%"
    }
}
