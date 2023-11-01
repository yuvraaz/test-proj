import SwiftUI
import RealityKit
import ARKit
import CoreMotion

struct ARViewContainer : UIViewRepresentable {
    
    @Binding var distance: Float
    @Binding var capturePhoto: Bool
    @Binding var capturedPhoto: UIImage
    @Binding var isPaused: Bool
    @Binding var readyToCapture: Bool
    
    func makeUIView(context: Context) -> some UIView {
        let arView = ARView(frame: .zero)
        let config = ARWorldTrackingConfiguration()
        config.environmentTexturing = .automatic
        arView.session.delegate = context.coordinator
        arView.session.run(config)
        return arView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let arView = uiView as? ARView {
                let config = ARWorldTrackingConfiguration()
                config.environmentTexturing = .automatic
                arView.session.run(config, options: [])
        }
    }
    
    func makeCoordinator() -> ARSessionDelegateCoordinator {
        return ARSessionDelegateCoordinator(distance: $distance, capturePhoto: $capturePhoto, capturedPhoto: $capturedPhoto, readyToCapture: $readyToCapture)
    }
    
}

class ARSessionDelegateCoordinator : NSObject, ARSessionDelegate {
    @Binding var distance : Float
    @Binding var capturePhoto: Bool
    @Binding var capturedPhoto: UIImage
    @Binding var readyToCapture: Bool
    
    init(distance : Binding<Float>, capturePhoto: Binding<Bool>,  capturedPhoto: Binding<UIImage>, readyToCapture: Binding<Bool>) {
        _distance = distance
        _capturePhoto = capturePhoto
        _capturedPhoto = capturedPhoto
        _readyToCapture = readyToCapture
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame){
        guard let currentPointOnCloud = frame.rawFeaturePoints else {return}
        let cameraTransform = frame.camera.transform
        var closeestDistance : Float = Float.greatestFiniteMagnitude
        
        for point in currentPointOnCloud.points {
            let pointInCameraSpace = cameraTransform.inverse*simd_float4(point,1)
            let distanceToCamera = sqrt(pointInCameraSpace.x*pointInCameraSpace.x+pointInCameraSpace.y*pointInCameraSpace.y+pointInCameraSpace.z*pointInCameraSpace.z)
            print(distanceToCamera)
            readyToCapture = !(distanceToCamera > 0.6 ||  distanceToCamera < 0.1)
            if(distance < closeestDistance){
                closeestDistance = distanceToCamera
            }
            if capturePhoto == true {
                captureImage(session, didUpdate: frame)
            }
        }
        calculateMedian(distance: closeestDistance)
    }
    var count = 0
    /// calculateMedian
    /// - Parameter distance: distance between camera and front object
    func calculateMedian(distance:Float) {
        // distance = closeestDistance
        var distArray: [Float] = []
        distArray.insert(distance, at: count)
        let sorted = distArray.sorted()
        if sorted.count % 2 == 0 {
            self.distance = Float((sorted[(sorted.count / 2)] + sorted[(sorted.count / 2) - 1])) / 2
        } else {
            self.distance = Float(sorted[(sorted.count - 1) / 2])
        }
        if count == 5 {
            distArray.removeAll()
        }
        
    }
    
    func captureImage(_ session: ARSession, didUpdate frame: ARFrame) {
          toggleFlashlight(on: true)
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
              self.toggleFlashlight(on: false)
          }
        DispatchQueue.main.async {
            if let img: CVPixelBuffer = session.currentFrame?.capturedImage {
                let ciImage = CIImage(cvPixelBuffer: img)
                  let context = CIContext()
                if let cgImage = context.createCGImage(ciImage, from: ciImage.extent) {
                    self.capturedPhoto =  UIImage(cgImage: cgImage)
                }
                self.capturePhoto = false
            }
        }
    }
    
    /// toggleFlashlight
    /// - Parameter on: on to turn on flash light
    func toggleFlashlight(on: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                if on {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }
                device.unlockForConfiguration()
            } catch {
                print("Flashlight could not be used")
            }
        }
    }

    
}
