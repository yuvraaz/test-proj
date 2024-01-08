import SwiftUI
import AVFoundation

struct IdentificationRepresentableView: UIViewControllerRepresentable {
    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: IdentificationRepresentableView
        init(parent: IdentificationRepresentableView) {
            self.parent = parent
        }

        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if let metadataObject = metadataObjects.first {
                guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
                guard let stringValue = readableObject.stringValue else { return }
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                parent.didFindCode(stringValue)
            }
        }
    }

    var didFindCode: (String) -> Void
    var metadataOutput: AVCaptureMetadataOutput?
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let session = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return viewController }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return viewController
        }

        if (session.canAddInput(videoInput)) {
            session.addInput(videoInput)
        } else {
            return viewController
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (session.canAddOutput(metadataOutput)) {
            session.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(context.coordinator, queue: DispatchQueue.main)
//            metadataOutput.metadataObjectTypes = [.qr, .ean8, .ean13, .pdf417]
            metadataOutput.metadataObjectTypes = [.qr, .ean8, .ean13, .pdf417, .upce, .code128]
//            let scanningArea = CGRect(x: 0.25, y: 0.25, width: 0.5, height: 0.5) // Adjust these values as needed
//                     metadataOutput.rectOfInterest = scanningArea
            
            
        } else {
            return viewController
        }

        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = viewController.view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        viewController.view.layer.addSublayer(previewLayer)
        DispatchQueue.global(qos: .userInitiated).async {
            session.startRunning()
              }
        

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    func setRectOfInterest(_ rect: CGRect) {
        metadataOutput?.rectOfInterest = rect
    }

}

struct IdentificationView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var scannedCode: String?
    @State private var showAlert = false
    @State private var userInput = ""
    var identificationRepresentableView = IdentificationRepresentableView(didFindCode: { _ in })
//    @Binding var indentificationCompleted: Bool
    var clicked: ((String) -> Void)
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    IdentificationRepresentableView { code in
                    self.scannedCode = code
                        userInput = code
                        self.showAlert = true
                    }
                    // Dark overlay
                    Color.black.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            // Handle tap gesture if needed
                        }
                    
                    Color.black.opacity(0.4)

                    VStack {
                     
                        if !isLandScape(geometry: geometry){
                            Spacer()
                            Image(systemName: "qrcode.viewfinder")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.white)
                            Spacer().frame(height: 40)
                        }
                        if isLandScape(geometry: geometry){
                            Spacer()
                        }
                        
                    
                        HStack {
                            if isLandScape(geometry: geometry){
                                Spacer()
                                VStack {
                                    Image(systemName: "qrcode.viewfinder")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                        .foregroundColor(.white)
                                    Spacer().frame(height: 40)
                                    GenerateButtonView(showAlert: $showAlert)
                                        .frame(width: 220)
                                }
                                Spacer().frame(width: 20)
                            }
                            
                            VStack {
                                RoundedRectangle(cornerRadius: 12)
                                         .stroke(Color.white, lineWidth: 2)
                                         .frame(width: isLandScape(geometry: geometry) ? 300 : 250, height:  isLandScape(geometry: geometry) ? 250 : 250)
                                         .background(Color.clear)
                                         .onAppear {
                                                    // Calculate the normalized coordinates for the region of interest
                                                    let rectFrame = CGRect(x: 0, y: 0, width: isLandScape(geometry: geometry) ? 300 : 250, height: isLandScape(geometry: geometry) ? 300 : 250)
                                                    let normalizedRect = CGRect(x: rectFrame.origin.x / geometry.size.width,
                                                                                y: rectFrame.origin.y / geometry.size.height,
                                                                                width: rectFrame.size.width / geometry.size.width,
                                                                                height: rectFrame.size.height / geometry.size.height)

                                                    // Set the region of interest
                                                    identificationRepresentableView.setRectOfInterest(normalizedRect)
                                                }
                                  }
                            
                            if isLandScape(geometry: geometry){
                                KeyboardAndFlashView(geometry: geometry)
                                    .frame(width: 220)
                                Spacer()
                            }
                            
                            
                        }
                        if isLandScape(geometry: geometry){
                            Spacer()
                        }
                        
                        if !isLandScape(geometry: geometry){
                            Spacer().frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                            KeyboardAndFlashView(geometry: geometry)
                            Spacer()
                            GenerateButtonView(showAlert: $showAlert)
                            Spacer().frame(height: 30)
                        }
                      
                    }
                    .alert("Enter your name", isPresented: $showAlert) {
                         TextField("Sample ID", text: $userInput)
                         Button("OK", action: submit)
                     } message: {
                         Text("A unique identifier was generated for your sample.")
                     }
            }
                }

        }
        .ignoresSafeArea()
    }
    

    
    func submit() {
        clicked(userInput)
        presentationMode.wrappedValue.dismiss()
    }
}

func isLandScape(geometry: GeometryProxy) -> Bool {
    return geometry.size.width > geometry.size.height
}


struct BannerScannerView_Previews: PreviewProvider {
    static var previews: some View {
        IdentificationView( clicked: {_ in })
    }
}

struct BorderedView: View {
    var body: some View {
        Rectangle()
                 .frame(width: 200, height: 200)
                 .cornerRadius(12)
                 .overlay(
                     RoundedRectangle(cornerRadius: 12)
                         .stroke(Color.clear, lineWidth: 1)
                 )
    }
}

struct KeyboardAndFlashView: View {
   var geometry: GeometryProxy
    var body: some View {
        HStack {
//            Image(systemName: "keyboard.fill")
//                .resizable()
//                .frame(width: 60, height: 40)
//                .foregroundColor(.white)
//            Spacer().frame(width: isLandScape(geometry: geometry) ? 60 : 80)
//            Image(systemName: "flashlight.off.fill")
//                .resizable()
//                .frame(width: 20, height: 40)
//                .foregroundColor(.white)
            
            let keyboardImage = Image(systemName: "keyboard.fill")
                    .resizable()
                    .frame(width: 60, height: 40)
                    .foregroundColor(.white)
                
                let flashImage = Image(systemName: "flashlight.off.fill")
                    .resizable()
                    .frame(width: 20, height: 40)
                    .foregroundColor(.white)
                
                if isLandScape(geometry: geometry) {
                    VStack {
                        keyboardImage
                        
                        Spacer().frame(height: 60)
                        
                        flashImage
                    }
                } else {
                    HStack {
                        keyboardImage
                        
                        Spacer().frame(width: 80)
                        
                        flashImage
                    }
                }
        }
    }
}

struct GenerateButtonView: View {
    @Binding var showAlert: Bool
    var body: some View {
        Button(action: {
            showAlert = true
        }, label: {
            Text("Generate identifier")
                .font(.headline)
                .frame(maxWidth: .infinity, minHeight: 45)
                .foregroundColor(PackageColors.blue)
                .background(PackageColors.darkGreyColor.opacity(0.2))
                .cornerRadius(6)
        })
        .padding()
    }
}
