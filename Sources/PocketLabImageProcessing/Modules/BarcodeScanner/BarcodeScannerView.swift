import SwiftUI
import AVFoundation

struct BarcodeScannerView: UIViewControllerRepresentable {
    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: BarcodeScannerView
        init(parent: BarcodeScannerView) {
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
            metadataOutput.metadataObjectTypes = [.qr, .ean8, .ean13, .pdf417]
        } else {
            return viewController
        }

        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = viewController.view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        viewController.view.layer.addSublayer(previewLayer)

        session.startRunning()

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct BannerScannerView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var scannedCode: String?
    @State private var showAlert = false
    @State private var userInput = ""
//    @Binding var indentificationCompleted: Bool
    var clicked: ((String) -> Void)
    var body: some View {
        VStack {
//            if let scannedCode = scannedCode {
//                Text("Scanned Code: \(scannedCode)")
//            } else {
                ZStack {
                    BarcodeScannerView { code in
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
                    
                    Color.black
                                    .opacity(0.4)

                    VStack {
                        Spacer()
                        Image(systemName: "qrcode.viewfinder")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.white)
                        Spacer().frame(height: 40)
                        VStack {
                            RoundedRectangle(cornerRadius: 12)
                                     .stroke(Color.white, lineWidth: 2)
                                     .frame(width: 250, height: 250)
                                     .background(Color.clear)
                              }
                        Spacer().frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        HStack {
                            Image(systemName: "keyboard.fill")
                                .resizable()
                                .frame(width: 60, height: 40)
                                .foregroundColor(.white)
                            Spacer().frame(width: 80)
                            Image(systemName: "flashlight.off.fill")
                                .resizable()
                                .frame(width: 20, height: 40)
                                .foregroundColor(.white)
                        }
                        Spacer()
                        Button(action: {
                            showAlert = true
                        }, label: {
                            Text("Generate identifier")
                                .font(.headline)
                                .frame(maxWidth: .infinity, minHeight: 45)
                                .foregroundColor(PackageColors.blue)
                                .background(PackageColors.darkGreyColor.opacity(0.6))
                                .cornerRadius(6)
                        })
                        .padding()
                      

                    }
                    .ignoresSafeArea(.all)
                 
//                    Image(systemName: "flashlight.off.fill")
                
                 
//                }
          
//                .alert(isPresented: $showAlert) {
//                    Alert(
//                        title: Text("QR Code Scanned"),
//                        message: Text("Enter a value:"),
//                        primaryButton: .default(Text("OK")) {
//                            // Handle OK button tap
//                            print("User input: \(userInput)")
//                        },
//                        secondaryButton: .cancel()
//                    )
//                    // Text field in the alert
//                    {
//                        TextField("Enter value", text: $userInput)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                    }
//                }
                
//                .alert(isPresented: $showAlert, content: {
//                        Alert(
//                            title: Text("Enter Text"),
//                            message: Text(""),
//                            primaryButton: .default(Text("OK")) {
//                                // Handle the text input here
////                                print("Entered text: \($userInput)")
//                            },
//                            secondaryButton: .cancel()
//                        )
//                    
//                    })
                
                .alert("Enter your name", isPresented: $showAlert) {
                         TextField("Sample ID", text: $userInput)
                         Button("OK", action: submit)
                     } message: {
                         Text("A unique identifier was generated for your sample.")
                     }
       
               
//                .edgesIgnoringSafeArea(.all)
            }
        }
    }
    
    
    func submit() {
        clicked(userInput)
        presentationMode.wrappedValue.dismiss()
    }
}

struct BannerScannerView_Previews: PreviewProvider {
    static var previews: some View {
        BannerScannerView( clicked: {_ in })
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
