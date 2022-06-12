//
//  TimelineService.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

import Foundation
import FirebaseDatabase

protocol TimelineServiceProtocol {
    func setInteractor(_ interactor: TimelineInteractorProtocol)
}

final class TimelineService: TimelineServiceProtocol {
    
    private var interactor: TimelineInteractorProtocol?
    
    private  var ref: DatabaseReference!
    
    init() {
        let url = try! NSString(contentsOfFile: "/Users/michaelslattery/Documents/SocialLite.txt", encoding: String.Encoding.utf8.rawValue) as String
        ref = Database.database(url: url).reference()
    }
    
    func setInteractor(_ interactor: TimelineInteractorProtocol) {
        self.interactor = interactor
    }
}
