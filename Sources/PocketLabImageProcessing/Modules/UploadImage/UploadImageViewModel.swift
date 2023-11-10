//
//  UploadImageViewModel.swift
//  PocketLab-iOS
//
//  Created by Amrit Duwal on 9/20/23.
//

import Foundation
import SwiftUI
import AVFoundation


public enum PackagePocketLabEnvironment: String {
    case development = "Development"
    case production  = "Production"
    case none        = "None"
}

public var environment: PackagePocketLabEnvironment = .development

public class UploadImageViewModel: BaseViewModel, ObservableObject, UploadImagesAPI {
    
    @Published public var data: PackageScenarioResponseParent?
    @Published public var isBusy = false
    @Published public var error: Error?
    @Published public var tokenExpired = false
     
    public let status = AVCaptureDevice.authorizationStatus(for: .video)
    public var showAlert: Bool?
    public var showSuccessAlert: Bool = false
    public var imageInfo: PackageImageInfo?
    
    public func getData() {
        isBusy = true
        if environment == .development {
            self.isBusy = false
            return
        }
    
    }
    
    public func uploadImage(x: String, y: String, z: String, yaw: String, site: String, image: UIImage) {
        let imageInfo = PackageImageModel(imageData: convertUIImageToDataWithCompression(image: image, compressionQuality: 1), x: x, y: y, z: z, yaw: yaw, site: site)
        QueueManager.shared.startScenario(imageModel: imageInfo)
    }
    
}
