/*
See LICENSE folder for this sample’s licensing information.

Abstract:
View controller for selecting images and applying Vision + Core ML processing.
*/

import UIKit
import CoreML
import Vision
import ImageIO

class ImageClassificationViewController: UIViewController {
    // MARK: - IBOutlets
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var classificationLabel: UILabel!
    
    var divisionParam: CGFloat!
    var classificationArray: [String]!
    
    // MARK: - Image Classification
    
    override func viewWillAppear(_ animated: Bool) {
        if Manager.shared.tookPicture == false {
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                presentPhotoPicker(sourceType: .photoLibrary)
                return
            }
            presentPhotoPicker(sourceType: .camera)
            Manager.shared.tookPicture = true
        }
        
        cardView.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2 + 200)
        cardView.transform = .identity
        divisionParam = (self.view.frame.size.width/2)/0.61
        
    }
    
    @IBAction func cameraPan(_ sender: UIPanGestureRecognizer) {
        let cardView = sender.view!
        let translationPoint = sender.translation(in: view)
        cardView.center = CGPoint(x: self.view.frame.size.width/2 + translationPoint.x, y: self.view.frame.size.height/2 + 200 + translationPoint.y)
        
        if sender.state == UIGestureRecognizer.State.ended {
            if (cardView.center.x > (view.frame.size.width-20)) { // Moved to right
                
                for line in self.classificationArray {
                    if line.contains(Manager.shared.respostas[Manager.shared.i].resposta) {
                        performSegue(withIdentifier: "segueCamera", sender: nil)
                        return
                    } else {
                        performSegue(withIdentifier: "segueCameraFail", sender: nil)
                        return
                    }
                }
                
                UIView.animate(withDuration: 0.3, animations: {
                    cardView.center = CGPoint(x: cardView.center.x+200, y: cardView.center.y)
                })
                return
            }
            
            UIView.animate(withDuration: 0.2, animations: {
                cardView.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2 + 200)
                cardView.transform = .identity
            })
        }
        
        let distanceMoved = cardView.center.x - view.center.x
        cardView.transform = CGAffineTransform(rotationAngle: distanceMoved/divisionParam)
    }
    
    /// - Tag: MLModelSetup
    lazy var classificationRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel(for: Inceptionv3().model)
            
            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                self?.processClassifications(for: request, error: error)
            })
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to load Vision ML model: \(error)")
        }
    }()
    
    /// - Tag: PerformRequests
    func updateClassifications(for image: UIImage) {
        classificationLabel.text = "Classifying..."
        
        let orientation = CGImagePropertyOrientation(image.imageOrientation)
        guard let ciImage = CIImage(image: image) else { fatalError("Unable to create \(CIImage.self) from \(image).") }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
            do {
                try handler.perform([self.classificationRequest])
            } catch {
                /*
                 This handler catches general image processing errors. The `classificationRequest`'s
                 completion handler `processClassifications(_:error:)` catches errors specific
                 to processing that request.
                 */
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        }
    }
    
    /// Updates the UI with the results of the classification.
    /// - Tag: ProcessClassifications
    func processClassifications(for request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            guard let results = request.results else {
                self.classificationLabel.text = "Unable to classify image.\n\(error!.localizedDescription)"
                return
            }
            // The `results` will always be `VNClassificationObservation`s, as specified by the Core ML model in this project.
            let classifications = results as! [VNClassificationObservation]
        
            if classifications.isEmpty {
                self.classificationLabel.text = "Nothing recognized."
            } else {
                // Display top classifications ranked by confidence in the UI.
                let topClassifications = classifications.prefix(3)
                let descriptions = topClassifications.map { classification in
                    // Formats the classification for display; e.g. "(0.37) cliff, drop, drop-off".
                   return String(format: "  (%.2f) %@", classification.confidence, classification.identifier)
                }
                self.classificationArray = descriptions
                self.classificationLabel.text = "Classification:\n" + descriptions.joined(separator: "\n")
                
            }
        }
    }
    
    func presentPhotoPicker(sourceType: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        present(picker, animated: true)
    }
}

extension ImageClassificationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - Handling Image Picker Selection

    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        imageView.image = image
        updateClassifications(for: image)
        Manager.shared.tookPicture = true
    }
}
