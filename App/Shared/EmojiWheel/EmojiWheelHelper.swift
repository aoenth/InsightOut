//
//  EmojiHelper.swift
//  InsightOut
//
//  Created by Vincent Nguyen on 11/6/21.
/// WITH GREAT HELP FROM: https://github.com/BLCKBIRDS/Pie-Chart-in-SwiftUI

import Foundation
import SwiftUI
import InsightOut

let pieColors = [
     Color("happiness"),
     Color("sadness"),
     Color("love"),
     Color("disgust"),
     Color("fear"),
     Color("surprised"),
     Color("anger")
]

struct PieSlice {
    var startDegree: Double
    var endDegree: Double
    let mood: Mood
    let label: String
}

func normalizedValue(index: Int, data: [ChartData]) -> Double {
    var total = 0.0
    data.forEach { data in
        total += data.value
    }
    return data[index].value/total
}



func angleAtTouchLocation(inPie pieSize: CGRect, touchLocation: CGPoint) ->  Double?  {
    let dx = touchLocation.x - pieSize.midX
    let dy = touchLocation.y - pieSize.midY
    
    let distanceToCenter = (dx * dx + dy * dy).squareRoot()
    let radius = pieSize.width/2
    guard distanceToCenter <= radius else {
        return nil
    }
    let angleAtTouchLocation = Double(atan2(dy, dx) * (180 / .pi))
    if angleAtTouchLocation < 0 {
        return (180 + angleAtTouchLocation) + 180
    } else {
        return angleAtTouchLocation
     }
 }
