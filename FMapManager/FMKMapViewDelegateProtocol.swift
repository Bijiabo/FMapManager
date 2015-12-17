//
//  FMKMapViewDelegateProtocol.swift
//  FMapManager
//
//  Created by huchunbo on 15/12/18.
//  Copyright © 2015年 Bijiabo. All rights reserved.
//

import Foundation
import MapKit

public protocol FMKMapViewDelegateProtocol: MKMapViewDelegate {
    func FMapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation)
    func FMapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?
    func FMapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl)
    func FMapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView)
}

extension FMKMapViewDelegateProtocol {
    
    public func FMapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        /*
        let location = userLocation.coordinate
        let region = MKCoordinateRegionMakeWithDistance(location, 250, 250)
        mapView.setRegion(region, animated: true)
        */
    }
    
    public func FMapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? FMKAnnotation {
            let identifier = "pin"
            var view: FMKAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? FMKAnnotationView {
                    dequeuedView.annotation = annotation
                    view = dequeuedView
            } else {
                view = FMKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
            }
            
            //view.pinColor = annotation.pinColor()
            
            return view
        }
        return nil
    }
    
    public func FMapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! FMKAnnotation
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMapsWithLaunchOptions(launchOptions)
    }
    
    public func FMapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        
    }
}