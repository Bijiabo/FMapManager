//
//  CustomAnnotationView.swift
//  FMapManager
//
//  Created by huchunbo on 15/12/18.
//  Copyright © 2015年 Bijiabo. All rights reserved.
//

import Foundation
import MapKit

public class FMKAnnotationView: MKAnnotationView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        var myFrame: CGRect = self.frame
        myFrame.size.width = 40.0
        myFrame.size.height = 40.0
        self.frame = myFrame
        self.image = UIImage(named: "cat")
        self.opaque = false
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
