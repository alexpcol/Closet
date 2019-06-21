//
//  Activities.swift
//  Closet
//
//  Created by chila on 6/21/19.
//  Copyright © 2019 chila. All rights reserved.
//
import UIKit

struct ActivityPresenter {
    
    private init() {}
    
    static let shared = ActivityPresenter()
    
    
    //MARK:- Media Activities
    func showImagePickerFromCamera(inView view: UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
        guard let viewController = view as? UIViewController else { return }
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = view
        myPickerController.sourceType = UIImagePickerController.SourceType.camera
        viewController.present(myPickerController, animated: true, completion: nil)
    }
    
    func showImagePickerFromGallery(inView view: UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
        guard let viewController = view as? UIViewController else { return }
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = view
        myPickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        viewController.present(myPickerController, animated: true, completion: nil)
    }
    
}
