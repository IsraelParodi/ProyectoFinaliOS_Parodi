//
//  ImageDownload.swift
//  ProyectoFinaliOS_Parodi
//
//  Created by Israel Parodi Schmidt on 11/27/20.
//  Copyright © 2020 Israel Parodi Schmidt. All rights reserved.
//

import UIKit

typealias ImageSuccess = (_ image: UIImage?, _ urlImagen: String) -> Void

extension UIImageView {
    
    func downloadImageInUrlString(_ urlString: String, success: @escaping ImageSuccess) {
        
        guard let urlImage = URL(string: urlString) else {
            print("La url es inválida")
            return
        }
        
        var dataImagen: Data!
        
        DispatchQueue.global(qos: .default).async {
            
            do {
                dataImagen = try Data(contentsOf: urlImage)
            }catch {
                print("Fallo la descarga")
                return
            }
            
            let image = UIImage(data: dataImagen)
            
            DispatchQueue.main.async {
                success(image, urlString)
            }
        }
    }
}
