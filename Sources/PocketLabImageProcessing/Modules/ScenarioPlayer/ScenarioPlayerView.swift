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


public struct ScenarioPlayerView: View {
    
    @State private var isUploadImageViewShown: Bool = false
    public var scenarioId: Int
    public var player: ScenarioPlayerComponent
    @State private var indentificationCompleted = false
    @State private var indentificationisCompleted = false
    
    @State private var isPopoverPresented = false
    @State private var selectedVariety: OptionalArray? = nil
    
    public init(player: ScenarioPlayerComponent, scenarioId: Int) {
        self.player = player
        self.scenarioId = scenarioId
    }
    
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
                                        NavigationLink(destination: IdentificationView(clicked: { code in
                                            //
                                            self.updateData(sampleId: code)
                                            
                                        }), isActive: $indentificationCompleted) {
                                            PackageImageTextView(title: "Identification", annotationType: player.annotationType, varietyAnalysisCellType: .identification, isCompleted: indentificationisCompleted)
                                        }
                                        
                                        NavigationLink(destination: ImageAcquisitionView(isVisible: $isUploadImageViewShown), isActive: $isUploadImageViewShown) {
                                            PackageImageTextView(title: "2 photos", annotationType: player.annotationType, varietyAnalysisCellType: .photo, isCompleted: false)
                                        }
                                        Button {
                                            isPopoverPresented = true
                                        } label: {
                                            PackageImageTextView(title: "Expected variety", secondaryTitle: selectedVariety?.userValue ?? "", annotationType: player.annotationType, varietyAnalysisCellType: .exptectedVariety, isCompleted: selectedVariety?.userValue != nil)
                                            
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
                                        PackageImageTextView(title: "Notes", annotationType: player.annotationType, varietyAnalysisCellType: .note, isCompleted: false)
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
        .popover(isPresented: $isPopoverPresented, content: {
            // Content of the popover
            DeclarationView(isPopoverPresented: $isPopoverPresented, dismissAction: { selectedVariety in
                self.selectedVariety = selectedVariety
            })
        })
        .onAppear {
            if let data = GlobalConstants.KeyValues.dataStored {
                
            } else {
                GlobalConstants.KeyValues.dataStored = true
            }
            
        }
    }
    
    func updateData(sampleId: String) {
        indentificationisCompleted = true
    }
}

public struct SwiftUIView_Previews: PreviewProvider {
    public static var previews: some View {
        ScenarioPlayerView(player: ScenarioPlayerComponent(), scenarioId: 0)
    }
}

public struct PackageImageTextView: View {
    public var title: String
    public var secondaryTitle: String?
    public var annotationType: AnnotationType?
    public var varietyAnalysisCellType: VarietyAnalysisCellType
    public var isCompleted: Bool
    public var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Image("plus", bundle: .module)
                    Text(title)
                        .foregroundColor(PackageColors.pureBlack)
                    Spacer()
                    if let secondaryTitle = secondaryTitle, secondaryTitle != "" {
                        Text(secondaryTitle)
                            .foregroundColor(PackageColors.pureBlack)
                        if !isCompleted {
                            Image("plus", bundle: .module)
                        }
                        
                    }
                    if isCompleted == true {
                        TickMarkView()
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .padding(10)
            .frame(maxWidth: .infinity)
            .frame(height: isCompleted ? 40 : 58)
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
