//
//  EmotionOfTheDayView.swift
//  InsightOut
//
//  Created by Marc Gidaszewski on 06.11.21.
//

import SwiftUI
import InsightOut

struct EmotionsOfTheDayView: View {
    @Binding var colors: [Color]
    
    var body: some View {
        HStack {
            ForEach(0 ..< colors.count, id: \.self) { index in
                EmotionColorSquareView(color: colors[index])
            }
        }
    }
}

struct EmotionsOfTheDayView_Previews: PreviewProvider {
    static var previews: some View {
        EmotionsOfTheDayView(colors: .constant([Color.blue, Color.red]))
            .previewLayout(.sizeThatFits)
    }
}
