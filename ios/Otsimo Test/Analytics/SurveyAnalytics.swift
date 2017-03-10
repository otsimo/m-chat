//
//  SurveyAnalytics.swift
//  OtsimoTest
//
//  Created by demirci on 30/01/2017.
//  Copyright © 2017 mdemirci. All rights reserved.
//

import Foundation
import ResearchKit



extension Pollster{
    func addAnalyticsForYesNo(id : String,answer : Bool, startDate : Int64, endDate : Int64){
        print("id=",id,"Answer= ",answer," startDate=",startDate," endDate=",endDate)
        analytics.event("surveyForYesNo", data: ["questionID" :id,"answer":answer,"startDate":startDate,"endDate":endDate])
    }
    func addAnalyticsForGroupQuestion(id : String,answers : [GroupAnswer], startDate : Int64, endDate : Int64){
        print("id=",id,"Answer= ",answers," startDate=",startDate," endDate=",endDate)
        
        
        analytics.event("surveyForGroupQuestion", data: ["questionID" :id,"answer":answers,"startDate":startDate,"endDate":endDate])
    }
}
