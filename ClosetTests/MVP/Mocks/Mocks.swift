//
//  Mocks.swift
//  ClosetTests
//
//  Created by chila on 7/13/19.
//  Copyright © 2019 chila. All rights reserved.
//

import UIKit
@testable import Closet

//Es fake para respuestas falsas
class FakeCameraAccessFailure: CameraAccess {
    func prepare(inView view: UIViewController, completionHandler: @escaping (Bool) -> Void) {
        completionHandler(false)
    }
}

class MockCameraAccessSuccess: CameraAccess {
    func prepare(inView view: UIViewController, completionHandler: @escaping (Bool) -> Void) {
        completionHandler(true)
    }
}
