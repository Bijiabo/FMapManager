//
//  ArtWork.swift
//  FMapManager
//
//  Created by huchunbo on 15/12/18.
//  Copyright © 2015年 Bijiabo. All rights reserved.
//

import Foundation
import MapKit
import UIKit
import AddressBook
import Contacts

public class FMKAnnotation: NSObject, MKAnnotation {
    public let title: String?
    let locationName: String
    let discipline: String
    public let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    public var subtitle: String? {
        return locationName
    }
    
    // annotation callout info button opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        var subtitle: AnyObject = ""
        if let self_subtitle = self.subtitle as? AnyObject {subtitle = self_subtitle}
        
        var addressDictionary: [String : AnyObject]
        
        if #available(iOS 9.0, *) {
            addressDictionary = [String(CNPostalAddressStreetKey): subtitle]
        } else {
            addressDictionary = [String(kABPersonAddressStreetKey): subtitle]
        }
        
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
    
    class func fromJSON(json: [JSON]) -> FMKAnnotation? {
        var title: String
        if let titleOrNil = json[16].string {
            title = titleOrNil
        } else {
            title = ""
        }
        let locationName = json[12].stringValue
        let discipline = json[15].stringValue
        
        let latitude = json[18].doubleValue
        let longitude = json[19].doubleValue
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        return FMKAnnotation(title: title, locationName: locationName, discipline: discipline, coordinate: coordinate)
    }
    
    // pinColor for disciplines: Sculpture, Plaque, Mural, Monument, other
    func pinColor() -> UIColor  {
        switch discipline {
        case "Sculpture", "Plaque":
            return UIColor.redColor()
        case "Mural", "Monument":
            return UIColor.purpleColor()
        default:
            return UIColor.greenColor()
        }
    }
}