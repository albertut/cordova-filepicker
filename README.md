# Cordova Filepicker Plugin #
by [Albert Swantner](http://albertut.com)
and [Jon Uy](http://github.com/jonuy)


## DESCRIPTION ##

* This plugin provides a simple way to use the the Filepicker.io native SDK for iOS.

* This plugin is built for Cordova >= v2.1.0 with ARC.


## PLUGIN SETUP FOR IOS ##

Using this plugin requires [Cordova iOS](https://github.com/apache/incubator-cordova-ios).

1. Make sure your Xcode project has been [updated for Cordova](https://github.com/apache/incubator-cordova-ios/blob/master/guides/Cordova%20Upgrade%20Guide.md)
2. Drag and drop the `src/ios` folder from the Finder to your `Plugins` folder in XCode, using "Create groups for any added folders", rename the folder to `Filepicker`.
3. Add the .js files to your `www` folder on disk, and add reference(s) to the .js files using `<script>` tags in your html file(s)
4. In the project plist add a key: "Filepicker API Key" with a value equal to your key from filepicker.io.


    `<script type="text/javascript" src="/js/plugins/Filepicker.js"></script>`


4. Add new entry with key `Filepicker` and value `CDVFilepicker` to `Plugins` in `Cordova.plist/Cordova.plist`

## JAVASCRIPT INTERFACE (IOS) ##

	window.plugins.filepicker.pick(
		{
			dataTypes: ['image/*'],
			sourceNames: ['FPSourceCamera', 'FPSourceCameraRoll', 'FPSourceDropbox', 'FPSourceInstagram']
		},
		uploadSuccess,
		uploadError
	);

For full list of sourceNames visit [Filepicker](https://developers.filepicker.io/docs/ios)

## BUGS AND CONTRIBUTIONS ##

Patches welcome! Send a pull request. Since this is not a part of Cordova Core (which requires a CLA), this should be easier.

Post issues on [Github](https://github.com/albertut/cordova-filepicker/issues)

The latest code (my fork) will always be [here](https://github.com/albertut/cordova-filepicker/tree/master)

## LICENSE ##

    The MIT License

    Copyright (c) 2013 Albert Swantner, Jon Uy

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.

## CREDITS ##

Contributors :

* [Albert Swantner](http://albertut.com), author.
* [Jon Uy](http://github.com/jonuy), author.

