AppNetKit
=========

AppNetKit is an Objective-C library for communicating with the App.net Stream API. It is completely asynchronous, using blocks to notify you of completions.

AppNetKit covers the Token, Users, and Posts parts of the App.net API—all the portions available as of late August 2012.

Synopsis
------

    ANSession.defaultSession.accessToken = myOAuthToken;
    
    // Get the latest posts in the user's incoming post stream...
    [ANSession.defaultSession postsInStreamWithCompletion:^(ANResponse * response, NSArray * posts, NSError * error) {
        if(!posts) {
            [self doSomethingWithError:error];
            return;
        }
        
        // Grab the most recent post.
        ANPost * latestPost = posts[0];
        
        // Compose a reply...
        ANDraft * newPost = [latestPost draftReply];
        newPost.text = [newPost.text appendString:@"Me too!"];  // The default text includes an @mention
        
        // And post it.
        [newPost createPostViaSession:ANSession.defaultSession completion:^(ANResponse * response, ANPost * post, NSError * error) {
            if(!post) {
                [self doSomethingWithError:error];
            }
        }];
    }];


Quick Tour
=========

ANAuthenticator
-------------

This is an OAuth helper singleton. Set the client ID and redirect URL, then use the other methods to help you generate OAuth URLs and parse out the accessToken from the response.

ANSession
--------

ANSession is the central object in AppNetKit. Through it, you can fetch users and posts from App.net, create and delete posts, and do everything else the API permits.

You can create your own session using `[[ANSession alloc] init]` as usual, but if your app only requires one session, you can use `[ANSession defaultSession]` as a shortcut. Set your session's `accessToken` property to an OAuth token, then you can start working with App.net.

ANSession includes methods to perform most requests on the App.net API, from "fetch a user with a specific name" (`-userWithUsername:completion:`) to "fetch all posts with a specific hashtag between these two post IDs" (`-postsWithTag:betweenID:andID:completion:`).

These requests all take a completion handler--a block that will be called when the request has been completed. Completion handlers usually take three parameters:

1. An ANResponse object containing metadata about your request. This parameter will be nil unless your app has enabled the "response_envelope" migration.

2. The data you requested, as either a single ANResource object or an array of ANResource objects. If the request failed, this parameter will be nil.

3. An NSError object. If the request succeeded, this parameter will be nil.

Some calls to retrieve posts take a pair of post IDs, and return only posts between those two IDs. The higher post ID should always be the first of those two parameters. If you don't want to provide one of these post IDs, pass the `ANUnspecifiedPostID` constant instead.

Calls to retrieve user-related data often take a user ID. If you want data for the currently logged-in user, you can pass the `ANMeUserID` constant for these parameters.

ANSession also manages UIApplication's network activity indicator. This should probably be configurable in various ways, not the least because it's the only way in which this library depends on iOS-specific APIs.

ANResource, ANUser, and ANPost
----------------------------

ANResource represents anything the server sends as a JSON object. Each ANResource has a `representation` property, which contains the object's JSON data parsed into Objective-C dictionaries, arrays, strings, etc. Each resource type has properties that convert this raw data to appropriate data types--from NSString for text data to NSTimeZone for an ANUser's `timezone` property.

Because ANResources represent data from the server, you cannot change them in any way, and you should not attempt to allocate them yourself. Instead, use ANRequest objects, ANSession methods, or helper methods on ANResource subclasses to retrieve them from App.net.

ANUser and ANPost are subclasses for the Stream API's User and Post objects, respectively. These classes (or rather their superclass, ANIdentifiedResource) are uniqued—fetching the same post or user from a given ANSession will always return the same ANUser or ANPost instance. That means that an ANUser or ANPost that you already have may be updated. Use key-value observing or register for the ANResourceDidUpdateNotification to find out when this happens.

Many ANResource objects have helper methods to perform common operations with them; for instance, ANUser has a `-followWithCompletion:` method, and ANPost has a `-replyPostsWithCompletion:` method. These are convenience methods which simply call the equivalent ANSession methods (in these cases, `-followUserWithID:completion:` and `-postsReplyingToPostWithID:betweenID:andID:completion:`).

Certain ANResource objects conform to the ANTextualResource protocol. These objects include a `text` property with plain text, an `HTML` property with HTML markup, and an `entities` property with entities covering portions of the plain text. You can use the same code to handle all ANTextualResources.

Related to resource objects is ANDraft, which represents a post that hasn't yet been created. You can create a draft yourself by using `[[ANDraft alloc] init]`, or you can use a convenience method on another class, like `-[ANPost replyDraft]`. Post a reply with either `-[ANDraft createPostViaSession:completion:]` or `-[ANSession createPostFromDraft:completion:]`.

ANRequest and subclasses
---------------------

ANRequest subclasses represent specific API requests. You don't normally have to use them--ANSession has APIs for common requests--but they are public API, and using them directly can give you finer control than ANSession allows.

Create an ANRequest with the `-initWithSession:` constructor, then set whatever properties are available on that request and call `-sendRequestWithCompletion:` to perform the request. You can reuse the same request as many times as you'd like.

ANMutableRequest and ANMutableAuthenticatedRequest are also available for your use. These allow you to create your own requests to custom URLs. AppNetKit itself uses them to fetch images for the ANImage resource.

NSString+AppNetExtensions
----------------------

AppNetKit adds two methods to `NSString`. `-appNetUsernameString` prepends an @ character to a username, and `-appNetTagString` prepends a # character.

Author
======

Brent Royal-Gordon, Architechies <brent@architechies.com>, [@brent](http://alpha.app.net/brent) on App.net.

Please let me know if you use AppNetKit in a project. I'm curious about what people will do with this!

Bugs
====

A lot of the code in this library has never actually been run as I write this, so it's likely to have plenty of bugs. If you want to write unit tests to exercise all this code, I'll be happy to pull them in. (Packaging this mess as an Xcode project might be a good idea, too...)

Also note that my own development is for iOS 6; I don't believe there are any iOS 6-only APIs in AppNetKit, but it's possible a call or two snuck in. Again, patches are welcome.

If you find a problem, file an issue or write a patch and send it to me (preferably as a pull request, but I'm not picky).

Copyright
========

This software is licensed under the MIT license:

Copyright (C) 2012 Architechies.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
