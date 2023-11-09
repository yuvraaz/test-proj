

import Foundation

public class QueueManager:  UploadImagesAPI {
    
    public static var shared = QueueManager()
    var currentScenarioStatus: ScenarioStatus = .notStarted
    
    public func startScenario(imageModel: PackageImageModel?) {
        currentScenarioStatus = .inProgress
        if let imageModelData = imageModel {
            GlobalConstants.KeyValues.activeImageUpload.append(imageModelData)
        }
        if GlobalConstants.KeyValues.activeImageUpload.count == 0 {
            GlobalConstants.KeyValues.remainingImageUpload =  GlobalConstants.KeyValues.remainingImageUpload + GlobalConstants.KeyValues.activeImageUpload
        }
        processImageQueue()
    }
    
    public func addImageToQueue(_ image: PackageImageModel) {
        if currentScenarioStatus == .inProgress {
            GlobalConstants.KeyValues.activeImageUpload.append(image)
        } else {
            // Start processing the queue if it's not busy
            if GlobalConstants.KeyValues.activeImageUpload.isEmpty {
                processImageQueue()
            }
        }
    }
    
    public func processImageQueue() {
        guard !GlobalConstants.KeyValues.activeImageUpload.isEmpty else {
            if GlobalConstants.KeyValues.remainingImageUpload.count > 0 {
                GlobalConstants.KeyValues.activeImageUpload = GlobalConstants.KeyValues.remainingImageUpload
                GlobalConstants.KeyValues.remainingImageUpload = []
                processImageQueue()
            }
            return
        }
        let imageToProcess = GlobalConstants.KeyValues.activeImageUpload.removeFirst()
        uploadImage(image: imageToProcess)
    }
    
    public func processImageUploadQueue() {
        guard currentScenarioStatus == .inProgress else {
            return
        }
        processImageQueue()
    }
}

// MARK : Network
public extension QueueManager {
    
    public func uploadImage(image: PackageImageModel) {
        uploadImage(image: image) { [weak self] imageInfo in
            self?.processImageUploadQueue()
        } failure: { [weak self] error in
            self?.processImageUploadQueue()
        }
    }
}
