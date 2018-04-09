//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var questionNumber : Int = 0
    var score : Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextQuestion()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        } else {
            pickedAnswer = false
        }
        
        checkAnswer()
    }
    
    
    func updateUI() {
        questionLabel.text = allQuestions.list[questionNumber].questionText
        scoreLabel.text = "Score: \(score) "
        progressLabel.text = "\(questionNumber + 1)/\(allQuestions.list.count)"
        
        progressBar.frame.size.width = ( view.frame.size.width / 13 ) * CGFloat(questionNumber + 1)
    }
    

    func nextQuestion() {
        if questionNumber < allQuestions.list.count {
            updateUI()
        } else {
            
            let alert = UIAlertController(title: "End of Quiz", message: "You have completed all quizes, Start over?", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: NSLocalizedString("Restart", comment: "Default action"), style: .`default`, handler: { _ in
                self.startOver()
            })
            
            alert.addAction(alertAction)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func checkAnswer() {
        if pickedAnswer == allQuestions.list[questionNumber].answer {
            score += 1            
            ProgressHUD.showSuccess("Correct!")
            
        } else {
            ProgressHUD.showError("Wrong!")
        }
        
        questionNumber += 1
        nextQuestion()
        
    }
    
    
    func startOver() {
        questionNumber = 0
        score = 0
        updateUI()
    }
    

    
}
