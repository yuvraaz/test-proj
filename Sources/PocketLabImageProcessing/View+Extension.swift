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
    
    public func activityIndicator(isLoading: Binding<Bool>) -> some View {
        modifier(ActivityIndicatorPackage(isLoading: isLoading))
    }
    
    public func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

public extension View {
    public func placeholder<Content: View>(
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
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
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
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}

extension RandomAccessCollection {
    func indexed() -> Array<(offset: Int, element: Element)> {
        Array(enumerated())
    }
}


// MARK: - Debugging -
extension View {
    public func _printingChanges() -> Self {
        if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *) {
            Self._printChanges()
            return self
        } else {
            return self
        }
    }
}


struct PrimaryLabel: ViewModifier {
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
    
    func allSubviews() -> [UIView] {
        var res = self.subviews
        for subview in self.subviews {
            let riz = subview.allSubviews()
            res.append(contentsOf: riz)
        }
        return res
    }
}

struct Tool {
    static func hideNavigationBar() {
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.allSubviews().forEach({ (v) in
            if let view = v as? UINavigationBar {
                view.isHidden = true
            }
        })
    }
    
    static func showNavigationBar() {
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.allSubviews().forEach({ (v) in
            if let view = v as? UINavigationBar {
                view.isHidden = false
            }
        })
    }
    
    static func showTabBar() {
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.allSubviews().forEach({ (v) in
            if let view = v as? UITabBar {
                view.isHidden = false
            }
        })
    }
    
    static func hiddenTabBar() {
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.allSubviews().forEach({ (v) in
            if let view = v as? UITabBar {
                view.isHidden = true
            }
        })
    }
}

struct ShowTabBar: ViewModifier {
    func body(content: Content) -> some View {
        return content.padding(.zero).onAppear {
            Tool.showTabBar()
        }
    }
}
struct HiddenTabBar: ViewModifier {
    func body(content: Content) -> some View {
        return content.padding(.zero).onAppear {
            Tool.hiddenTabBar()
        }
    }
}


extension View {
    func showTabBar() -> some View {
        return self.modifier(ShowTabBar())
    }
    func hiddenTabBar() -> some View {
        return self.modifier(HiddenTabBar())
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    
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
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension View {
    func countdownTimer(from startValue: Int, to endValue: Int, interval: TimeInterval = 1, completion: @escaping () -> Void = {}) -> some View {
        @State  var countdown = startValue
        
        return self.modifier(CountdownModifier(countdown: $countdown, endValue: endValue, interval: interval, completion: completion))
    }
}


struct CountdownModifier: ViewModifier {
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
