

import Foundation

public class QueueManager:  UploadImagesAPI {
    
    public static var shared = QueueManager()
    var currentScenarioStatus: ScenarioStatus = .notStarted
    
    public func startScenario(imageModel: PackageImageModel?) {
        currentScenarioStatus = .inProgress
        if let imageModelData = imageModel {
            PackageGlobalConstants.KeyValues.activeImageUpload.append(imageModelData)
        }
        if PackageGlobalConstants.KeyValues.activeImageUpload.count == 0 {
            PackageGlobalConstants.KeyValues.remainingImageUpload =  PackageGlobalConstants.KeyValues.remainingImageUpload + PackageGlobalConstants.KeyValues.activeImageUpload
        }
        processImageQueue()
    }
    
    public func addImageToQueue(_ image: PackageImageModel) {
        if currentScenarioStatus == .inProgress {
            PackageGlobalConstants.KeyValues.activeImageUpload.append(image)
        } else {
            // Start processing the queue if it's not busy
            if PackageGlobalConstants.KeyValues.activeImageUpload.isEmpty {
                processImageQueue()
            }
        }
    }
    
    public func processImageQueue() {
        guard !PackageGlobalConstants.KeyValues.activeImageUpload.isEmpty else {
            if PackageGlobalConstants.KeyValues.remainingImageUpload.count > 0 {
                PackageGlobalConstants.KeyValues.activeImageUpload = PackageGlobalConstants.KeyValues.remainingImageUpload
                PackageGlobalConstants.KeyValues.remainingImageUpload = []
                processImageQueue()
            }
            return
        }
        let imageToProcess = PackageGlobalConstants.KeyValues.activeImageUpload.removeFirst()
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
