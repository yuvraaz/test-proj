import SwiftUI

public struct CustomText: View {
    public var name: String = ""
    public var textColor: Color = Colors.pureBlack
    public var darkMode: Bool = false
    public var alignment: Alignment = .leading
    public var padding: CGFloat = 4
    public var font: Font = Fonts.regularFont16
    public var maxWidth = true
    public var setGradient = false
    public var lineLimit: Int?
    public var multilineTextAlignment: TextAlignment?
    
    
    public init(name: String = "", textColor: Color = Colors.pureBlack, darkMode: Bool = false, alignment: Alignment = .leading, padding: CGFloat = 4, font: Font = Fonts.regularFont16, maxWidth: Bool = true, setGradient: Bool = false, lineLimit: Int? = nil, multilineTextAlignment: TextAlignment? = nil) {
        self.name = name
        self.textColor = textColor
        self.darkMode = darkMode
        self.alignment = alignment
        self.padding = padding
        self.font = font
        self.maxWidth = maxWidth
        self.setGradient = setGradient
        self.lineLimit = lineLimit
        self.multilineTextAlignment = multilineTextAlignment
    }
    
    public var body: some View {
        Text(name)
            .font(font)
//            .foregroundColor(textColor)
          
            .frame(alignment: alignment)
            .padding(padding)
            .if(maxWidth) { content in
                content.frame(maxWidth: .infinity, alignment: alignment)
            }
            .if(setGradient) { content in
                content.foregroundStyle(
                    LinearGradient(
                        gradient: Gradient(colors: [Colors.brown, Colors.blue]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            }
            .if(!setGradient) { content in
                content.foregroundColor(textColor)
            }
            .if(lineLimit != nil) { content in
                content.lineLimit(lineLimit)
            }
            .if(multilineTextAlignment != nil) { content in
                content.multilineTextAlignment(multilineTextAlignment!)
            }
            
        //            .padding(.horizontal, 6)
        //            .padding(.vertical, 8)
        //            .background(Color(darkestGreyColor))
        //            .cornerRadius(4)
        //            .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
    }
    
//    func getTextColor() -> Color {
//        switch(darkMode, textColor == nil ) {
//        case (false, true), (true, false) : return Color(darkestGreyColor)
//        case (true, true) : return Color(lightGreyColor)
//        case (false, false) : return Color(textColor ?? darkestGreyColor)
//        }
//    }
}

public struct TextFieldView_Previews: PreviewProvider {
    public static var previews: some View {
        CustomText()
    }
}

