import SwiftUI

struct PrimaryButton: View {
    var text: String
    var cornerRadius = CGFloat(6)
    var font: Font = Fonts.boldFont16
    var foregroundColor: Color = Colors.pureWhite
    var backgroundColor: Color = Colors.blue
    var borderWidth: CGFloat?
    var maxHeight: CGFloat = 46
    var clicked: (() -> Void) /// use closure for callback
    var setGradient = false
    var body: some View {
        VStack {
            Button(action: clicked) {
                PrimaryButtonText(
                    text: text,
                    cornerRadius: cornerRadius,
                    font: font,
                    foregroundColor: foregroundColor,
                    backgroundColor: backgroundColor,
                    borderWidth: borderWidth,
                    maxHeight: maxHeight,
                    setGradient: setGradient)
            }
        }
    }
}


struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(text: "Button", clicked: {})
    }
}
