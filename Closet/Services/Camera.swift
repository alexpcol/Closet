//
//  Device.swift
//  Closet
//
//  Created by chila on 6/21/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit
import AVKit
import Foundation
import SystemConfiguration

struct Camera {
    
    private init() {}
    static let shared = Camera()
    
    // Cambiar con un closure de completion handler para manejar el estado de autorizado o no
     func prepare(inView view: UIViewController) -> Bool {
        if self.deviceHasCamera() {
            switch self.getCameraAuthStatus() {
            case .authorized:
                return true
            case .denied:
                AlertsPresenter.shared.showAlertWithAction(alertTitle: "A esta app le gustaria acceder a la cámara",
                                                           alertMessage:"Para llevar el control de tu ropa",
                                                           actionTitle: "Abrir Configuraciones",
                                                           actionStyle: .default,
                                                           inView: view) {
                    UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                }
                return false
            case .notDetermined:
                self.notDetermined(inView: view)
                return false
            default:
                self.notDetermined(inView: view)
                return false
            }
        } else {
            AlertsPresenter.shared.showOKAlert(title: "Cámara", message: "Dispositivo no tiene cámara", inView: view)
            return false
        }
    }
    
    private func notDetermined(inView view: UIViewController) {
        AlertsPresenter.shared.showAlertWithAction(alertTitle: "A esta app le gustaria acceder a la cámara",
                                                   alertMessage: "Para llevar el control de tu ropa",
                                                   actionTitle: "Permitir",
                                                   actionStyle: .default,
                                                   inView: view) {
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted) in
                if granted {
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: .cameraShowItAgain,
                                                        object: nil,
                                                        userInfo: ["showCamera" : true] )
                    }
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
}
