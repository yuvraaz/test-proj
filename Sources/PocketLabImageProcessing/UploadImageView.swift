//
//  UploadImageView.swift
//  PocketLab-iOS
//
//  Created by Amrit Duwal on 9/19/23.
//

import SwiftUI

public struct Colors {
    public static let pureBlack           = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).color //000000
    public static let lightGray       = #colorLiteral(red: 0.9725490196, green: 0.968627451, blue: 0.9843137255, alpha: 1).color // F8F7FB
    public static let pureWhite       = #colorLiteral(red: 1, green: 0.9999999404, blue: 0.9999999404, alpha: 1).color // FFFFFF
    public static let blue              = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1).color // 007AFF
    public static let brown         = #colorLiteral(red: 0.9725490196, green: 0.5215686275, blue: 0.01176470588, alpha: 1).color //F88503
    public static let yellow       = #colorLiteral(red: 0.9960784314, green: 0.7843137255, blue: 0.3019607843, alpha: 1).color //FEC84D
    
     //    unused
    public static let greenColor        = #colorLiteral(red: 0, green: 0.7843137255, blue: 0.5921568627, alpha: 1) // 00C897
    public static let lightestGreyColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // #FFFFFF
    public static let lighterGreyColor  = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1) // #F9F9F9
    public static let lightGreyColor    = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9529411765, alpha: 1) // F2F2F3
    public static let darkestGreyColor  = #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1) // 212121
    public static let darkerGreyColor   = #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1) //666666
    public static let darkGreyColor     = #colorLiteral(red: 0.6196078431, green: 0.6196078431, blue: 0.6196078431, alpha: 1) //#9E9E9E
    public static let redColor          = #colorLiteral(red: 0.9529411765, green: 0.3137254902, blue: 0.3137254902, alpha: 1) //F35050
    public static let lightYellowColor  = #colorLiteral(red: 1, green: 0.9843137255, blue: 0.9490196078, alpha: 1) //FFFBF2
    
}

public struct UploadImageView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject public var viewModel = UploadImageViewModel()
    
    @State public var distance : Float = 0.0
    @State public var capturePhoto : Bool = false
    @State public var capturedPhoto: UIImage = UIImage()
    @State public var countdown = 4
    @State public var startCountDown = false
    @State public var isPaused = false
    @State public var numberOfAdditionalClick = 1
    @State public var showSuccessAlert = false
    @State public var readyToCapture = false
    @State public var startButtonPressed = false
    @State public var callStartCountDownOnceOnly = true
    @Binding public var isVisible: Bool
    
    
    public init(isVisible: Binding<Bool>) {
        self._isVisible = isVisible
    }

//    public init(countdown: Int = 4, startCountDown: Bool = false, isPaused: Bool = false, numberOfAdditionalClick: Int = 1, showSuccessAlert: Bool = false, readyToCapture: Bool = false, startButtonPressed: Bool = false, callStartCountDownOnceOnly: Bool = true, isVisible: Binding<Bool>) {
//        self.countdown = countdown
//        self.startCountDown = startCountDown
//        self.isPaused = isPaused
//        self.numberOfAdditionalClick = numberOfAdditionalClick
//        self.showSuccessAlert = showSuccessAlert
//        self.readyToCapture = readyToCapture
//        self.startButtonPressed = startButtonPressed
//        self.callStartCountDownOnceOnly = callStartCountDownOnceOnly
//        self.isVisible = isVisible
//    }
//    
    public var body: some View {
        let showAlert = Binding<Bool>(
            get: { viewModel.showAlert ?? false },
            set: { _ in viewModel.showAlert = viewModel.showAlert }
        )
        let showSuccessAlert = Binding<Bool>(
            get: { viewModel.showSuccessAlert },
            set: { _ in viewModel.showSuccessAlert = viewModel.showSuccessAlert }
        )
        
        if(viewModel.isBusy) {
            ProgressView()
        } else {
            ZStack(alignment: .top) {
                ARViewContainer(distance: $distance, capturePhoto: $capturePhoto, capturedPhoto: $capturedPhoto, isPaused: $isPaused, readyToCapture: $readyToCapture)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    Image(uiImage: capturedPhoto)
                        .resizable()
                        .scaledToFit()
                        .rotationEffect(.degrees(90))
                    Spacer()
                }
                if startCountDown && countdown > 1 {
                    VStack {
                        Spacer()
                        Text("\(countdown - 1)")
                            .font(.system(size: 100))
                            .foregroundColor(.white)
                        Spacer()
                    }
                }
                Colors.pureBlack.opacity(0.4)
                    .ignoresSafeArea()
                if (startCountDown == false && viewModel.showSuccessAlert == false && callStartCountDownOnceOnly == true)  {
                    VStack(spacing: 0) {
                        CustomText(name: "Photos", textColor: Colors.pureWhite, alignment: .center, font: Fonts.mediumFont16)
                        Spacer().frame(height: 40)
                        HStack {
                            Spacer()
                        }
                        .frame(height: 60)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Colors.yellow, lineWidth: 2)
                        )
                        Spacer().frame(height: 12)
                        CustomText(name: "Center the rectangle on the inarix card",textColor: Colors.yellow, alignment: .center, font: Fonts.regularFont12)
                        Spacer().frame(height: 60)
                        CustomText(name: "Get ready for the \( numberOfAdditionalClick == 2 ? "first" : "second") photo\n (\(2 - numberOfAdditionalClick)/2)", textColor: Colors.pureWhite,alignment: .center, font: Fonts.mediumFont20, multilineTextAlignment: .center)  .lineSpacing(4)
                        
                        CustomText(name: "• Check if your sensor is clean\n• Adjust frame & focus \n• Show / hide interface", textColor: Colors.pureWhite, alignment: .center, font: Fonts.regularFont16, multilineTextAlignment: .center).lineSpacing(4)
                        Spacer()
                        if !startButtonPressed {
                            PrimaryButton(text: "Start") {
                                startButtonPressed = true
                                startCountDown = true
                            }
                            .padding(.horizontal, 16)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                }
                
            }
            .onChange(of: readyToCapture) { newValue in
                
                if newValue == true && startCountDown && callStartCountDownOnceOnly {
                    callStartCountDownOnceOnly = false
                    startCountdown()
                }
            }
            .alert(viewModel.error?.localizedDescription ?? "", isPresented: showAlert, actions: {
                Button("Ok") {
                    self.viewModel.showAlert = false
                }
            })
            .alert("Well done.", isPresented: showSuccessAlert, actions: {
                Button("Ok") {
                    self.viewModel.showSuccessAlert = false
                    isVisible = false
                }
            })
        }
    }
    
    func startCountdown() {
        startCountDown = true
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if countdown > 1 {
                countdown -= 1
            } else {
                timer.invalidate()
                capturePhoto = true
                countdown = 4
                startCountDown = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    if capturedPhoto == UIImage() { return }
                    viewModel.uploadImage(x: "", y: "", z: "", yaw: "", site: "", image: capturedPhoto)
                    capturedPhoto = UIImage()
                    capturePhoto = false
                    if numberOfAdditionalClick == 0 {
                        viewModel.showSuccessAlert = true
                    }
                    if numberOfAdditionalClick == 0 { return }
                    numberOfAdditionalClick = numberOfAdditionalClick - 1
                    startCountdown()
                
                }
            }
        }
    }
    
}

public struct UploadImageView_Previews: PreviewProvider {
    public static var previews: some View {
        NavigationView {
            DummyContainerView()
        }
    }
    
    public struct DummyContainerView: View {
        @State private var isVisible: Bool = true

        public var body: some View {
            UploadImageView(isVisible: $isVisible)
        }
    }
}
