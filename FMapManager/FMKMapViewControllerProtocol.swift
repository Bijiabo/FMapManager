//
//  FMKMapViewControllerProtocol.swift
//  FMapManager
//
//  Created by huchunbo on 15/12/18.
//  Copyright © 2015年 Bijiabo. All rights reserved.
//

import MapKit
import UIKit
import CoreLocation

public protocol FMKMapViewControllerProtocol: MKMapViewDelegate {
    var mapView: MKMapView! {get set}
    var artworks: [FMKAnnotation] {get set}
    var regionRadius: CLLocationDistance {get set} // default value is 1000 (meters) (=1 kilometer)
    
    func setupMapView()
    func centerMapOnLocation(location: CLLocation)
    func loadInitialData()
}

extension FMKMapViewControllerProtocol {
    
    public func setupMapView() {
        mapView.mapType = MKMapType.Standard
        
        mapView.zoomEnabled = true
        mapView.scrollEnabled = true
        mapView.pitchEnabled = true
        mapView.rotateEnabled = true
        mapView.delegate = self
        
        // mapView.showsUserLocation = true
        // mapView.userTrackingMode = MKUserTrackingMode.Follow
        
        // show artwork on map
        /*
        let artwork = Artwork(title: "King David Kalakaua",
        locationName: "Waikiki Gateway Park",
        discipline: "Sculpture",
        coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
        
        mapView.addAnnotation(artwork)
        */
    }
    
    public func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    public func loadInitialData() {
        let fileName = NSBundle.mainBundle().pathForResource("PublicArt", ofType: "json");
        let JSONData = JSON(data: NSData(contentsOfFile: fileName!)! )
        
        for artworkJSON in JSONData["data"].arrayValue {
            if
                let artworkJSON = artworkJSON.array,
                let artwork = FMKAnnotation.fromJSON(artworkJSON)
            {
                artworks.append(artwork)
            }
        }
    }
}
