import SwiftUI

struct PrimaryButtonText: View {
    var text: String
    var cornerRadius = CGFloat(6)
    var font: Font = Fonts.boldFont16
    var foregroundColor: Color = Colors.pureWhite
    var backgroundColor: Color = Colors.blue
    var borderWidth: CGFloat?
    var maxHeight: CGFloat = 46
    var setGradient = false
    
    
    var body: some View {
        CustomText(
                name: text,
                textColor: foregroundColor,
                alignment: .center,
                font: font)
        .frame(maxWidth: .infinity, maxHeight: maxHeight)
//        .if(!setGradient) { content in
//            content.background(backgroundColor)
//        }
        .if(setGradient) { content in
            content.background(
                LinearGradient(
                    gradient: Gradient(colors: [Colors.brown, Colors.blue]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
        }
        .if(!setGradient) { content in
            content.background(backgroundColor).cornerRadius(cornerRadius)
        }
        .if(borderWidth != nil ) { content in
            content.overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(foregroundColor, lineWidth: borderWidth!)
            )
        }
        .cornerRadius(cornerRadius)
    }
}

struct PrimaryButtonText_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButtonText(text: "Send", cornerRadius: 20.0)
    }
}
