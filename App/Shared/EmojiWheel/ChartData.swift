//
//  ChartData.swift
//  InsightOut
//
//  Created by Vincent Nguyen on 11/6/21.
//

import SwiftUI
import InsightOut

struct ChartData {
     var label: String
     var mood: Mood
     let value: CGFloat
 }
 
 let chartDataSet = [
    ChartData(label: "Happines", mood: Mood.happiness, value: 360/7),
    ChartData(label: "Sadness", mood: Mood.sadness, value: 360/7),
    ChartData(label: "Love", mood: Mood.love, value: 360/7),
    ChartData(label: "Disgust", mood: Mood.disgust, value: 360/7),
    ChartData(label: "Fear", mood: Mood.fear, value: 360/7),
    ChartData(label: "Surprised", mood: Mood.surprised, value: 360/7),
    ChartData(label: "Anger", mood: Mood.anger, value: 360/7),
     
 ]
