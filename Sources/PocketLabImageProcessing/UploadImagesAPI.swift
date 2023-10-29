//
//  UploadImagesAPI.swift
//

import Foundation
import UIKit

public protocol UploadImagesAPI {
     func uploadImage(image: ImageModel, success: @escaping (ImageInfo) -> (), failure: @escaping (Error) -> ())
     func uploadImageStatus(fieldId: String, success: @escaping (ImageDetail) -> (), failure: @escaping (Error) -> ())
}

public  extension UploadImagesAPI {

     func uploadImage(image: ImageModel, success: @escaping (ImageInfo) -> (), failure: @escaping (Error) -> ()) {
        let urlSession = URLSession.shared
        
        let paramsOfCaptureDevice = [
            "id": UIDevice.current.model,
            "name": UIDevice.current.name,
            "os": "iOS",
            "version": UIDevice.current.systemVersion
        ]
        
        var params = [String : Any]()
        params["site"] = image.site
        params["x"] =  image.x
        params["y"] =  image.y
        params["z"] =  image.z
        params["yaw"] =  image.yaw
        params["captured_device"] = paramsOfCaptureDevice
        
        let request = EndPoint.uploadImage.request(body: params)
        let file = [URLSession.File(name: "image", fileName: "image.jpg", data: image.imageData, contentType: "image/jpeg")]
        urlSession.upload(request: request, params: params, files: file, success: success, failure: failure)
    }
    
     func uploadImageStatus(fieldId: String, success: @escaping (ImageDetail) -> (), failure: @escaping (Error) -> ()){
        let urlSession = URLSession.shared
        let data = [
            "isUploaded": true
        ]
        let request = EndPoint.uploadImageStatus(fieldId: fieldId).request(body: data)
        urlSession.dataTask(request: request, success:success, failure: failure)
    }
    
}

public func convertUIImageToDataWithCompression(image: UIImage, compressionQuality: CGFloat) -> Data {
    if let compressedData = image.jpegData(compressionQuality: compressionQuality) {
        return compressedData
    }
    return  Data()
}
