import SwiftUI

struct PackagePrimaryButtonText: View {
    var text: String
    var cornerRadius = CGFloat(6)
    var font: Font = PackageFonts.boldFont16
    var foregroundColor: Color = PackageColors.pureWhite
    var backgroundColor: Color = PackageColors.blue
    var borderWidth: CGFloat?
    var maxHeight: CGFloat = 46
    var setGradient = false
    
    
    var body: some View {
        PackageCustomText(
                name: text,
                textColor: foregroundColor,
                alignment: .center,
                font: font)
        .frame(maxWidth: .infinity, maxHeight: maxHeight)
        .if(setGradient) { content in
            content.background(
                LinearGradient(
                    gradient: Gradient(colors: [PackageColors.brown, PackageColors.blue]),
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
        PackagePrimaryButtonText(text: "Send", cornerRadius: 20.0)
    }
}
