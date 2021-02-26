//
//  GhError.swift
//  GithubFollowers
//
//  Created by Melvin Asare on 11/02/2021.
//

import Foundation

enum GhError: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unableToAddToFavourites = "Couldnt add user to favourites list"
    case alreadyInFavourites = "You've already added them to favourites"
}
