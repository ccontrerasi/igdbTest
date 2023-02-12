//
//  Image+Extension.swift
//
//  Created by Cristian Contreras on 18/1/23.
//

import Rswift
import SwiftUI

public extension Image {
    init(imageResource: ImageResource) {
        self.init(imageResource.name, bundle: imageResource.bundle)
    }
}
