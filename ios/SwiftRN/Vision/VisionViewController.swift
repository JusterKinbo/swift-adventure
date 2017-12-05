//
//  VisionViewController.swift
//  New2Swift4
//
//  Created by bjjiachunhui on 2017/11/9.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//

import UIKit
import Vision
import CoreML

/// 处理只支持方向向上的图片
class VisionViewController: UIViewController {
    var imageView: UIImageView!
    var result:UILabel!
    var resultLAB:UILabel!
    var sc:UIScrollView!
    
    lazy var classificationRequest: VNCoreMLRequest = {
        do {
            /*
             Use the Swift class `MobileNet` Core ML generates from the model.
             To use a different Core ML classifier model, add it to the project
             and replace `MobileNet` with that model's generated Swift class.
             */
            let model = try VNCoreMLModel(for: MobileNet().model)
            
            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                self?.processClassifications(for: request, error: error)
            })
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to load Vision ML model: \(error)")
        }
    }()
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear")
    }
    override func viewDidAppear(_ animated: Bool) {
        print("view did appear")
        if let scr = sc
        {
            scr.contentSize = CGSize(width:UIScreen.main.bounds.width,height:1000)
            print("contentViewSize",sc.contentSize)
        }
        
    }
    override func viewDidLayoutSubviews() {
        print("view did LayoutSubviews")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load")
        // Do any additional setup after loading the view.
        let imageViewMarginTop:CGFloat = UIScreen.main.bounds.height == 812 ? 88+4 : 64+4
        let btnWidth = 120
        let viewVerticalMargin = 10
        
        sc = UIScrollView(frame: CGRect(x:25,y:imageViewMarginTop,width:UIScreen.main.bounds.width-50,height:UIScreen.main.bounds.height - imageViewMarginTop))
        //        sc.contentSize = CGSize.init(width: UIScreen.main.bounds.width, height: 600)
        self.view.addSubview(sc)
        sc.backgroundColor = .green
        self.view.backgroundColor = .gray
        //统一生成view
        imageView = UIImageView()
        imageView.image = UIImage(named:"SamUncle")
        
        let camerBTN = UIFactory.button(title: "camera")
        let photoBTN = UIFactory.button(title: "photo")
        let faceBTN = UIFactory.button(title: "face detection")
        let textBTN = UIFactory.button(title: "text detection")
        let barcodeBTN = UIFactory.button(title: "barcode detection")
        let coreMLBTN = UIFactory.button(title: "core ml")
        let horizonBTN = UIFactory.button(title: "horizon angle")
        let trackBTN = UIFactory.button(title: "track imgs")//保留
        
        let resultTintLAB = UIFactory.label(text: "result:")
        resultLAB = UIFactory.multiLineLable(text: "我是默认值12345\n.\n.\n.")
        //统一添加view，可以看层级
        sc.addSubview(imageView)
        
        sc.addSubview(camerBTN)
        sc.addSubview(photoBTN)
        sc.addSubview(faceBTN)
        sc.addSubview(textBTN)
        sc.addSubview(barcodeBTN)
        sc.addSubview(coreMLBTN)
        sc.addSubview(horizonBTN)
        sc.addSubview(trackBTN)
        
        sc.addSubview(resultTintLAB)
        sc.addSubview(resultLAB)
        //添加事件
        camerBTN.addTarget(self, action:#selector(cameraBTNCLK(id:)), for: UIControlEvents.touchUpInside)
        photoBTN.addTarget(self, action:#selector(photoBTNCLK(sender:)), for: .touchUpInside)
        faceBTN.addTarget(self, action:#selector(faceBTNCLK(sender:)), for: .touchUpInside)
        textBTN.addTarget(self, action:#selector(textBTNCLK(sender:)), for: .touchUpInside)
        barcodeBTN.addTarget(self, action:#selector(barcodeBTNCLK(sender:)), for: .touchUpInside)
        coreMLBTN.addTarget(self, action:#selector(coreMLBTNCLK(sender:)), for: .touchUpInside)
        horizonBTN.addTarget(self, action:#selector(horizonAngleBTNCLK(sender:)), for: .touchUpInside)
        trackBTN.addTarget(self, action:#selector(trackBTNCLK(sender:)), for: .touchUpInside)
        //*******添加约束前设置translatesAutoresizingMaskIntoConstraints
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        //views字典
        let iv = "imageView",camera = "cameraBTN",photo = "photoBTN",face = "faceBTN",text="textBTN",barcode="barcodeBTN",coreML="coremlBTN",horizon="horizonBTN",track="tarckBTN",resultTint="resultTint",result="reulst"
        let viewDic = [iv:imageView!,camera:camerBTN,photo:photoBTN,face:faceBTN,text:textBTN,barcode:barcodeBTN,coreML:coreMLBTN,horizon:horizonBTN,track:trackBTN,resultTint:resultTintLAB,result:resultLAB] as [String : Any]
        //matrics字典
        let matrics = ["viewVerticalMargin":viewVerticalMargin,"btnWidth":btnWidth]
        //统一添加约束
        var con = [NSLayoutConstraint]()
        
        //imageView
        con.append(imageView.centerXAnchor.constraint(equalTo: sc.centerXAnchor))
        con.append(imageView.heightAnchor.constraint(equalTo: sc.widthAnchor, multiplier: 1.2))
        con.append(imageView.topAnchor.constraint(equalTo: sc.topAnchor, constant: 5))
        con.append(contentsOf:NSLayoutConstraint.constraints(withVisualFormat:"H:|-50-[\(iv)]-50-|", metrics:matrics, views:viewDic))
        //cameraBTN photoBTN
        con.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[\(iv)]-(viewVerticalMargin)-[\(camera)]",  metrics: matrics, views: viewDic))
        con.append(camerBTN.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 50))
        
        con.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[\(iv)]-(viewVerticalMargin)-[\(photo)]",  metrics: matrics, views: viewDic))
        con.append(photoBTN.rightAnchor.constraint(equalTo: imageView.rightAnchor,constant:-50))
        con.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:[\(camera)]-(>=30)-[\(photo)(\(camera))]", options: .alignAllCenterY, metrics: matrics, views: viewDic))
        //face / text / barcode / coreML / track BTN
        con.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[\(camera)]-(viewVerticalMargin)-[\(face)]",  metrics: matrics, views: viewDic))
        con.append(faceBTN.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: -20))
        con.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[\(face)]-(<=10)-[\(text)]-(<=10)-[\(barcode)]-(<=10)-[\(coreML)]-(<=10)-[\(horizon)]-(<=10)-[\(track)]", options: [.alignAllLeft,.alignAllRight], metrics: matrics, views: viewDic))
        
        //resultTint result lable
        con.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[\(photo)]-(viewVerticalMargin)-[\(resultTint)]",  metrics: matrics, views: viewDic))
        con.append(resultTintLAB.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: 20))
        con.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[\(resultTint)]-(<=10)-[\(result)]", options: [.alignAllLeft,.alignAllRight], metrics: matrics, views: viewDic))
        con.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:[\(face)]-(>=30)-[\(resultTint)]", metrics: matrics, views: viewDic))
        
        NSLayoutConstraint.activate(con)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func presentPhotoPicker(sourceType: UIImagePickerControllerSourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        present(picker, animated: true)
    }
    
    @objc func cameraBTNCLK(id:UIButton)
    {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            resultLAB.text = "camera \n不可用"
            return
        }
        presentPhotoPicker(sourceType: .camera)
    }
    @objc func photoBTNCLK(sender:UIButton)
    {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            resultLAB.text = "photoLibray \n不可用"
            return
        }
        presentPhotoPicker(sourceType: .photoLibrary)
    }
    /**
     * ## Vison
     * VNImageRequestHandler：适合单张图片
     * VNSequenceRequestHandler:适合多张图片
     */
    func getImageRequestHandler() -> VNImageRequestHandler!
    {
        guard let ciIMG = CIImage(image:imageView.image!) else
        {
            return nil
        }
        let handler = VNImageRequestHandler(ciImage: ciIMG, orientation: CGImagePropertyOrientation.up)
        return handler
    }
    @objc func faceBTNCLK(sender:UIButton)
    {
        guard let handler = getImageRequestHandler() else { return }
        let request = VNDetectFaceRectanglesRequest(completionHandler: { (request, error) in
            
            DispatchQueue.main.async {
                
                if let result = request.results {
                    
                    let transform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -self.imageView!.frame.size.height)
                    let translate = CGAffineTransform.identity.scaledBy(x: self.imageView!.frame.size.width, y: self.imageView!.frame.size.height)
                    
                    guard  result.count != 0 else
                    {
                        self.resultLAB.text = "no face\n识别不精确"
                        return
                    }
                    //遍历所有识别结果
                    for item in result {
                        
                        //绿色标注框
                        let faceRect = UIView(frame: CGRect.zero)
                        faceRect.backgroundColor = UIColor(red: 0, green: 1.0, blue: 0, alpha: 0.5)
                        self.imageView!.addSubview(faceRect)
                        
                        if let faceObservation = item as? VNFaceObservation {
                            let finalRect = faceObservation.boundingBox.applying(translate).applying(transform)
                            faceRect.frame = finalRect
                            
                        }
                        
                    }
                    
                }else
                {
                    self.resultLAB.text = "no face"
                }
            }
            
            
        })
        DispatchQueue.global(qos: .userInteractive).async {
            
            do {
                
                try handler.perform([request])
                
            } catch {
                
                
                
            }
            
        }
        
    }
    ///类似人脸识别，但是无法做到识别到具体的字母或数字，不精确
    @objc func textBTNCLK(sender:UIButton)
    {
        guard let handler = getImageRequestHandler() else { return }
        let textRequest = VNDetectTextRectanglesRequest(completionHandler: self.detectTextHandler)
        textRequest.reportCharacterBoxes = true
        do {
            
            try handler.perform([textRequest])
            
        } catch {
            
            
            
        }
    }
    
    
    func detectTextHandler(request: VNRequest, error: Error?) {
        guard let observations = request.results else {
            self.resultLAB.text = "no text"
            return
        }
        let result = observations.map({$0 as? VNTextObservation})
        guard  result.count != 0 else
        {
            self.resultLAB.text = "no text\n识别不精确"
            return
        }
        self.imageView.layer.sublayers?.removeSubrange(1...)
        DispatchQueue.main.async() {
            for region in result {
                guard let rg = region else {
                    continue
                }
                
                self.highlightWord(box: rg)
                if let boxes = region?.characterBoxes {
                    for characterBox in boxes {
                        self.highlightLetters(box: characterBox)
                    }
                }
            }
        }
    }
    func highlightWord(box: VNTextObservation) {
        guard let boxes = box.characterBoxes else {
            return
        }
        
        var maxX: CGFloat = 9999.0
        var minX: CGFloat = 0.0
        var maxY: CGFloat = 9999.0
        var minY: CGFloat = 0.0
        
        for char in boxes {
            if char.bottomLeft.x < maxX {
                maxX = char.bottomLeft.x
            }
            if char.bottomRight.x > minX {
                minX = char.bottomRight.x
            }
            if char.bottomRight.y < maxY {
                maxY = char.bottomRight.y
            }
            if char.topRight.y > minY {
                minY = char.topRight.y
            }
        }
        
        let xCord = maxX * imageView.frame.size.width
        let yCord = (1 - minY) * imageView.frame.size.height
        let width = (minX - maxX) * imageView.frame.size.width
        let height = (minY - maxY) * imageView.frame.size.height
        
        let outline = CALayer()
        outline.frame = CGRect(x: xCord, y: yCord, width: width, height: height)
        outline.borderWidth = 2.0
        outline.borderColor = UIColor.red.cgColor
        
        imageView.layer.addSublayer(outline)
    }
    
    func highlightLetters(box: VNRectangleObservation) {
        let xCord = box.topLeft.x * imageView.frame.size.width
        let yCord = (1 - box.topLeft.y) * imageView.frame.size.height
        let width = (box.topRight.x - box.bottomLeft.x) * imageView.frame.size.width
        let height = (box.topLeft.y - box.bottomLeft.y) * imageView.frame.size.height
        
        let outline = CALayer()
        outline.frame = CGRect(x: xCord, y: yCord, width: width, height: height)
        outline.borderWidth = 1.0
        outline.borderColor = UIColor.blue.cgColor
        
        imageView.layer.addSublayer(outline)
    }
    
    @objc func barcodeBTNCLK(sender:UIButton)
    {
        guard let handler = getImageRequestHandler() else { return }
        let textRequest = VNDetectBarcodesRequest { (request, error) in
            guard let observations = request.results else {
                print("no result")
                return
            }
            
            guard  observations.count != 0 else
            {
                self.resultLAB.text = "no barcode\n识别不精确"
                return
            }
            
            print("has result.count",observations.count)
            let result = observations.map({$0 as? VNBarcodeObservation})
            print("result.count",result.count)
            DispatchQueue.main.async() {
                for barcode in result {
                    print("1111")
                    guard let code = barcode else {
                        continue
                    }
                    print("**** value:",code.payloadStringValue ?? "default value")
                    self.resultLAB.text = "barcode\n"+code.payloadStringValue!
                }
            }
        }
        do {
            
            try handler.perform([textRequest])
            
        } catch {
            
            
            
        }
    }
    
    @objc func horizonAngleBTNCLK(sender:UIButton)
    {
        guard let handler = getImageRequestHandler() else { return }
        let textRequest = VNDetectHorizonRequest { (request, error) in
            guard let observations = request.results else {
                print("no result")
                return
            }
            
            guard  observations.count != 0 else
            {
                self.resultLAB.text = "no Horizon \nangle\n识别不精确"
                return
            }
            
            print("has result.count",observations.count)
            let result = observations.map({$0 as? VNHorizonObservation})
            print("result.count",result.count)
            DispatchQueue.main.async() {
                for horizonAngle in result {
                    guard let hA = horizonAngle else {
                        continue
                    }
                    print("**** value:",hA.angle )
                    self.resultLAB.text = "angle:\n \(hA.angle)"+"\n tranform:\n" + String(describing: hA.transform)
                }
            }
        }
        do {
            
            try handler.perform([textRequest])
            
        } catch {
            
            
            
        }
    }
    
    
    @objc func coreMLBTNCLK(sender:UIButton)
    {
        
        guard let ciImage = CIImage(image: imageView.image!) else {
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: CGImagePropertyOrientation.up)
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
        DispatchQueue.main.async { [weak self] in
            guard let results = request.results else {
                self?.resultLAB.text = "Unable to classify image.\n\(error!.localizedDescription)"
                return
            }
            // The `results` will always be `VNClassificationObservation`s, as specified by the Core ML model in this project.
            let classifications = results as! [VNClassificationObservation]
            
            if classifications.isEmpty {
                self?.resultLAB.text = "Nothing recognized."
            } else {
                // Display top classifications ranked by confidence in the UI.
                let topClassifications = classifications.prefix(2)
                let descriptions = topClassifications.map { classification in
                    // Formats the classification for display; e.g. "(0.37) cliff, drop, drop-off".
                    return String(format: "  (%.2f) %@", classification.confidence, classification.identifier)
                }
                self?.resultLAB.text = "Classification:\n" + descriptions.joined(separator: "\n")
            }
        }
    }
    
    @objc func trackBTNCLK(sender:UIButton)
    {
        resultLAB.text = "iOS已经实现\n效果敬请期待"
    }
    
}
extension VisionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - Handling Image Picker Selection
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        picker.dismiss(animated: true)
        
        //重新选择的时候保证消除添加的绿色view消失
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
        resultLAB.text = "你刚刚取消了\n能不能好好选择个图片"
    }
    
}


