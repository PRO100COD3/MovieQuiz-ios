import UIKit
final class MovieQuizViewController: UIViewController, QuestionFactoryDelegate, AlertPresenterDelegate {
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    private var currentQuestionIndex = 0
    private let questionsAmount: Int = 10
    private var currentQuestion: QuizQuestion?
    private var correctAnswers = 0
    private var presenter: AlertPresenterProtocol? = AlertPresenter()
    private var questionFactory: QuestionFactoryProtocol? = QuestionFactory()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        questionFactory?.delegate = self
        questionFactory?.requestNextQuestion()
        presenter?.delegate = self
    }
    @IBAction private func yesButtonClicked(_ sender: Any) {
        guard let currentQuestion = currentQuestion else {
            return
        }
        let givenAnswer = true
        showAnswerResult(isCorrect: currentQuestion.correctAnswer == givenAnswer)
        print("YES")
    }
    @IBAction private func noButtonClicked(_ sender: Any) {
        guard let currentQuestion = currentQuestion else {
            return
        }
        let givenAnswer = false
        showAnswerResult(isCorrect: currentQuestion.correctAnswer == givenAnswer)
        print("NO")
    }
    // MARK: - QuestionFactoryDelegate
    func didReceiveNextQuestion(question: QuizQuestion?) {
        guard let question else {
            return
        }
        currentQuestion = question
        let viewModel = convert(model: question)
        DispatchQueue.main.async { [weak self] in
            self?.show(quiz: viewModel)
        }
    }
    func showAlert(alert: AlertModel?) {
        guard let alert else{
            return
        }
        DispatchQueue.main.async { [weak self] in
            self?.show(quiz: alert)
        }
        
    }
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        return QuizStepViewModel(
            image: UIImage(named: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)")
    }
    private func show(quiz step: QuizStepViewModel) {
        imageView.layer.borderColor = UIColor.clear.cgColor
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
    }
    private func showAnswerResult(isCorrect: Bool) {
        if(isCorrect == true){
            correctAnswers += 1
            imageView.layer.masksToBounds = true // даём разрешение на рисование рамки
            imageView.layer.borderWidth = 8 // толщина рамки
            imageView.layer.borderColor = UIColor.ypGreen.cgColor // делаем рамку зеленой
        }
        else{
            imageView.layer.masksToBounds = true // даём разрешение на рисование рамки
            imageView.layer.borderWidth = 8 // толщина рамки
            imageView.layer.borderColor = UIColor.ypRed.cgColor // делаем рамку красной
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {[weak self] in
            guard let self = self else { return }
            // код, который мы хотим вызвать через 1 секунду
            self.showNextQuestionOrResults()
        }
    }
    private func showNextQuestionOrResults() {
        if currentQuestionIndex == questionsAmount - 1 { // 1
            self.presenter?.show(cAnswer: correctAnswers)
            // идём в состояние "Результат квиза"
        } else { // 2
            currentQuestionIndex += 1
            self.questionFactory?.requestNextQuestion()
            // идём в состояние "Вопрос показан"
        }
    }
    private func show(quiz result: AlertModel) {
        let alert = UIAlertController(
                title: result.title,
                message: result.message,
                preferredStyle: .alert)
        let action = UIAlertAction(title: result.buttonText, style: .default) {[weak self] _ in
                guard let self = self else { return }
                self.currentQuestionIndex = 0
                self.correctAnswers = 0
            questionFactory?.requestNextQuestion()
            }
            
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
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
