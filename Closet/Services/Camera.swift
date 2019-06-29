//
//  Device.swift
//  Closet
//
//  Created by chila on 6/21/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit
import AVKit
import SystemConfiguration

protocol CameraAccess {
    func prepare(inView view: UIViewController, completionHandler: @escaping (Bool) -> Void)
}

struct Camera: CameraAccess {
    private init() {}
    static let shared = Camera()
    
    func prepare(inView view: UIViewController, completionHandler: @escaping (Bool) -> Void) {
        if self.deviceHasCamera() {
            switch self.getCameraAuthStatus() {
            case .authorized:
                completionHandler(true)
            case .denied:
                showConfigurationAlert(in: view)
                completionHandler(false)
            case .notDetermined:
                self.notDetermined(inView: view, completionHandler)
            default:
                self.notDetermined(inView: view, completionHandler)
            }
        } else {
            AlertsPresenter.shared.showOKAlert(title: "Cámara", message: "Dispositivo no tiene cámara", inView: view)
            completionHandler(false)
        }
    }
    
    private func notDetermined(inView view: UIViewController, _ completionHandler: @escaping (Bool) -> Void) {
        AlertsPresenter.shared.showAlertWithAction(alertTitle: "A esta app le gustaria acceder a la cámara",
                                                   alertMessage: "Para llevar el control de tu ropa",
                                                   actionTitle: "Permitir",
                                                   actionStyle: .default,
                                                   inView: view) {
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted) in
                granted ? DispatchQueue.main.async {
                        completionHandler(true)
                    } :
                    DispatchQueue.main.async {
                        self.showConfigurationAlert(in: view)
                        completionHandler(false)
                    }
            })
        }
    }
    private func deviceHasCamera() -> Bool {
        return UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    private func getCameraAuthStatus() -> AVAuthorizationStatus {
        return AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
    }
    
    
    private func showConfigurationAlert(in view: UIViewController) {
        AlertsPresenter.shared.showAlertWithAction(alertTitle: "A esta app le gustaria acceder a la cámara",
                                                   alertMessage:"Para llevar el control de tu ropa",
                                                   actionTitle: "Abrir Configuraciones",
                                                   actionStyle: .default,
                                                   inView: view) {
            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        }
    }
}
