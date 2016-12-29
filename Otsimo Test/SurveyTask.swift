//
//  SurveyTask.swift
//  Otsimo Test
//
//  Created by demirci on 29/12/2016.
//  Copyright © 2016 mdemirci. All rights reserved.
//
import ResearchKit

public var SurveyTask: ORKOrderedTask {
    
    var steps = [ORKStep]()
    
    //instructions step
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "The Questions Three"
    instructionStep.text = "Who would cross the Bridge of Death must answer me these questions three, ere the other side they see."
    steps += [instructionStep]
    
    //TODO: add name question
    
    //TODO: add 'what is your quest' question
    
    //Q1
    let q1 = ORKQuestionStep(identifier: "q1")
    q1.title = NSLocalizedString("If you point at something across the room, does your child look at it?", comment: "FOR EXAMPLE, if you point at a toy or an animal, does your child look at the toy or animal?")
    q1.answerFormat = ORKBooleanAnswerFormat()
    steps += [q1]
    
    
    
    //Q1
    let q2 = ORKQuestionStep(identifier: "q2")
    q2.title = NSLocalizedString("Have you ever wondered if your child might be deaf?", comment: "")
    q2.answerFormat = ORKBooleanAnswerFormat()
    steps += [q2]
    
    

    
    //TODO: add color question step
    
    //summary step
    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "Right. Off you go!"
    summaryStep.text = "That was easy!"
    steps += [summaryStep]
    
    
    return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
}
