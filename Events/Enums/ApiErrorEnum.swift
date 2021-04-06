//
//  ApiErrorEnum.swift
//  Events
//
//  Created by Clément Weingaertner on 06/04/2021.
//

import Foundation

/// Describe the error of an External API (Airtables.com)
enum ApiError: Error {
    case httpError(Error)
    case apiError(String, String)
    case parseError(Error, String)
}
