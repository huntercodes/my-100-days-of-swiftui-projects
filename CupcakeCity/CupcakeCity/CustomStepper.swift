//
//  CustomStepper.swift
//  CupcakeCity
//
//  Created by hunter downey on 12/7/21.
//

import SwiftUI

struct CustomStepper: View {
    @Binding var value: Double
    var textColor: Color
    var colorName: String
    var step = 1.0/255

    var body: some View {
            HStack {
                Text(colorName + " \(Int(value * 255.0))").font(.system(.caption, design: .rounded))
                    .foregroundColor(textColor)
                Spacer()

                Button(action: {
                    if self.value > 0 {
                        self.value -= self.step
                        self.feedback()
                    }
                }, label: {
                    Image(systemName: "minus.square")
                        .foregroundColor(value > 0 ? textColor : Color.gray)
                })

                Button(action: {
                    if self.value < 1 {
                        self.value += self.step
                        self.feedback()
                    }
                }, label: {
                    Image(systemName: "plus.square")
                        .foregroundColor(value < 1 ? textColor : Color.gray)
                })
        }
    }

    func feedback() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}

#if DEBUG
struct CustomStepper_Previews: PreviewProvider {
    static var previews: some View {
        CustomStepper(value: .constant(0.5), textColor: Color(hex: 0xf6f2d4), colorName: "")
    }
}
#endif
