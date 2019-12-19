//
//  Resources.swift
//  ARK-Project
//
//  Created by Liana Norman on 12/19/19.
//  Copyright © 2019 Liana Norman. All rights reserved.
//

import Foundation
import UIKit

struct Resources {
    let orgName: String
    let link: String
    let image: UIImage
}

var resource1 = Resources(orgName: "UNICEF", link: "https://donate.unicefusa.org/page/contribute/support-unicefs-emergency-relief-programs", image: UIImage(named: "unicef")!)

var resource2 = Resources(orgName: "NYC Environmental Protection Prevention", link: "https://www1.nyc.gov/site/dep/environment/flood-prevention.page", image: UIImage(named: "nyc")!)
var resource3 = Resources(orgName: "Red Cross", link: "https://www.redcross.org/get-help/how-to-prepare-for-emergencies/types-of-emergencies/hurricane.html", image: UIImage(named: "redCross")!)
var resource4 = Resources(orgName: "eSchoolToday", link: "https://eschooltoday.com/natural-disasters/floods/flood-prevention-methods.html", image: UIImage(named: "eSchool")!)
var resource5 = Resources(orgName: "Emergency Kits", link: "https://www.emergencykits.com/?gclid=EAIaIQobChMI0ubFqfXA5gIVjZ-fCh2nngFmEAAYASAAEgKrv_D_BwE", image: UIImage(named: "firstAid")!)
var resource6 = Resources(orgName: "Climate Institute", link: "https://climate.org/new-flood-prevention-strategies/", image: UIImage(named: "climate")!)

let allResources = [resource1, resource2, resource3, resource4, resource5, resource6]
