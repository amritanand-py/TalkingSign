//
//  BackwardTranslationViewController.swift
//  FirstScreen
//
//  Created by Amrit Anand on 12/04/23.
//

import UIKit
import AVFoundation



class BackwardTranslationViewController: UIViewController , AVCapturePhotoCaptureDelegate{
    
    
    @IBOutlet weak var screen: UIView!
    
    var captureSession = AVCaptureSession?.self
    let output = AVCapturePhotoOutput()
    var captureDevice: AVCaptureDevice?
    var captureDeviceInput: AVCaptureDeviceInput?
    let previewLayer = AVCaptureVideoPreviewLayer()
    var session = AVCaptureSession()
    
    enum CameraCase {
        case front
        case back
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.layer.addSublayer(previewLayer)
   
        checkCameraPermissions()
    }
    // MARK: - Navigation
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = screen.bounds
        

    }
    
    private func checkCameraPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) {
                granted in guard granted else {
                    return
                }
                DispatchQueue.main.async {
                    self.setUpCamera()
                }
            }
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            setUpCamera()
        @unknown default:
            break
        }
    }
    
    private func setUpCamera() {
        
        if let device = AVCaptureDevice.default(for: .video){
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input){
                    session.addInput(input)
                }
                if session.canAddOutput(output){
                    session.addOutput(output)
                }
                
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
                
                session.startRunning()
                
            }
            catch{
                print(error)
                
            }
        }
    }
    
    @objc private func didTapTakePhoto() {
        output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation() else{
            return
        }
        let image = UIImage(data: data)
        session.stopRunning()
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = view.bounds
        view.addSubview(imageView)
    }

}
