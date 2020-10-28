//
//  ResourceStore.swift
//  Medical Centre
//
//  Created by aidan egan on 12/10/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import Foundation

class ResourceStore: ObservableObject{
    @Published var resources : [Resource] = []
    
    let resourceRepo = ResourceRepo()
    
    init(){
        populateResources()
    }
    
    func populateResources() {
        resourceRepo.getAllResources { resources in
            if let resourceArray = resources {
                DispatchQueue.main.async {
                    for resource in resourceArray {
                        self.resources.append(resource)
                    }
                }
            }
        }
    }
}
