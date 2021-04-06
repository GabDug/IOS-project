//
//  ApiErrorEnum.swift
//  Events
//
//  Created by Clément Weingaertner on 06/04/2021.
//

import Foundation

enum ApiError: Error {
    case httpError(Error)
    case apiError(String)
    case parseError(Error)
}
