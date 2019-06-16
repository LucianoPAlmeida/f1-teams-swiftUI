//
//  ActivityIndicatorView.swift
//  CombineApp
//
//  Created by Luciano Almeida on 16/06/19.
//  Copyright © 2019 Luciano Almeida. All rights reserved.
//

import UIKit
import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {

    
    typealias UIViewType = UIActivityIndicatorView
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicatorView>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: .medium)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicatorView>) {
        uiView.hidesWhenStopped = true
        uiView.startAnimating()        
    }
    
}
