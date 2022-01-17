//
//  CardView.swift
//  FastFlash
//
//  Created by hunter downey on 1/10/22.
//

import SwiftUI

extension Shape {
    func fill(using offset: CGSize) -> some View {
        if offset.width == 0 {
            return self.fill(.white)
        } else if offset.width < 0 {
            return self.fill(Color(hex: 0xff5959))
        } else {
            return self.fill(Color(hex: 0xa6cf98))
        }
    }
}

struct CardView: View {
    let card: Card
    var removal: (() -> Void)? = nil
    
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    
    @State private var feedback = UINotificationFeedbackGenerator()
    
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                    ? Color(hex: 0xeeeeee)
                    : Color(hex: 0xeeeeee)
                        .opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    differentiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(using: offset)
                )
                .shadow(radius: 10)
            
            VStack {
                if voiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.title2)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.title2)
                        .foregroundColor(.black)
                    
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title3)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 3)))
        .offset(x: offset.width * 3, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibilityAddTraits(.isButton)
        .gesture(
        DragGesture()
            .onChanged { gesture in
                offset = gesture.translation
                feedback.prepare()
            }
        
            .onEnded { _ in
                if abs(offset.width) > 100 {
                    if offset.width > 0 {
                        feedback.notificationOccurred(.success)
                    } else {
                        feedback.notificationOccurred(.error)
                    }
                    
                    removal?()
                } else {
                    offset = .zero
                }
            }
        )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.spring(), value: offset)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
            .previewInterfaceOrientation(.landscapeLeft)
            .preferredColorScheme(.dark)
    }
}
