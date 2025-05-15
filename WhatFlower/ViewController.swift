
import UIKit
import CoreML
import Vision
import SwiftyJSON
import Alamofire

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    let wikipediaURl = "https://en.wikipedia.org/w/api.php"
    var pickedImage : UIImage?
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var infoLabel: UILabel!

    
    let imagePicker = UIImagePickerController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        
        
//        if let originalImage = UIImage(named: "tiger_lily.jpg") {
//            // Resize to model's expected input size, e.g. 227x227
//            let resizedImage = resizeImage(originalImage, targetSize: CGSize(width: 227, height: 227))
//
//            // Convert to CIImage
//            guard let ciImage = CIImage(image: resizedImage) else {
//                fatalError("❌ 無法轉換圖片成 CIImage")
//            }
//
//            // 更新畫面
//            pickedImage = resizedImage
//            imageView.image = resizedImage
//
//            // 執行模型辨識
//            detect(flowerImage: ciImage)
//        }

    }
    func resizeImage(_ image: UIImage, targetSize: CGSize) -> UIImage {
        let format = UIGraphicsImageRendererFormat.default()
        format.scale = 1
        let renderer = UIGraphicsImageRenderer(size: targetSize, format: format)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }


    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let userPickedImage = info[.originalImage] as? UIImage {
            // resize 成模型尺寸
            let resizedImage = resizeImage(userPickedImage, targetSize: CGSize(width: 227, height: 227))

            guard let ciImage = CIImage(image: resizedImage) else {
                fatalError("Could not convert image to CIImage.")
            }

            pickedImage = resizedImage
            imageView.image = resizedImage
            detect(flowerImage: ciImage)
        }

        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    func detect(flowerImage: CIImage) {
        
//        guard let model = try? VNCoreMLModel(for: FlowerClassifier().model) else {
//            fatalError("Can't load model")
//        }
        guard let model = try? VNCoreMLModel(for: FlowerClassifier_convert_Colore().model) else{
            fatalError("Can't load model")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let result = request.results?.first as? VNClassificationObservation else {
                fatalError("Could not complete classfication")
            }
      
            self.navigationItem.title = result.identifier.capitalized
            let predictedLabel = result.identifier.lowercased()

            let mappedFlowerName: String

            switch predictedLabel {
            case "tiger lily":
                mappedFlowerName = "Lilium lancifolium"
            case "lily":
                mappedFlowerName = "Lilium"
            default:
                mappedFlowerName = result.identifier
            }

            self.navigationItem.title = mappedFlowerName.capitalized
            self.requestInfo(flowerName: mappedFlowerName)
            
        }
        
        let handler = VNImageRequestHandler(ciImage: flowerImage)
        
        do {
            try handler.perform([request])
        }
        catch {
            print(error)
        }
        
        
    }
    
    func requestInfo(flowerName: String) {
        let parameters : [String:String] = ["format" : "json", "action" : "query", "prop" : "extracts|pageimages", "exintro" : "", "explaintext" : "", "titles" : flowerName, "redirects" : "1", "pithumbsize" : "500", "indexpageids" : ""]
        
        
        // https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts|pageimages&exintro=&explaintext=&titles=barberton%20daisy&redirects=1&pithumbsize=500&indexpageids
        
        Alamofire.request(wikipediaURl, method: .get, parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess {
            
                let flowerJSON : JSON = JSON(response.result.value!)
                
                let pageid = flowerJSON["query"]["pageids"][0].stringValue
                
                let flowerDescription = flowerJSON["query"]["pages"][pageid]["extract"].stringValue

               
                self.infoLabel.text = flowerDescription
                
                self.imageView.image = self.pickedImage
                    
                    if let currentImage = self.imageView.image {
                        
                        
                        DispatchQueue.main.async {
                            self.navigationController?.navigationBar.isTranslucent = true
                            
                            
                            
                        }
                    } else {
                        self.imageView.image = self.pickedImage
                        self.infoLabel.text = "Could not get information on flower from Wikipedia."
                    }
                
            }
            else {
                print("Error \(String(describing: response.result.error))")
                self.infoLabel.text = "Connection Issues"
                
            }
        }
    }
    
    
    
    @IBAction func cameraTapped(_ sender: Any) {
        
        self.present(self.imagePicker, animated: true, completion: nil)

    }
    
}




// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
