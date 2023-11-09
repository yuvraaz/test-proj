//
//  SwiftUIView.swift
//  
//
//  Created by Amrit Duwal on 11/9/23.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        NavigationView {
            ZStack {
                if false {
                    ProgressView()
                        .navigationBarBackButtonHidden(true)
                        .onAppear {
                        }
                } else {
                    VStack {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 16) {
                                VStack {
                                    ZStack(alignment: .top) {
                                        ZStack(alignment: .bottom) {
//                                            Image("banner")
                                            Spacer()
//                                                .resizable()
//                                                .scaledToFill()
                                                .frame(height: 200)
//                                                .background(.red)
//                                            HStack {
//                                                PackageCustomText(name: "Actions", textColor: PackageColors.pureWhite, font: PackageFonts.boldFont32)
//                                                    .padding(.leading, 16)
//                                                    .offset(y: 16)
//                                            }
                                        }
                                        HStack {
                                            Spacer()
                                            Button{
                                            } label: {
                                                Image("setting")
                                                    .resizable()
                                                    .renderingMode(.template)
                                                    .foregroundColor(PackageColors.pureWhite)
                                                    .frame(width: 30, height: 30)
                                            }
                                            
                                        }
                                        .padding(.horizontal, 32)
                                    }
                                }
                                VStack(spacing: 0) {
                                    VStack(alignment: .center) {
                                        Spacer().frame(height: 12)
                                        PackageCustomText(name: "Created on 28/02/23 at 09:53", textColor: PackageColors.pureBlack.opacity(0.4) ,alignment: .center, font: PackageFonts.regularFont12)
                                        Spacer().frame(height: 12)
                                    }.frame(maxWidth: .infinity)
                                    VStack {
                                        PackageImageTextView(title: "Identification")
                                        PackageImageTextView(title: "2 photos")
                                        PackageImageTextView(title: "Expected variety", secondaryTitle: "Apprilio")
                                        VStack {
                                            VStack(alignment: .leading) {
                                                HStack(alignment: .center) {
                                                    Image("plus", bundle: .module)
                                                    VStack(alignment: .leading, spacing: 0) {
                                                        Text("Analysis")
                                                            .foregroundColor(PackageColors.pureBlack)
                                                        PackageCustomText(name: "Please complete all steps above", textColor: PackageColors.pureBlack.opacity(0.4) , font: PackageFonts.regularFont12)
                                                    }
                                                    Spacer()
                                                   
                                                }
                                                .frame(maxWidth: .infinity)
                                            }
                                            .padding(10)
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 58)
                                            .cornerRadius(10)
                                            
                                        }
                                        PackageImageTextView(title: "Notes")
                                    }
                                    .padding(.horizontal, 16)
                                }
                                .background(PackageColors.darkGray)
                                .packageCornerRadius(20, corners: [.topLeft, .topRight])
                                .cornerRadius(20)
                                
                                }
                            }
                        }
                    .background(
                          GeometryReader { geometry in
                              PackageColors.brown
                                  .frame(height: min(geometry.size.height, 240))
                          }
                      )
                    .background(PackageColors.darkGray)
       
                        .edgesIgnoringSafeArea(.top)
                    }
                }
            }
        }
    }

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}

struct PackageImageTextView: View {
    var title: String
    var secondaryTitle: String?
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Image("plus", bundle: .module)
                    Text(title)
                        .foregroundColor(PackageColors.pureBlack)
                    Spacer()
                    if let secondaryTitle = secondaryTitle {
                        Text(secondaryTitle)
                            .foregroundColor(PackageColors.pureBlack)
                        Image("plus", bundle: .module)
                    }
                   
                }
                .frame(maxWidth: .infinity)
            }
            .padding(10)
            .frame(maxWidth: .infinity)
            .frame(height: 58)
            .background(PackageColors.pureWhite)
            .cornerRadius(10)
            
        }
    }
}


struct TopCornerRadiusShape: Shape {
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY + radius))
        path.addArc(center: CGPoint(x: rect.minX + radius, y: rect.minY + radius), radius: radius, startAngle: .degrees(180), endAngle: .degrees(90), clockwise: false)
        path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.minY))
        path.addArc(center: CGPoint(x: rect.maxX - radius, y: rect.minY + radius), radius: radius, startAngle: .degrees(-90), endAngle: .degrees(0), clockwise: false)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}
