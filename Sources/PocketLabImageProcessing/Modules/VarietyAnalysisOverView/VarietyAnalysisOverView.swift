//
//  SwiftUIView.swift
//  
//
//  Created by Amrit Duwal on 11/9/23.
//

import SwiftUI

public struct VarietyAnalysisOverView: View {
    public init(annotationType: AnnotationType) {
        self.annotationType = annotationType
    }
    @State private var isUploadImageViewShown: Bool = false
   public var annotationType: AnnotationType
    public var body: some View {
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
                                        NavigationLink(destination: UploadImageView(isVisible: $isUploadImageViewShown), isActive: $isUploadImageViewShown) {
                                            PackageImageTextView(title: "2 photos")
                                            
                                        }
                                     
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

public struct SwiftUIView_Previews: PreviewProvider {
    public static var previews: some View {
        VarietyAnalysisOverView(annotationType: .variety)
    }
}

public struct PackageImageTextView: View {
    public var title: String
    public var secondaryTitle: String?
    public var body: some View {
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
