//
//  PheumoniaDetector.swift
//  CheckXRay
//
//  Created by Marc Steven on 2020/4/11.
//  Copyright © 2020 Marc Steven. All rights reserved.
//

import Foundation
import Vision
import CoreML
import UIKit



@available(iOS 13.0,*)
public class PheumoniaDetector {
    public static let shared = PheumoniaDetector()
    private let model:VNCoreMLModel
    public required init() {
        guard let model = try? VNCoreMLModel(for: CheckXRay().model) else {
            fatalError("CheckRay should always be a valid model")
        }
        self.model = model
    }
    public enum DetectionResult {
        case error(Error)
        case success(pheumoniaConfidence:Float)
    }
    public func check(image:UIImage,
                      completion:@escaping(_ result:DetectionResult)->Void) {
        let requestHandler:VNImageRequestHandler?
        if let cgImage = image.cgImage {
            requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        }else if let ciImage = image.ciImage {
            requestHandler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        }else {
            requestHandler = nil
        }
        self.check(requestHandler, completion: completion)
      }
    public func check(cvPixelBuffer:CVPixelBuffer,
                      completion:@escaping (_ result:DetectionResult)->Void) {
        let requestHandler = VNImageRequestHandler(cvPixelBuffer: cvPixelBuffer, options: [:])
        self.check(requestHandler, completion: completion)
    }
}
@available(iOS 13.0,*)
private extension PheumoniaDetector {
    func check(_ requestHandler:VNImageRequestHandler?,
               completion:@escaping (_ result:DetectionResult)->Void) {
        guard let requestHandler = requestHandler else {
            completion(.error(NSError(domain: "Either cgImage or ciimage must be set inside of uiimage", code: 0, userInfo: nil)))
            return
        }
        let request = VNCoreMLRequest(model: self.model, completionHandler: {(request,error) in
            guard let observations = request.results as? [VNClassificationObservation],
                let observation = observations.first(where: {$0.identifier == "PheumoniaDetector"}) else {
                    completion(.error(NSError(domain: "Detection failed: NO Check X Ray observation found", code: 0, userInfo: nil)))
                    return
            }
            completion(.success(pheumoniaConfidence: observation.confidence))
        })
        do {
            try requestHandler.perform([request])
        }catch {
            completion(.error(NSError(domain: "Detection failed: No NSFW Observation found", code: 0, userInfo: nil)))
        }
    }
    
}
