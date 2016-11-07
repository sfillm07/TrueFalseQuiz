//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    var answerSelections: [String] = []
    var currentAnswer = 0
    var pickedQuestion: Question = trivia[0]
    var randomQuestionPick = 0
    var timer = Timer()
    var seconds = 20
    var shuffledQuestions = [Question]()
    var questionIndex = 0
    
    var rightSound: SystemSoundID = 0
    var wrongSound: SystemSoundID = 0
    
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadRightAnswerSound()
        loadWrongAnswerSound()
        randomQuestionArray()
        displayQuestion()
        playAgainButton.isHidden = true
        timerLabel.isHidden = true
        startGame()
    }

        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func randomQuestionArray() {
        shuffledQuestions = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: trivia) as! [Question]
    }

    @IBAction func startTimer() {
    }
    
    func displayQuestion() {
        
        pickedQuestion = shuffledQuestions[questionIndex]
        questionField.text = pickedQuestion.question
        currentAnswer = pickedQuestion.rightAnswer
        
        answerSelections = pickedQuestion.answers
        
        for i in 0..<answerSelections.count {
            answerButtons[i].setTitle(answerSelections[i], for: UIControlState.normal)
        }
    }
    
    func displayScore() {
        // Hide the answer buttons
        
        // Display play again button
        playAgainButton.isHidden = false
        
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        let tag = sender.tag
    
            if tag == currentAnswer {
                questionIndex += 1
                correctQuestions += 1
                playRightAnswerSound()
                displayQuestion()
                
            } else {
                questionIndex += 1
                playWrongAnswerSound()
                answerButtons[currentAnswer].backgroundColor = UIColor.red
                loadNextQuestionWithDelay(seconds: 1)

            }
        }
    
    func startGame() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
    }

    func updateTimer() {
        
        seconds -= 1
        timerLabel.text = String(seconds)
        
        if (seconds <= 10) {
            view.backgroundColor = UIColor(red: 84/255.0, green: 102/255.0, blue: 131/255.0, alpha: 1.0)
            timerLabel.isHidden = false
        }
        
        if seconds == 0 {
            timer.invalidate()
        }
    }
    

    @IBAction func playAgain() {

    }
    
    @IBAction func exitGame() {
        self.dismiss(animated: true, completion: nil)
    }

    func resetButtons() {
        for i in 0..<answerSelections.count {
            answerButtons[i].backgroundColor = UIColor(red: 12/255.0, green: 121/255.0, blue: 150/255.0, alpha: 1.0)
        }
    }

    
    // MARK: Helper Methods
    
    func loadNextQuestionWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.resetButtons()
            self.displayQuestion()
        }
    }

    
    func loadRightAnswerSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "Right", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &rightSound)
    }
    
    func loadWrongAnswerSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "Wrong", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &wrongSound)
    }
    
    func playRightAnswerSound() {
        AudioServicesPlaySystemSound(rightSound)
    }
    
    func playWrongAnswerSound() {
        AudioServicesPlaySystemSound(wrongSound)
    }
}

