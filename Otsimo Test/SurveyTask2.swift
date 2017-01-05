////
////  SurveyTask2.swift
////  Otsimo Test
////
////  Created by demirci on 04/01/2017.
////  Copyright © 2017 mdemirci. All rights reserved.
////
//
//
//
//import ResearchKit
//
//public var SurveyTask: ORKOrderedTask {
//
//
//    ///M_CHAT
//
//    //identifier
//
//    //Q1 Step
//
//
////    //Q2 Step
////    let q1mainID = "q1/main"
//
//
//
//    //Question 1 ///////////////////////////////////////////////////////////////////////////////////////////////////
//
//    let q1mainID = "q1/main"
//    let q1mainYesID = "q1/mainYes"
//    let q1mainNoID = "q1/mainNo"
//    let q1subID = "q1/sub"
//    let q1subPassAsk1ID = "q1/subPassAsk1"
//    let q1subPassAsk2ID = "q1/subPassAsk2"
//    let q1subPassAsk3ID = "q1/subPassAsk3"
//    let q1subPassAsk4ID = "q1/subPassAsk4"
//    let q1subFailAsk1ID = "q1/q1subFailAsk1"
//    let q1subFailAsk2ID = "q1/q1subFailAsk2"
//    let q1subFailAsk3ID = "q1/q1subFailAsk3"
//
//
//    let q1mainStep = ORKQuestionStep(identifier: q1mainID, title: NSLocalizedString("q1.main", comment: ""),
//                                     answer: ORKBooleanAnswerFormat())
//    let q1mainYesStep = ORKQuestionStep(identifier: q1mainYesID, title: NSLocalizedString("q1.main.yes", comment: ""), answer: ORKTextAnswerFormat())
//    let q1mainNoStep = ORKQuestionStep(identifier: q1mainNoID, title: NSLocalizedString("q1.main.no", comment: ""), answer: ORKTextAnswerFormat())
//
//
//    let q1subQuestions = ORKFormStep(identifier: q1subID)
//    let q1subQuestion1 = ORKFormItem(identifier: q1subPassAsk1ID, text: NSLocalizedString("q1.passAsk1", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q1subQuestion2 = ORKFormItem(identifier: q1subPassAsk2ID, text: NSLocalizedString("q1.passAsk2", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q1subQuestion3 = ORKFormItem(identifier: q1subPassAsk3ID, text: NSLocalizedString("q1.passAsk3", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q1subQuestion4 = ORKFormItem(identifier: q1subPassAsk4ID, text: NSLocalizedString("q1.passAsk4", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q1subQuestion5 = ORKFormItem(identifier: q1subFailAsk1ID, text: NSLocalizedString("q1.failAsk1", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q1subQuestion6 = ORKFormItem(identifier: q1subFailAsk2ID, text: NSLocalizedString("q1.failAsk2", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q1subQuestion7 = ORKFormItem(identifier: q1subFailAsk3ID, text: NSLocalizedString("q1.failAsk3", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    q1subQuestions.formItems = [q1subQuestion1, q1subQuestion2, q1subQuestion3, q1subQuestion4, q1subQuestion5, q1subQuestion6, q1subQuestion7]
//
//
//
//
//
//    //Question 2 ///////////////////////////////////////////////////////////////////////////////////////////////////
//    let q2mainID = "q2/main"
//    let q2subPassAsk1ID = "q2/subAsk1"
//    let q2subPassAsk2ID = "q2/subAsk2"
//
//    let q2mainStep = ORKFormStep(identifier: q2mainID, title: NSLocalizedString("q2.main", comment: ""), text: "")
//    let q2subQuestion1 = ORKFormItem(identifier: q2subPassAsk1ID, text: NSLocalizedString("q2.subAsk1", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q2subQuestion2 = ORKFormItem(identifier: q2subPassAsk2ID, text: NSLocalizedString("q2.subAsk2", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//
//    q2mainStep.formItems = [q2subQuestion1, q2subQuestion2]
//
//
//    //Question 3 ///////////////////////////////////////////////////////////////////////////////////////////////////
//
//    let q3mainID = "q3/main"
//    let q3mainYesID = "q3/mainYes"
//    let q3subID = "q3/subAsks"
//    let q3subAsk1ID = "q3/subAsk1"
//    let q3subAsk2ID = "q3/subAsk2"
//    let q3subAsk3ID = "q3/subAsk3"
//    let q3subAsk4ID = "q3/subAsk4"
//    let q3subAsk5ID = "q3/subAsk5"
//    let q3subAsk6ID = "q3/subAsk6"
//    let q3subAsk7ID = "q3/subAsk7"
//    let q3subAsk8ID = "q3/subAsk8"
//    let q3subAsk9ID = "q3/subAsk9"
//    let q3subAsk10ID = "q3/subAsk10"
//    let q3subAsk11ID = "q3/subAsk11"
//    let q3subAsk12ID = "q3/subAsk12"
//
//
//    let q3mainStep = ORKQuestionStep(identifier: q3mainID, title: NSLocalizedString("q3.main", comment: ""),
//                                     answer: ORKBooleanAnswerFormat())
//    let q3mainYesStep = ORKQuestionStep(identifier: q3mainYesID, title: NSLocalizedString("q3.main.yes", comment: ""), answer: ORKTextAnswerFormat())
//    let q3subQestion = ORKFormStep(identifier: q3subID)
//
//    let q3subQuestion1 = ORKFormItem(identifier: q3subAsk1ID, text: NSLocalizedString("q3.subAsk1", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q3subQuestion2 = ORKFormItem(identifier: q3subAsk2ID, text: NSLocalizedString("q3.subAsk2", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q3subQuestion3 = ORKFormItem(identifier: q3subAsk3ID, text: NSLocalizedString("q3.subAsk3", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q3subQuestion4 = ORKFormItem(identifier: q3subAsk4ID, text: NSLocalizedString("q3.subAsk4", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q3subQuestion5 = ORKFormItem(identifier: q3subAsk5ID, text: NSLocalizedString("q3.subAsk5", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q3subQuestion6 = ORKFormItem(identifier: q3subAsk6ID, text: NSLocalizedString("q3.subAsk6", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q3subQuestion7 = ORKFormItem(identifier: q3subAsk7ID, text: NSLocalizedString("q3.subAsk7", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q3subQuestion8 = ORKFormItem(identifier: q3subAsk8ID, text: NSLocalizedString("q3.subAsk8", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q3subQuestion9 = ORKFormItem(identifier: q3subAsk9ID, text: NSLocalizedString("q3.subAsk9", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q3subQuestion10 = ORKFormItem(identifier: q3subAsk10ID, text: NSLocalizedString("q3.subAsk10", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q3subQuestion11 = ORKFormItem(identifier: q3subAsk11ID, text: NSLocalizedString("q3.subAsk11", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q3subQuestion12 = ORKFormItem(identifier: q3subAsk12ID, text: NSLocalizedString("q3.subAsk12", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//
//    q3subQestion.formItems = [q3subQuestion1, q3subQuestion2, q3subQuestion3, q3subQuestion4, q3subQuestion5, q3subQuestion6, q3subQuestion7, q3subQuestion8, q3subQuestion9, q3subQuestion10, q3subQuestion11, q3subQuestion12]
//
//
//    //Question 4 ///////////////////////////////////////////////////////////////////////////////////////////////////
//
//    let q4mainID = "q4/main"
//    let q4mainYesID = "q4/mainYes"
//    let q4subID = "q4/subAsks"
//    let q4subAsk1ID = "q4/subAsk1"
//    let q4subAsk2ID = "q4/subAsk2"
//    let q4subAsk3ID = "q4/subAsk3"
//    let q4subAsk4ID = "q4/subAsk4"
//
//    let q4mainStep = ORKQuestionStep(identifier: q4mainID, title: NSLocalizedString("q4.main", comment: ""),
//                                     answer: ORKBooleanAnswerFormat())
//    let q4mainYesStep = ORKQuestionStep(identifier: q4mainYesID, title: NSLocalizedString("q4.main.yes", comment: ""), answer: ORKTextAnswerFormat())
//    let q4subQestion = ORKFormStep(identifier: q4subID)
//
//    let q4subQuestion1 = ORKFormItem(identifier: q4subAsk1ID, text: NSLocalizedString("q4.subAsk1", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q4subQuestion2 = ORKFormItem(identifier: q4subAsk2ID, text: NSLocalizedString("q4.subAsk2", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q4subQuestion3 = ORKFormItem(identifier: q4subAsk3ID, text: NSLocalizedString("q4.subAsk3", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q4subQuestion4 = ORKFormItem(identifier: q4subAsk4ID, text: NSLocalizedString("q4.subAsk4", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//
//
//    q4subQestion.formItems = [q4subQuestion1, q4subQuestion2, q4subQuestion3, q4subQuestion4]
//
//    //Question 5 ///////////////////////////////////////////////////////////////////////////////////////////////////
//
//    let q5mainID = "q5/main"
//    let q5mainYesID = "q5/mainYes"
//    let q5subID = "q5/subAsks"
//    let q5subPassAsk1ID = "q5/subPassAsk1"
//    let q5subPassAsk2ID = "q5/subPassAsk2"
//    let q5subFailAsk1ID = "q5/q5subFailAsk1"
//    let q5subFailAsk2ID = "q5/q5subFailAsk2"
//    let q5subFailAsk3ID = "q5/q5subFailAsk3"
//    let q5subFailAsk4ID = "q5/q5subFailAsk4"
//    let q5subFailAsk5ID = "q5/q5subFailAsk5"
//
//    let q5mainStep = ORKQuestionStep(identifier: q5mainID, title: NSLocalizedString("q5.main", comment: ""),
//                                     answer: ORKBooleanAnswerFormat())
//    let q5mainYesStep = ORKQuestionStep(identifier: q5mainYesID, title: NSLocalizedString("q5.main.yes", comment: ""), answer: ORKTextAnswerFormat())
//
//    let q5subQuestions = ORKFormStep(identifier: q5subID)
//    let q5subQuestion1 = ORKFormItem(identifier: q5subPassAsk1ID, text: NSLocalizedString("q5.passAsk1", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q5subQuestion2 = ORKFormItem(identifier: q5subPassAsk2ID, text: NSLocalizedString("q5.passAsk2", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//
//    let q5subQuestion3 = ORKFormItem(identifier: q5subFailAsk1ID, text: NSLocalizedString("q5.failAsk1", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q5subQuestion4 = ORKFormItem(identifier: q5subFailAsk2ID, text: NSLocalizedString("q5.failAsk2", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q5subQuestion5 = ORKFormItem(identifier: q5subFailAsk3ID, text: NSLocalizedString("q5.failAsk3", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q5subQuestion6 = ORKFormItem(identifier: q5subFailAsk4ID, text: NSLocalizedString("q5.failAsk4", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q5subQuestion7 = ORKFormItem(identifier: q5subFailAsk5ID, text: NSLocalizedString("q5.failAsk5", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    q5subQuestions.formItems = [q5subQuestion1, q5subQuestion2, q5subQuestion3, q5subQuestion4, q5subQuestion5, q5subQuestion6, q5subQuestion7]
//
//
//
//    //Question 6 ///////////////////////////////////////////////////////////////////////////////////////////////////
//
//    let q6mainID = "q6/main"
//    let q6mainNoID = "q6/mainNo"
//    let q6subID = "q6/subAsks"
//    let q6subAsk1ID = "q6/subAsk1"
//    let q6subAsk2ID = "q6/subAsk2"
//    let q6subAsk3ID = "q6/subAsk3"
//    let q6subAsk4ID = "q6/subAsk4"
//
//    let q6mainStep = ORKQuestionStep(identifier: q6mainID, title: NSLocalizedString("q6.main", comment: ""),
//                                     answer: ORKBooleanAnswerFormat())
//    let q6mainNoStep = ORKQuestionStep(identifier: q6mainNoID, title: NSLocalizedString("q6.main.no", comment: ""), answer: ORKTextAnswerFormat())
//    let q6subQestion = ORKFormStep(identifier: q6subID)
//
//    let q6subQuestion1 = ORKFormItem(identifier: q6subAsk1ID, text: NSLocalizedString("q6.subAsk1", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q6subQuestion2 = ORKFormItem(identifier: q6subAsk2ID, text: NSLocalizedString("q6.subAsk2", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q6subQuestion3 = ORKFormItem(identifier: q6subAsk3ID, text: NSLocalizedString("q6.subAsk3", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q6subQuestion4 = ORKFormItem(identifier: q6subAsk4ID, text: NSLocalizedString("q6.subAsk4", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//
//
//    q6subQestion.formItems = [q6subQuestion1, q6subQuestion2, q6subQuestion3, q6subQuestion4]
//
//    //Question 7 ///////////////////////////////////////////////////////////////////////////////////////////////////
//
//    let q7mainID = "q7/main"
//    let q7mainYesID = "q7/mainYes"
//    let q7subID = "q7/subAsks"
//    let q7subAsk1ID = "q7/subAsk1"
//    let q7subAsk2ID = "q7/subAsk2"
//    let q7subAsk3ID = "q7/subAsk3"
//    let q7subAsk4ID = "q7/subAsk4"
//    let q7subSubask1 = "q7/subYes/sub1"
//    let q7subSubask2 = "q7/subYes/sub2"
//    
//    
//    let q7mainStep = ORKQuestionStep(identifier: q7mainID, title: NSLocalizedString("q7.main", comment: ""),
//                                    answer: ORKBooleanAnswerFormat())
//    let q7mainYesStep = ORKQuestionStep(identifier: q7mainYesID, title: NSLocalizedString("q7.main.yes", comment: ""), answer: ORKTextAnswerFormat())
//    let q7subQestion = ORKFormStep(identifier: q7subID)
//    
//    let q7subQuestion1 = ORKFormItem(identifier: q7subAsk1ID, text: NSLocalizedString("q7.subAsk1", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q7subQuestion2 = ORKFormItem(identifier: q7subAsk2ID, text: NSLocalizedString("q7.subAsk2", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q7subQuestion3 = ORKFormItem(identifier: q7subAsk3ID, text: NSLocalizedString("q7.subAsk3", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q7subQuestion4 = ORKFormItem(identifier: q7subAsk4ID, text: NSLocalizedString("q7.subAsk4", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    q7subQestion =
////    let q7subSubQuestion1 = ORKQuestionStep(identifier: q7subSubask1, title: NSLocalizedString("q7.main.subYes/sub1", comment: ""), answer: ORKTextAnswerFormat())
////    let q7subSubQuestion2 = ORKQuestionStep(identifier: q7subSubask2, title: NSLocalizedString("q7.main.subYes/sub2", comment: ""), answer: ORKTextAnswerFormat())
//    //Question 8 ///////////////////////////////////////////////////////////////////////////////////////////////////
//
//    //Question 9 ///////////////////////////////////////////////////////////////////////////////////////////////////
//
//    let q9mainID = "q9/main"
//    let q9mainYesID = "q9/mainYes"
//    let q9subID = "q9/subAsks"
//    let q9subAsk1ID = "q9/subAsk1"
//    let q9subAsk2ID = "q9/subAsk2"
//    let q9subAsk3ID = "q9/subAsk3"
//    let q9subAsk4ID = "q9/subAsk4"
//    let q9subAsk5ID = "q9/subAsk5"
//    let q9subAsk6ID = "q9/subAsk6"
//
//    let q9mainStep = ORKQuestionStep(identifier: q9mainID, title: NSLocalizedString("q9.main", comment: ""),
//                                     answer: ORKBooleanAnswerFormat())
//    let q9mainYesStep = ORKQuestionStep(identifier: q9mainYesID, title: NSLocalizedString("q9.main.yes", comment: ""), answer: ORKTextAnswerFormat())
//    let q9subQestion = ORKFormStep(identifier: q9subID)
//
//    let q9subQuestion1 = ORKFormItem(identifier: q9subAsk1ID, text: NSLocalizedString("q9.subAsk1", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q9subQuestion2 = ORKFormItem(identifier: q9subAsk2ID, text: NSLocalizedString("q9.subAsk2", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q9subQuestion3 = ORKFormItem(identifier: q9subAsk3ID, text: NSLocalizedString("q9.subAsk3", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q9subQuestion4 = ORKFormItem(identifier: q9subAsk4ID, text: NSLocalizedString("q9.subAsk4", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q9subQuestion5 = ORKFormItem(identifier: q9subAsk5ID, text: NSLocalizedString("q9.subAsk5", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q9subQuestion6 = ORKFormItem(identifier: q9subAsk6ID, text: NSLocalizedString("q9.subAsk6", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//
//
//    q9subQestion.formItems = [q9subQuestion1, q9subQuestion2, q9subQuestion3, q9subQuestion4, q9subQuestion5, q9subQuestion6]
//
//    //Question 10 ///////////////////////////////////////////////////////////////////////////////////////////////////
//
//    let q10mainID = "q10/main"
//    let q10mainYesID = "q10/mainYes"
//    let q10mainNoID = "q10/mainNo"
//    let q10subID = "q10/sub"
//    let q10subPassAsk1ID = "q10/subPassAsk1"
//    let q10subPassAsk2ID = "q10/subPassAsk2"
//    let q10subPassAsk3ID = "q10/subPassAsk3"
//    let q10subFailAsk1ID = "q10/q10subFailAsk1"
//    let q10subFailAsk2ID = "q10/q10subFailAsk2"
//    let q10subFailAsk3ID = "q10/q10subFailAsk3"
//    let q10subFailAsk4ID = "q10/q10subFailAsk4"
//
//
//
//    let q10mainStep = ORKQuestionStep(identifier: q10mainID, title: NSLocalizedString("q10.main", comment: ""),
//                                      answer: ORKBooleanAnswerFormat())
//    let q10mainYesStep = ORKQuestionStep(identifier: q10mainYesID, title: NSLocalizedString("q10.main.yes", comment: ""), answer: ORKTextAnswerFormat())
//    let q10mainNoStep = ORKQuestionStep(identifier: q10mainNoID, title: NSLocalizedString("q10.main.no", comment: ""), answer: ORKTextAnswerFormat())
//
//
//    let q10subQuestions = ORKFormStep(identifier: q10subID)
//    let q10subQuestion1 = ORKFormItem(identifier: q10subPassAsk1ID, text: NSLocalizedString("q10.passAsk1", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q10subQuestion2 = ORKFormItem(identifier: q10subPassAsk2ID, text: NSLocalizedString("q10.passAsk2", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q10subQuestion3 = ORKFormItem(identifier: q10subPassAsk3ID, text: NSLocalizedString("q10.passAsk3", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q10subQuestion4 = ORKFormItem(identifier: q10subFailAsk1ID, text: NSLocalizedString("q10.failAsk1", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q10subQuestion5 = ORKFormItem(identifier: q10subFailAsk2ID, text: NSLocalizedString("q10.failAsk2", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q10subQuestion6 = ORKFormItem(identifier: q10subFailAsk3ID, text: NSLocalizedString("q10.failAsk3", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q10subQuestion7 = ORKFormItem(identifier: q10subFailAsk4ID, text: NSLocalizedString("q10.failAsk4", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    q10subQuestions.formItems = [q10subQuestion1, q10subQuestion2, q10subQuestion3, q10subQuestion4, q10subQuestion5, q10subQuestion6, q10subQuestion7]
//
//
//    //Question 11 ///////////////////////////////////////////////////////////////////////////////////////////////////
//
//    let q11mainID = "q11/main"
//    let q11mainNoID = "q11/mainNo"
//    let q11subID = "q11/sub"
//    let q11subPassAsk1ID = "q11/subPassAsk1"
//    let q11subPassAsk2ID = "q11/subPassAsk2"
//    let q11subPassAsk3ID = "q11/subPassAsk3"
//    let q11subFailAsk1ID = "q11/q11subFailAsk1"
//    let q11subFailAsk2ID = "q11/q11subFailAsk2"
//    let q11subFailAsk3ID = "q11/q11subFailAsk3"
//
//
//
//    let q11mainStep = ORKQuestionStep(identifier: q11mainID, title: NSLocalizedString("q11.main", comment: ""),
//                                      answer: ORKBooleanAnswerFormat())
//
//    let q11mainNoStep = ORKQuestionStep(identifier: q11mainNoID, title: NSLocalizedString("q11.main.no", comment: ""), answer: ORKTextAnswerFormat())
//
//
//    let q11subQuestions = ORKFormStep(identifier: q11subID)
//    let q11subQuestion1 = ORKFormItem(identifier: q11subPassAsk1ID, text: NSLocalizedString("q11.passAsk1", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q11subQuestion2 = ORKFormItem(identifier: q11subPassAsk2ID, text: NSLocalizedString("q11.passAsk2", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q11subQuestion3 = ORKFormItem(identifier: q11subPassAsk3ID, text: NSLocalizedString("q11.passAsk3", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q11subQuestion4 = ORKFormItem(identifier: q11subFailAsk1ID, text: NSLocalizedString("q11.failAsk1", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q11subQuestion5 = ORKFormItem(identifier: q11subFailAsk2ID, text: NSLocalizedString("q11.failAsk2", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q11subQuestion6 = ORKFormItem(identifier: q11subFailAsk3ID, text: NSLocalizedString("q11.failAsk3", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//
//    q11subQuestions.formItems = [q11subQuestion1, q11subQuestion2, q11subQuestion3, q11subQuestion4, q11subQuestion5, q11subQuestion6]
//
//
//    //Question 12 ///////////////////////////////////////////////////////////////////////////////////////////////////
//
//    //Question 13 ///////////////////////////////////////////////////////////////////////////////////////////////////
//
//    let q13mainID = "q13/main"
//    let q13mainYesID = "q13/mainYes"
//
//    let q13mainStep = ORKQuestionStep(identifier: q13mainID, title: NSLocalizedString("q13.main", comment: ""),
//                                      answer: ORKBooleanAnswerFormat())
//    let q13mainYesStep = ORKQuestionStep(identifier: q13mainYesID, title: NSLocalizedString("q13.main.yes", comment: ""), answer: ORKBooleanAnswerFormat())
//
//
//    //Question 14 ///////////////////////////////////////////////////////////////////////////////////////////////////
//
//    //Question 15 ///////////////////////////////////////////////////////////////////////////////////////////////////
//
//    let q15mainID = "q15/main"
//    let q15mainYesID = "q15/mainYes"
//    let q15subID = "q15/subAsks"
//    let q15subAsk1ID = "q15/subAsk1"
//    let q15subAsk2ID = "q15/subAsk2"
//    let q15subAsk3ID = "q15/subAsk3"
//    let q15subAsk4ID = "q15/subAsk4"
//    let q15subAsk5ID = "q15/subAsk5"
//    let q15subAsk6ID = "q15/subAsk6"
//    let q15subAsk7ID = "q15/subAsk7"
//
//    let q15mainStep = ORKQuestionStep(identifier: q15mainID, title: NSLocalizedString("q15.main", comment: ""),
//                                      answer: ORKBooleanAnswerFormat())
//    let q15mainYesStep = ORKQuestionStep(identifier: q15mainYesID, title: NSLocalizedString("q15.main.yes", comment: ""), answer: ORKTextAnswerFormat())
//    let q15subQestion = ORKFormStep(identifier: q15subID)
//
//    let q15subQuestion1 = ORKFormItem(identifier: q15subAsk1ID, text: NSLocalizedString("q15.subAsk1", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q15subQuestion2 = ORKFormItem(identifier: q15subAsk2ID, text: NSLocalizedString("q15.subAsk2", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q15subQuestion3 = ORKFormItem(identifier: q15subAsk3ID, text: NSLocalizedString("q15.subAsk3", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q15subQuestion4 = ORKFormItem(identifier: q15subAsk4ID, text: NSLocalizedString("q15.subAsk4", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q15subQuestion5 = ORKFormItem(identifier: q15subAsk5ID, text: NSLocalizedString("q15.subAsk5", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q15subQuestion6 = ORKFormItem(identifier: q15subAsk6ID, text: NSLocalizedString("q15.subAsk6", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q15subQuestion7 = ORKFormItem(identifier: q15subAsk7ID, text: NSLocalizedString("q15.subAsk7", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//
//    q15subQestion.formItems = [q15subQuestion1, q15subQuestion2, q15subQuestion3, q15subQuestion4, q15subQuestion5, q15subQuestion6, q15subQuestion7]
//
//
//    //Question 16 ///////////////////////////////////////////////////////////////////////////////////////////////////
//
//    let q16mainID = "q16/main"
//    let q16mainNoID = "q16/mainNo"
//    let q16subID = "q16/sub"
//    let q16subPassAsk1ID = "q16/subPassAsk1"
//    let q16subPassAsk2ID = "q16/subPassAsk2"
//    let q16subPassAsk3ID = "q16/subPassAsk3"
//    let q16subFailAsk1ID = "q16/q16subFailAsk1"
//    let q16subFailAsk2ID = "q16/q16subFailAsk2"
//    let q16subFailAsk3ID = "q16/q16subFailAsk3"
//
//
//
//    let q16mainStep = ORKQuestionStep(identifier: q16mainID, title: NSLocalizedString("q16.main", comment: ""),
//                                      answer: ORKBooleanAnswerFormat())
//
//    let q16mainNoStep = ORKQuestionStep(identifier: q16mainNoID, title: NSLocalizedString("q16.main.no", comment: ""), answer: ORKTextAnswerFormat())
//
//
//    let q16subQuestions = ORKFormStep(identifier: q16subID)
//    let q16subQuestion1 = ORKFormItem(identifier: q16subPassAsk1ID, text: NSLocalizedString("q16.passAsk1", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q16subQuestion2 = ORKFormItem(identifier: q16subPassAsk2ID, text: NSLocalizedString("q16.passAsk2", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q16subQuestion3 = ORKFormItem(identifier: q16subPassAsk3ID, text: NSLocalizedString("q16.passAsk3", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q16subQuestion4 = ORKFormItem(identifier: q16subFailAsk1ID, text: NSLocalizedString("q16.failAsk1", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q16subQuestion5 = ORKFormItem(identifier: q16subFailAsk2ID, text: NSLocalizedString("q16.failAsk2", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q16subQuestion6 = ORKFormItem(identifier: q16subFailAsk3ID, text: NSLocalizedString("q16.failAsk3", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//
//    q16subQuestions.formItems = [q16subQuestion1, q16subQuestion2, q16subQuestion3, q16subQuestion4, q16subQuestion5, q16subQuestion6]
//
//
//
//
//    //Question 17 ///////////////////////////////////////////////////////////////////////////////////////////////////
//
//    let q17mainID = "q17/main"
//    let q17mainYesID = "q17/mainYes"
//    let q17subID = "q17/subAsks"
//    let q17subAsk1ID = "q17/subAsk1"
//    let q17subAsk2ID = "q17/subAsk2"
//    let q17subAsk3ID = "q17/subAsk3"
//    let q17subAsk4ID = "q17/subAsk4"
//    let q17subAsk5ID = "q17/subAsk5"
//
//    let q17mainStep = ORKQuestionStep(identifier: q17mainID, title: NSLocalizedString("q17.main", comment: ""),
//                                      answer: ORKBooleanAnswerFormat())
//    let q17mainYesStep = ORKQuestionStep(identifier: q17mainYesID, title: NSLocalizedString("q17.main.yes", comment: ""), answer: ORKTextAnswerFormat())
//    let q17subQestion = ORKFormStep(identifier: q17subID)
//
//    let q17subQuestion1 = ORKFormItem(identifier: q17subAsk1ID, text: NSLocalizedString("q17.subAsk1", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q17subQuestion2 = ORKFormItem(identifier: q17subAsk2ID, text: NSLocalizedString("q17.subAsk2", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q17subQuestion3 = ORKFormItem(identifier: q17subAsk3ID, text: NSLocalizedString("q17.subAsk3", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q17subQuestion4 = ORKFormItem(identifier: q17subAsk4ID, text: NSLocalizedString("q17.subAsk4", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q17subQuestion5 = ORKFormItem(identifier: q17subAsk5ID, text: NSLocalizedString("q17.subAsk5", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//
//
//    q17subQestion.formItems = [q17subQuestion1, q17subQuestion2, q17subQuestion3, q17subQuestion4, q17subQuestion5]
//
//    //Question 18 ///////////////////////////////////////////////////////////////////////////////////////////////////
//
//    //Question 19 ///////////////////////////////////////////////////////////////////////////////////////////////////
//
//    let q19mainID = "q19/main"
//    let q19mainNoID = "q19/mainNo"
//    let q19SubSecondNoID = "q19/subSecondNo"
//    let q19SubThirdNoID = "q19/subThirdNo"
//    
//    
//    let q19mainStep = ORKQuestionStep(identifier: q19mainID, title: NSLocalizedString("q19.main", comment: ""),
//                                      answer: ORKBooleanAnswerFormat())
//
//    let q19mainNoStep = ORKQuestionStep(identifier: q19mainNoID, title: NSLocalizedString("q19.main.no", comment: ""), answer: ORKTextAnswerFormat())
//    let q19SubSecondNoStep = ORKQuestionStep(identifier: q19SubSecondNoID, title: NSLocalizedString("q19.main.2no", comment: ""), answer: ORKTextAnswerFormat())
//    let q19SubThirdNoStep = ORKQuestionStep(identifier: q19SubThirdNoID, title: NSLocalizedString("q19.main.3no", comment: ""), answer: ORKTextAnswerFormat())
//    
//    //Question 20 ///////////////////////////////////////////////////////////////////////////////////////////////////
//
//    let q20mainID = "q20/main"
//    let q20mainYesID = "q20/mainYes"
//    let q20mainNoID = "q20/mainNo"
//    let q20subNoAsk1ID = "q20/subNoAsk1"
//    let q20subNoAsk2ID = "q20/subNoAsk2"
//    let q20subNoAsk3ID = "q20/subNoAsk3"
//    let q20subNoAsk4ID = "q20/subNoAsk4"
//
//
//    let q20mainStep = ORKQuestionStep(identifier: q20mainID, title: NSLocalizedString("q20.main", comment: ""),
//                                      answer: ORKBooleanAnswerFormat())
//    let q20mainYesStep = ORKQuestionStep(identifier: q20mainYesID, title: NSLocalizedString("q20.main.yes", comment: ""), answer: ORKTextAnswerFormat())
//    let q20mainNoStep = ORKQuestionStep(identifier: q20mainNoID, title: NSLocalizedString("q20.main.no", comment: ""), answer: ORKTextAnswerFormat())
//    let q20subNoQestions = ORKFormStep(identifier: q20mainNoID)
//    
//    let q20subNoQestion1 = ORKFormItem(identifier: q20subNoAsk1ID, text: NSLocalizedString("q20.subNoAsk1", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q20subNoQestion2 = ORKFormItem(identifier: q20subNoAsk2ID, text: NSLocalizedString("q20.subNoAsk2", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q20subNoQestion3 = ORKFormItem(identifier: q20subNoAsk3ID, text: NSLocalizedString("q20.subNoAsk3", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    let q20subNoQestion4 = ORKFormItem(identifier: q20subNoAsk4ID, text: NSLocalizedString("q20.subNoAsk4", comment: ""), answerFormat: ORKBooleanAnswerFormat())
//    
//    q20subNoQestions.formItems = [q20subNoQestion1,q20subNoQestion2,q20subNoQestion3,q20subNoQestion4]
//    
//    
//    
//    //Task Navigation ///////////////////////////////////////////////////////////////////////////////////////////////////
//    let task = ORKNavigableOrderedTask(identifier: "questions", steps: [q1mainStep, q1mainYesStep, q1mainNoStep, q1subQuestions, q2mainStep, q3mainStep, q3mainYesStep, q3subQestion, q4mainStep, q4mainYesStep, q4subQestion, q5mainStep, q5mainYesStep, q6mainStep, q6mainNoStep, q6subQestion, q9mainStep, q9mainYesStep, q9subQestion, q10mainStep, q10mainYesStep, q10mainNoStep, q10subQuestions, q11mainStep, q11mainNoStep, q11subQuestions, q13mainStep, q13mainYesStep, q15mainStep, q15mainYesStep, q15subQestion, q16mainStep, q16mainNoStep, q16subQuestions, q17mainStep, q17mainYesStep,q19mainStep,q19mainNoStep,q19SubSecondNoStep,q19SubThirdNoStep,q20mainStep,q20mainYesStep,q20mainNoStep])
//
//
//    //Navigation for Q1
//    let q1mainResult = ORKResultSelector(resultIdentifier: q1mainStep.identifier)
//    let q1mainYesAnswer = ORKResultPredicate.predicateForBooleanQuestionResult(with: q1mainResult, expectedAnswer: true)
//    let q1mainNoAnswer = ORKResultPredicate.predicateForBooleanQuestionResult(with: q1mainResult, expectedAnswer: false)
//    let q1ruleForYes = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(q1mainYesAnswer,
//
//                                                                                                       q1subQuestions.identifier)])
//    let q1ruleForNo = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(q1mainNoAnswer, q1mainNoStep.identifier)])
//    task.setNavigationRule(q1ruleForYes, forTriggerStepIdentifier: q1mainYesStep.identifier)
//    task.setNavigationRule(q1ruleForNo, forTriggerStepIdentifier: q1mainStep.identifier)
//
//
//    return task
//}
