import SwiftUI

struct PackagePrimaryButton: View {
    var text: String
    var cornerRadius = CGFloat(6)
    var font: Font = PackageFonts.boldFont16
    var foregroundColor: Color = PackageColors.pureWhite
    var backgroundColor: Color = PackageColors.blue
    var borderWidth: CGFloat?
    var maxHeight: CGFloat = 46
    var clicked: (() -> Void) /// use closure for callback
    var setGradient = false
    var body: some View {
        VStack {
            Button(action: clicked) {
                PackagePrimaryButtonText(
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
        PackagePrimaryButton(text: "Button", clicked: {})
    }
}
