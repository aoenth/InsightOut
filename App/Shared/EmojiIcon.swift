//
//  EmojiIcon.swift
//  InsightOut
//
//  Created by Vincent Nguyen on 11/5/21.
//

import SwiftUI
import InsightOut
struct EmojiIcon: View {
    var body: some View {
        var backgroundColor: Color = Color.black
        var selectedEmotion: Mood = .happy
        Emoji(backgroundColor: backgroundColor)
            .ignoresSafeArea()
            .background(backgroundColor)
    }
}


struct Emoji: View {
    var backgroundColor: Color
    var body: some View {
        GeometryReader{ geometry in
            ZStack {
                Circle()
                    .fill(Color.white)
                EmojiEyes(backgroundColor: backgroundColor, frameSize: geometry.size.height)
                    .offset(y: geometry.size.height * -0.1)
                EmojiMouth(backgroundColor: backgroundColor, frameSize: geometry.size.height)
                    .stroke(style: StrokeStyle(lineWidth: 25.0, lineCap: .round))
                    .foregroundColor(backgroundColor)
                    .offset(y: geometry.size.height * 0.15)
                    .frame(width: geometry.size.height * 0.5, height: geometry.size.height * 0.5)
            }
        }
    }
}

struct EmojiEyes: View {
    var backgroundColor: Color
    var frameSize: CGFloat
    var eyeScale: CGFloat = 0.2
    var body: some View {
        HStack(spacing: frameSize * 0.2) {
            Circle()
                .fill(backgroundColor)
                .frame(width: frameSize * eyeScale, height: frameSize * eyeScale)
            Circle()
                .fill(backgroundColor)
                .frame(width: frameSize * eyeScale, height: frameSize * eyeScale)
        }
    }
}

struct EmojiMouth: Shape {
    var backgroundColor: Color
    var frameSize: CGFloat
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
           path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midX), control: CGPoint(x: rect.midX, y: rect.maxY))
        }
    }
}




struct EmojiIcon_Previews: PreviewProvider {
    static var previews: some View {
        EmojiIcon()
    }
}


