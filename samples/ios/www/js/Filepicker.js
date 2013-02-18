//
//  Filepicker.js
//
// Created by Albert Swantner and Jon Uy on .
//
// Copyright 2011-2012 Albert Swantner. All rights reserved.
// MIT Licensed

(function() {
	
	var cordovaRef = window.PhoneGap || window.Cordova || window.cordova; // old to new fallbacks

	function Filepicker() {
		//does nothing
	}

	Filepicker.prototype.pick = function(_options, _onSuccess, _onError) {
	
//	filepicker.pick({
//	    mimetypes: ['image/*', 'text/plain'],
//	    container: 'window',
//	    services:['COMPUTER', 'FACEBOOK', 'GMAIL'],
//	  },
//	  function(FPFile){
//	    console.log(JSON.stringify(FPFile));
//	  },
//	  function(FPError){
//	    console.log(FPError.toString());
//    }
//	);
		// Expected options:
		//  dataTypes: array - Specific data types. (Optional) Default is all files.
		//  sourceNames: array - Select and order the sources (Optional) Default is all sources.
		//  allowEditing: boolean - Set some of the in built Camera properties as you would with UIImagePicker.
		//  shouldUpload: boolean - When a user selects a local file, we'll upload it and return a remote url.
		//  shouldDownload: boolean - When a user selects a remote file, we'll download it and return the filedata to you.

		var successCallback = function(result) {
			if (typeof _onSuccess == 'function') {
				_onSuccess.apply(null, [result]);
			}
		};

		var errorCallback = function(result) {
			if (typeof _onError == 'function') {
				_onError.apply(null, [result]);
			}
		};
		
		return cordova.exec(successCallback, errorCallback, 'Filepicker', 'pick', [_options]);
	};

	Filepicker.prototype.save = function(_options, _onSuccess, _onError) {
		var successCallback = function(result) {
			if (typeof _onSuccess == 'function') {
				_onSuccess.apply(null, [result]);
			}
		};

		var errorCallback = function(result) {
			if (typeof _onError == 'function') {
				_onError.apply(null, [result]);
			}
		};

		return cordova.exec(successCallback, errorCallback, 'Filepicker', 'save', [_options]);
	};

	cordova.addConstructor(function() {
		if(!window.plugins) window.plugins = {};
		window.plugins.filepicker = new Filepicker();
	});

})(window.cordova || window.Cordova);