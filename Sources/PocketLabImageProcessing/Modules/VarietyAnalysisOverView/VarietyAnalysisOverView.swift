//
//  SwiftUIView.swift
//  
//
//  Created by Amrit Duwal on 11/9/23.
//

import SwiftUI



public enum VarietyAnalysisCellType {
    case identification,photo,exptectedVariety, analysis, note
}


public struct VarietyAnalysisOverView: View {
    
    public init(annotationType: AnnotationType, scenarioId: String) {
        self.annotationType = annotationType
        self.scenarioId = scenarioId
    }
    
    @State private var isUploadImageViewShown: Bool = false
    public var annotationType: AnnotationType
    public var scenarioId: String
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
                                            Spacer()
                                                .frame(height: 200)
                                        }
                                        HStack {
                                            Spacer()
                                            Button{
                                            } label: {
                                                
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
                                        PackageImageTextView(title: "Identification", annotationType: annotationType, varietyAnalysisCellType: .identification)
                                        NavigationLink(destination: UploadImageView(isVisible: $isUploadImageViewShown), isActive: $isUploadImageViewShown) {
                                            PackageImageTextView(title: "2 photos", annotationType: annotationType, varietyAnalysisCellType: .photo)
                                        }
                                        NavigationLink {
                                            SelectExpectedVariety()
                                        } label: {
                                            PackageImageTextView(title: "Expected variety", secondaryTitle: "Apprilio", annotationType: annotationType, varietyAnalysisCellType: .exptectedVariety)
                                        }
                             
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
                                        PackageImageTextView(title: "Notes", annotationType: annotationType, varietyAnalysisCellType: .note)
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
        VarietyAnalysisOverView(annotationType: .customRemoteIdAndVariety(id: "test", name: "test"), scenarioId: "")
    }
}

public struct PackageImageTextView: View {
    public var title: String
    public var secondaryTitle: String?
    public var annotationType: AnnotationType
    public var varietyAnalysisCellType: VarietyAnalysisCellType
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
                    if getHeight() == 40 {
                        TickMarkView()
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .padding(10)
            .frame(maxWidth: .infinity)
            .frame(height: getHeight())
            .background(PackageColors.pureWhite)
            .cornerRadius(10)
            
        }
    }

    
    func getHeight() -> (CGFloat) {
        switch annotationType {
        case .remoteId, .variety, .proteinRate: return 58
        case .customRemoteId(_):
            if varietyAnalysisCellType == .identification { return 40 }
        case .customVariety(_):
            if varietyAnalysisCellType == .exptectedVariety { return 40 }
        case .customRemoteIdAndVariety(_, _):
            switch varietyAnalysisCellType {
            case .identification, .exptectedVariety: return 40
            default: return 58
            }
        default: return 58
        }
        return 58
    }
}


public struct TickMarkView: View {
    public var defaultColor: Color = .green
    public var defaultSize: CGFloat = 24

    public var body: some View {
        Image(systemName: "checkmark")
            .foregroundColor(defaultColor)
            .font(.system(size: defaultSize))
    }
}
