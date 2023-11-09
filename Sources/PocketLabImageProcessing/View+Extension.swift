//
//  View+Extension.swift
//  PocketLab-iOS
//
//  Created by Youbaraj POUDEL on 24/08/2023.
//

import SwiftUI

struct ActivityIndicatorPackage: ViewModifier {
    
    @Binding var isLoading: Bool
    
    func body(content: Content) -> some View{
        ZStack {
            content
            if isLoading {
                Color.gray.opacity(0.5)
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .tint(Color.black)
                    .frame(width: 100, height: 100)
                    .scaleEffect(2)
                
            }
        }
    }
    
}

public extension View {
    
    public func packageActivityIndicator(isLoading: Binding<Bool>) -> some View {
        modifier(ActivityIndicatorPackage(isLoading: isLoading))
    }
    
    public func PackageDismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

public extension View {
    public func packagePlaceholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}


extension View {
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func packageNavigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                
                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
        .navigationViewStyle(.stack)
    }
    
    
}

extension View {
    func packageEraseToAnyView() -> AnyView {
        AnyView(self)
    }
}

extension RandomAccessCollection {
    func packageIndexed() -> Array<(offset: Int, element: Element)> {
        Array(enumerated())
    }
}


// MARK: - Debugging -
extension View {
    public func _packagePrintingChanges() -> Self {
        if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *) {
            Self._printChanges()
            return self
        } else {
            return self
        }
    }
}


struct PackagePrimaryLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.black)
            .foregroundColor(.white)
            .font(.largeTitle)
            .cornerRadius(10)
    }
}
/* uses
 Text("Hello World")
 .modifier(PrimaryLabel())
 */


extension UIView {
    
    func packageAllSubviews() -> [UIView] {
        var res = self.subviews
        for subview in self.subviews {
            let riz = subview.packageAllSubviews()
            res.append(contentsOf: riz)
        }
        return res
    }
}

struct Tool {
    static func packageHideNavigationBar() {
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.packageAllSubviews().forEach({ (v) in
            if let view = v as? UINavigationBar {
                view.isHidden = true
            }
        })
    }
    
    static func packageShowNavigationBar() {
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.packageAllSubviews().forEach({ (v) in
            if let view = v as? UINavigationBar {
                view.isHidden = false
            }
        })
    }
    
    static func packageShowTabBar() {
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.packageAllSubviews().forEach({ (v) in
            if let view = v as? UITabBar {
                view.isHidden = false
            }
        })
    }
    
    static func packageHiddenTabBar() {
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.packageAllSubviews().forEach({ (v) in
            if let view = v as? UITabBar {
                view.isHidden = true
            }
        })
    }
}

struct PackageShowTabBar: ViewModifier {
    func body(content: Content) -> some View {
        return content.padding(.zero).onAppear {
            Tool.packageShowTabBar()
        }
    }
}
struct PackageHiddenTabBar: ViewModifier {
    func body(content: Content) -> some View {
        return content.padding(.zero).onAppear {
            Tool.packageHiddenTabBar()
        }
    }
}


extension View {
    func packageShowTabBar() -> some View {
        return self.modifier(PackageShowTabBar())
    }
    func packageHiddenTabBar() -> some View {
        return self.modifier(PackageHiddenTabBar())
    }
}

extension View {
    func packageCornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( PackageRoundedCorner(radius: radius, corners: corners) )
    }
}

struct PackageRoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            content(self)
        } else {
            self
        }
    }
}

public extension View {
    func packageHideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension View {
    func packageCountdownTimer(from startValue: Int, to endValue: Int, interval: TimeInterval = 1, completion: @escaping () -> Void = {}) -> some View {
        @State  var countdown = startValue
        
        return self.modifier(PackageCountdownModifier(countdown: $countdown, endValue: endValue, interval: interval, completion: completion))
    }
}


struct PackageCountdownModifier: ViewModifier {
    @Binding var countdown: Int
    let endValue: Int
    let interval: TimeInterval
    let completion: () -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                startCountdown()
            }
    }
    
    private func startCountdown() {
        Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
            if countdown > endValue {
                countdown -= 1
            } else {
                timer.invalidate()
                completion()
            }
        }
    }
}

