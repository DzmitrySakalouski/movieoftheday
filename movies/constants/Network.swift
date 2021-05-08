//
//  Network.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 1.04.21.
//

import Foundation

let BASE_URL = "https://api.themoviedb.org" // TODO: move to info plist and add env
var defaultParams: [URLQueryItem] = [URLQueryItem(name: "api_key", value: "02f23dd0ea131e1da0741220bb29d198")]
let YOUTUBE_BASE_URL = "https://www.youtube.com/watch?v="
let VIMEO_BASE_URL = "https://vimeo.com/"

// https://api.themoviedb.org/3/movie/297762?api_key=02f23dd0ea131e1da0741220bb29d198&append_to_response=videos
