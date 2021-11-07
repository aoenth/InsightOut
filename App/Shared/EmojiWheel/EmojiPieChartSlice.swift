//
//  PieChartSlice.swift
//  InsightOut
//
//  Created by Vincent Nguyen on 11/6/21.
// WITH GREAT HELP FROM: https://github.com/BLCKBIRDS/Pie-Chart-in-SwiftUI
import Foundation
import SwiftUI
import InsightOut

func sind(degrees: Double) -> Double {
    return sin(degrees * Double.pi / 180.0)
}

func cosd(degrees: Double) -> Double {
    return cos(degrees * Double.pi / 180.0)
}

struct EmojiPieChartSlice: View {
    let mood: Mood
    var center: CGPoint
    var radius: CGFloat
    var startDegree: Double
    var endDegree: Double
    var isTouched:  Bool
    var accentColor:  Color
    var separatorColor: Color
    let size: CGFloat
    
    var path: Path {
        var path = Path()
        path.addArc(center: center, radius: radius, startAngle: Angle(degrees: startDegree), endAngle: Angle(degrees: endDegree), clockwise: false)
        path.addLine(to: center)
        path.closeSubpath()
        return path
    }
    
    var body: some View {
        ZStack {
            path
                .fill(accentColor)
                .overlay(path.stroke(separatorColor, lineWidth: 3))
                .scaleEffect(isTouched ? 1.1 : 1)
                .animation(Animation.spring())
            
            Emoji(mood: mood)
                .frame(width: size * 0.15, height: size * 0.15)
                .foregroundColor(accentColor)
                .position(center)
                .offset(x: 0.7 * radius * cosd(degrees: startDegree + abs(endDegree - startDegree)/2),
                        y:  0.7 * radius *  sind(degrees: startDegree + abs(endDegree - startDegree)/2))
        }
    }
}

struct EmojiPieChartSlice_Previews: PreviewProvider {
    static var previews: some View {
        EmojiPieChartSlice(mood: Mood.happiness, center: CGPoint(x: 350, y: 200), radius: 300, startDegree: 90, endDegree: 90 + 90, isTouched: true, accentColor: .orange, separatorColor: .black, size: 600)
        
    }
}
