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

var trivia: [Question] = [
    Question(question: "This was the only US President to serve more that two consecutive terms.", answers: ["George Washington", "Franklin D. Roosevelt", "Woodrow Wilson", "Andrew Jackson"], answer: 1),
    Question(question: "Which of the following countries has the most residents?", answers: ["Nigeria", "Russia", "Iran", "Vietnam"], answer: 0),
    Question(question: "In what year was the United Nations founded?", answers: ["1918", "1919", "1945", "1954"], answer: 2),
    Question(question: "The Titanic departed from the United Kingdom, where was it supposed to arrive?", answers: ["Paris", "Washington DC", "New York City", "Boston"], answer: 2),
    Question(question: "Which nation produces the most oil?", answers: ["Iran", "Iraq", "Brazil", "Canada"], answer: 3),
    Question(question: "Which country has most recently won consecutive World Cups in soccer?", answers: ["Italy", "Brazil", "Argentina", "Spain"], answer: 1),
    Question(question: "Which of the following rivers is the longest?", answers: ["Yangtze", "Mississippi", "Congo", "Mekong"], answer: 1),
    Question(question: "Which city is the oldest", answers: ["Mexico City", "Cape Town", "San Juan", "Sydney"], answer: 0),
    Question(question: "Which country was the first to allow women to vote in national elections?", answers: ["Poland", "United States", "Sweden", "Senegal"], answer: 0),
    Question(question: "Which of these countries won the most medals in the 2012 Summer Games", answers: ["France", "Germany", "Japan", "Great Britian"], answer: 3)
]









