//
//  Manager.swift
//  Huilehui PremierLeague
//
//  Created by Navathon Limamapar on 16/3/2567 BE.
//

import Foundation
enum 
JobType: String {
    case manager = "Manager"
    case headCoach = "Head Coach"
}

struct Manager {
    let name: String
    let job: JobType
}
