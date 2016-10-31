//
//  QuestionModel.swift
//  TrueFalseStarter
//
//  Created by Sean Fillmore on 10/31/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation
import UIKit


struct Question {
    var question: String
    var answers: [String]
    var rightAnswer: Int
    
    init(question: String, answers: [String], answer: Int) {
        self.question = question
        self.answers = answers
        self.rightAnswer = answer
    }
}




