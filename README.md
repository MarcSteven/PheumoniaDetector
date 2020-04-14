# PheumoniaDetector
PheumoniaDetector is s a small (17 kB) CoreML Model to scan images for pheumonia. It was trained using CreateML to check the disease pheumonia via xRay photos.
# Usage
  `guard  let detector = PheumoniaDetector.shared else {
    return
  }

  detector.check(image: image, completion: { result in
    switch result {
    case let .success(pheumoniaConfidence: confidence):
        if confidence > 0.9 {
            // 😱🙈😏
        } else {
            // ¯\_(ツ)_/¯
        }
    default:
        break
     }
  })`


# Installation
available through CocoaPods. To install it, simply add the following line to your Podfile:

`pod 'PheumoniaDetector'`
