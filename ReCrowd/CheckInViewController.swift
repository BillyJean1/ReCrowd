//
//  CheckInViewController.swift
//  ReCrowd
//
//  Created by Kevin Broeren on 14/12/2017.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import UIKit
import AVFoundation

class CheckInViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    private var detectedEvent: Event?
    
    // OUTLETS
    @IBOutlet weak var greetingsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var iHaveATicketButton: UIButton!
    @IBOutlet weak var iHaveNoTicketButton: UIButton!
    
    // LOCATION CHECK-IN
    private var eventInRange: Event?

    // CAMERA
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?

    // This view will display everything that the camera records (awesome variable name)
    @IBOutlet weak var cameraView: UIView!
    var qrCodeHighlightFrameView:UIView?

    // What do we want to scan? For now: let's just scan everything possible
    let supportedCodeTypes = [AVMetadataObject.ObjectType.upce,
                              AVMetadataObject.ObjectType.code39,
                              AVMetadataObject.ObjectType.code39Mod43,
                              AVMetadataObject.ObjectType.code93,
                              AVMetadataObject.ObjectType.code128,
                              AVMetadataObject.ObjectType.ean8,
                              AVMetadataObject.ObjectType.ean13,
                              AVMetadataObject.ObjectType.aztec,
                              AVMetadataObject.ObjectType.pdf417,
                              AVMetadataObject.ObjectType.qr]

    override func viewWillAppear(_ animated: Bool) {
        greetingsLabel.text = DateService.shared.getDayZoneString()
        
        let user = LoginService.shared.getLoggedInUser()
        nameLabel.text = user?.name ?? (user?.email ?? "Bezoeker")
        
        locationLabel.isHidden = false
        iHaveATicketButton.isHidden = true
        iHaveNoTicketButton.isHidden = true
    }

    override func viewDidLoad() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        FirebaseService.shared.getCheckedInEvent(completionHandler: { [weak weakSelf = self] (event) in
            let userIsAlreadyCheckedIn = event != nil
            if userIsAlreadyCheckedIn {
                CheckInService.shared.currentCheckedInEvent = event
                weakSelf?.alertCheckoutContinue(event: event!)
            } else {
                NotificationCenter.default.addObserver(self, selector: #selector(self.showDetectedEvent), name: CheckInService.shared.updatedEventInRangeNotificationName, object: nil)
                CheckInService.shared.updateEventInRange()
            }
        })
    }
    
    @IBAction func iHaveATicketButtonPressed(_ sender: UIButton) {
        print("User has pressed the the button which indicates that he/she has a ticket.")
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        if captureDevice == nil {
            return
        }
        
        iHaveATicketButton.isHidden = true
        iHaveNoTicketButton.isHidden = true

        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)

            // Bunch of stuff from the tutorial {
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = cameraView.bounds
            cameraView.layer.addSublayer(videoPreviewLayer!)
            // }

            // And last but not least, start the video capture. Now the camera part works.
            captureSession?.startRunning()

            // To highlight the QRCode / BarCode, we need the following coe:
            qrCodeHighlightFrameView = UIView()
            if let qrCodeHighlightFrameView = qrCodeHighlightFrameView {
                qrCodeHighlightFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeHighlightFrameView.layer.borderWidth = 2
                cameraView.addSubview(qrCodeHighlightFrameView)
                cameraView.bringSubview(toFront: qrCodeHighlightFrameView)
            }

        } catch {
            print(error)
            return
        }
    }
    
    @IBAction func iHaveNoTicketButtonPressed(_ sender: UIButton) {
        if let detectedEvent = CheckInService.shared.eventInRange {
            checkIn(atEvent: detectedEvent)
            performSegue(withIdentifier: "Home", sender: self)
        }
    }
    
    func checkIn(atEvent event: Event){
        print("Checking you in.")
        CheckInService.shared.checkIn(atEvent: event)
        performSegue(withIdentifier: "Home", sender: self)
    }
    
    @objc func showDetectedEvent() {
        if let detectedEvent = CheckInService.shared.eventInRange {
            print("Detected event: \(detectedEvent.name).")
            locationLabel.isHidden = true
            iHaveATicketButton.isHidden = false
            iHaveNoTicketButton.isHidden = false
        } else {
            locationLabel.isHidden = true
            iHaveATicketButton.isHidden = false
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {

        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeHighlightFrameView?.frame = CGRect.zero
            print("QR/Barcode scanner :: No QR/barcode was detected.")
            return
        }

        // Get the metadata object we want (first one).
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject

        if supportedCodeTypes.contains(metadataObj.type) {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeHighlightFrameView?.frame = barCodeObject!.bounds

            if metadataObj.stringValue != nil {
                print("QR/Barcode scanner :: Detected code: \(String(describing: metadataObj.stringValue)).")
                if let detectedEvent = CheckInService.shared.eventInRange {
                    // Todo: we should do something with the scanned ticket
                    checkIn(atEvent: detectedEvent)
                    performSegue(withIdentifier: "Home", sender: self)
                }
            }
        }
    }
    
    private func alertCheckoutContinue(event: Event) {
        let msg = "Wij hebben gedetecteerd dat u in de \(event.name) bent"
        let title = "Evenement vastgesteld"
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        
        // Checkout action
        alert.addAction(UIAlertAction(title: "Uitchecken", style: .destructive, handler: { action in
            NotificationCenter.default.addObserver(self, selector: #selector(self.showDetectedEvent), name: CheckInService.shared.updatedEventInRangeNotificationName, object: nil)
            CheckInService.shared.checkOut(atEvent: event)
            CheckInService.shared.updateEventInRange()
        }))
        // Continue acgion
        alert.addAction(UIAlertAction(title: "Accepteren", style: .default, handler: { action in
            self.performSegue(withIdentifier: "Home", sender: self)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func unwindToCheckinVC(segue:UIStoryboardSegue) { }
    
}
