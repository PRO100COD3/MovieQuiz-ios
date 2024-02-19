import UIKit

final class MovieQuizViewController: UIViewController, AlertPresenterDelegate, MovieQuizViewControllerProtocol{
    
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    
    private var movieQuizPresenter: MovieQuizPresenter!
    var presenter: AlertPresenterProtocol? = AlertPresenter()
    var questionFactory: QuestionFactoryProtocol?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        movieQuizPresenter = MovieQuizPresenter(viewController: self)
        presenter?.delegate = self
        
    }
    @IBAction private func yesButtonClicked(_ sender: Any) {
        movieQuizPresenter.yesButtonClicked()
    }
    @IBAction private func noButtonClicked(_ sender: Any) {
        movieQuizPresenter.noButtonClicked()
    }
    func highlightImageBorder(isCorrect: Bool){
        if(isCorrect == true){
            imageView.layer.masksToBounds = true // даём разрешение на рисование рамки
            imageView.layer.borderWidth = 8 // толщина рамки
            imageView.layer.borderColor = UIColor.ypGreen.cgColor // делаем рамку зеленой
        }
        else{
            imageView.layer.masksToBounds = true // даём разрешение на рисование рамки
            imageView.layer.borderWidth = 8 // толщина рамки
            imageView.layer.borderColor = UIColor.ypRed.cgColor // делаем рамку красной
        }
    }
    func showLoadingIndicator() {
        activityIndicator.isHidden = false // говорим, что индикатор загрузки не скрыт
        activityIndicator.startAnimating() // включаем анимацию
    }
    func blockingButtons(){
        yesButton.isEnabled = false
        noButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {[weak self] in
            guard let self = self else { return }
            // код, который мы хотим вызвать через 1 секунду
            yesButton.isEnabled = true
            noButton.isEnabled = true
        }
    }
    func hideLoadingIndicator(){
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    func showNetworkError(message: String) {
        hideLoadingIndicator() // скрываем индикатор загрузки
        let alert = AlertModel(title: "Ошибка", message: message, buttonText: "Попробовать еще раз")
        
        movieQuizPresenter.restartGame()
        
        questionFactory?.loadData()
        
        presenter?.show(alert: alert)
        // создайте и покажите алерт
    }
    // MARK: - QuestionFactoryDelegate
    func showAlert(alert: AlertModel?) {
        guard let alert else{
            return
        }
        DispatchQueue.main.async { [weak self] in
            let message = self?.movieQuizPresenter.makeResultsMessage()
            let newAlert = UIAlertController(
                title: alert.title,
                message: message,
                preferredStyle: .alert)
            newAlert.view.accessibilityIdentifier = "Game results"
            let action = UIAlertAction(title: alert.buttonText, style: .default) {[weak self] _ in
                guard let self = self else { return }
                movieQuizPresenter.restartGame()
            }
            
            newAlert.addAction(action)
            
            self?.present(newAlert, animated: true, completion: nil)
        }
    }
    func show(quiz step: QuizStepViewModel) {
        imageView.layer.borderColor = UIColor.clear.cgColor
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
    }
}
/*
 Mock-данные
 
 
 Картинка: The Godfather
 Настоящий рейтинг: 9,2
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Dark Knight
 Настоящий рейтинг: 9
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Kill Bill
 Настоящий рейтинг: 8,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Avengers
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Deadpool
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Green Knight
 Настоящий рейтинг: 6,6
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Old
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: The Ice Age Adventures of Buck Wild
 Настоящий рейтинг: 4,3
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: Tesla
 Настоящий рейтинг: 5,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: Vivarium
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 */
