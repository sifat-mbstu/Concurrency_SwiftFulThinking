//
//  12) PolygonAnimation1.swift
//  Concurrency_SwiftFull_Thinking
//
//  Created by Sifatul Islam on 29/12/23.
//

import SwiftUI

struct Example2PolygonShape: Shape {
    var sides: Int
    private var sidesAsDouble: Double
    
    var animatableData: Double {
        get { return sidesAsDouble }
        set { sidesAsDouble = newValue }
    }
    
    init(sides: Int) {
        self.sides = sides
        self.sidesAsDouble = Double(sides)
    }
    
    func path(in rect: CGRect) -> Path {
        
        // hypotenuse
        let h = Double(min(rect.size.width, rect.size.height)) / 2.0
        
        // center
        let c = CGPoint(x: rect.size.width / 2.0, y: rect.size.height / 2.0)
        
        var path = Path()
        
        let extra: Int = sidesAsDouble != Double(Int(sidesAsDouble)) ? 1 : 0
        
        for i in 0..<Int(sidesAsDouble) + extra {
            let angle = (Double(i) * (360.0 / sidesAsDouble)) * Double.pi / 180
            
            // Calculate vertex
            let pt = CGPoint(x: c.x + CGFloat(cos(angle) * h), y: c.y + CGFloat(sin(angle) * h))
            
            if i == 0 {
                path.move(to: pt) // move to first vertex
            } else {
                path.addLine(to: pt) // draw line to next vertex
            }
        }
        
        path.closeSubpath()
        
        return path
    }
}

struct Example2PolygonAnimation: View {
    @State private var sides: Int = 4
    @State private var duration: Double = 1.0
    @Environment (\.dismiss) private var dismiss

    var body: some View {
        VStack {
            Button(action: {
                dismiss()
            }, label: {
                Text("Back")
                    .padding()
                
            })
            .background(.black)
            .foregroundColor(.white)
            .frame(minWidth: 44, minHeight: 44, maxHeight: .infinity, alignment: .topLeading)
            .padding()
            
            Example2PolygonShape(sides: sides)
                .stroke(Color.red, lineWidth: 3)
                .padding(20)
                .animation(.easeInOut(duration: duration), value: sides)
                .layoutPriority(1)
            
            Text("\(Int(sides)) sides").font(.headline)
            
            HStack(spacing: 20) {
                MyButton(label: "1") {
                    self.sides = 1
                }
                
                MyButton(label: "3") {
                    self.sides = 3
                }
                
                MyButton(label: "7") {
                    self.sides = 7
                }
                
                MyButton(label: "30") {
                    self.sides = 30
                }
                
            }.navigationBarTitle("Example 2").padding(.bottom, 50)
        }
    }
}

struct MyButton: View {
    let label: String
    var font: Font = .title
    var textColor: Color = .white
    let action: () -> ()
    
    var body: some View {
        Button(action: {
            self.action()
        }, label: {
            Text(label)
                .font(font)
                .padding(10)
                .frame(width: 70)
                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.green).shadow(radius: 2))
                .foregroundColor(textColor)
            
        })
    }
}
