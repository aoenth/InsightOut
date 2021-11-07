//
//  EmotionOfTheDayView.swift
//  InsightOut
//
//  Created by Marc Gidaszewski on 06.11.21.
//

import SwiftUI
import InsightOut

struct EmotionsOfTheDayView: View {
    let colors: [Color]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0 ..< colors.count, id: \.self) { index in
                colors[index]
            }
        }
    }
}

struct EmotionsOfTheDayView_Previews: PreviewProvider {
    static var previews: some View {
        EmotionsOfTheDayView(colors: [Color.blue, Color.red])
            .previewLayout(.sizeThatFits)
    }
}
