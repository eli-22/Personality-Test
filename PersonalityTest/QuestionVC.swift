//
//  QuestionVC.swift
//  PersonalityTest
//
//  Created by Elise on 9/25/22.
//

import UIKit

class QuestionVC: UIViewController {
    
// outlets for entire stack views - type of question determines whether stack is displayed or hidden (comes from updateUI() function).
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var multiStackView: UIStackView!
    @IBOutlet weak var rangeStackView: UIStackView!
    
// single stack answer buttons
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
// multi stack answer labels
    @IBOutlet weak var multiLabel1: UILabel!
    @IBOutlet weak var multiLabel2: UILabel!
    @IBOutlet weak var multiLabel3: UILabel!
    @IBOutlet weak var multiLabel4: UILabel!

//multi stack switch labels
    
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
// range stack answer labels
    @IBOutlet weak var rangeLabel1: UILabel!
    @IBOutlet weak var rangeLabel2: UILabel!
    
    @IBOutlet weak var rangeSlider: UISlider!
    
// title and progress view labels
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var progressViewLabel: UIProgressView!
  
    
    var questionArray: [QuestionData] = [
        QuestionData(
            text: "What kind of food do you like the most?",
            type: .single,
            answers: [
                Answer(text: "Steak", type: .argentina),
                Answer(text: "Curry", type: .thailand),
                Answer(text: "Sushi", type: .japan),
                Answer(text: "Tapas", type: .spain)
            ]
        ),
        
        QuestionData(
            text: "Which activities do you enjoy?",
            type: .multiple,
            answers: [
                Answer(text: "Hiking and rafting", type: .argentina),
                Answer(text: "Beach activities", type: .thailand),
                Answer(text: "City exploration", type: .japan),
                Answer(text: "Dancing and historical tours", type: .spain)
            ]
        ),
        
        QuestionData(
            text: "How long are you willing to fly?",
            type: .ranged,
            answers: [
                Answer(text: "Under 8 hours", type: .spain),
                Answer(text: "8-16 hours", type: .japan),
                Answer(text: "16-24 hours", type: .argentina),
                Answer(text: "A whole day or more!", type: .thailand)]
        )
    ]
    
    var questionIndex = 0
    var answersChosen: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        singleStackView.isHidden = true
        multiStackView.isHidden = true
        rangeStackView.isHidden = true
        
        let currentQuestion = questionArray[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(questionArray.count)
        
        navigationItem.title = "Question #\(questionIndex + 1)"
        questionNumberLabel.text = currentQuestion.text
        progressViewLabel.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
          //  singleStackView.isHidden = false
            updateSingleStack(using: currentAnswers)
        case .multiple:
         //   multiStackView.isHidden = false
            updateMultiStack(using: currentAnswers)
        case .ranged:
        //    rangeStackView.isHidden = false
            updateRangeStack(using: currentAnswers)
        }
    }
    
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questionArray[questionIndex].answers
        
        switch sender {
        case singleButton1:
            answersChosen.append(currentAnswers[0])
        case singleButton2:
            answersChosen.append(currentAnswers[1])
        case singleButton3:
            answersChosen.append(currentAnswers[2])
        case singleButton4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }

        nextQuestion()
    }
    
    
    @IBAction func multiAnswerSubmitPressed() {
        let currentAnswers = questionArray[questionIndex].answers
        
        if multiSwitch1.isOn {
            answersChosen.append(currentAnswers[0])
        }
        if multiSwitch2.isOn {
            answersChosen.append(currentAnswers[1])
        }
        if multiSwitch3.isOn {
            answersChosen.append(currentAnswers[2])
        }
        if multiSwitch4.isOn {
            answersChosen.append(currentAnswers[3])
        }
        
        nextQuestion()
    }
    
    
    @IBAction func rangeAnswerSubmitPressed() {
        let currentAnswers = questionArray[questionIndex].answers
        let index = Int(round(rangeSlider.value * Float(currentAnswers.count - 1)))
        
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questionArray.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "Results", sender: nil)
            }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "Results" {
            let resultsViewController = segue.destination as! ResultVC

            resultsViewController.responses = answersChosen
        }
    }
    
    
    
    func updateSingleStack(using answers: [Answer]) { //pass array of answers from QuestionData object, each with string text and country type
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    

    func updateMultiStack(using answers: [Answer]) { //pass array of answers from QuestionData object, each with string text and country type
        multiStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
    }
    
    func updateRangeStack(using answers: [Answer]) {
        rangeStackView.isHidden = false
        rangeSlider.setValue(0.5, animated: false)
        rangeLabel1.text = answers.first?.text
        rangeLabel2.text = answers.last?.text
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
