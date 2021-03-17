# Housing For UCM Students

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
An app for students and staff members to find housing in Merced,CA.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Lifestyle
- **Mobile:** 
- **Story:**
- **Market:** real estate 
- **Habit:** Once a day
- **Scope:** UCM students and faculty

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* Log-in/sign-up
* View feed of houses/apt
* Upload house/apt to rent
* profile
    * first name
    * last name
    * preferred House type
    * contact info 
**Optional Nice-to-have Stories**

* friends
* chat
* map
    * View all houses in a map

### 2. Screen Archetypes


* Sign up
   * Create Username 
   * Create Password
   * Needs school email to sign up
* Login
   * Username textfield
   * Password textfield
* Housing Market Feed
    * picture of house
    * address
    * number rooms, bathrooms, sqrt feet house
* Map
    * Map with houses marked
* Chat
    * mesages
* Profile
    * contact

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* feed
* map
* chat
* profile

**Flow Navigation** (Screen to Screen)

* login
   * tab bar
        * feed
        * map
        * chat
        * profile

## Wireframes
<img src="https://i.imgur.com/uXbLUS8.png" width=600>

## 4. Schema

Post
| Property | Type | Description|
| --- | ----------- |-----------|
| objectId| String|   unique id for the user post (default field)
| Picture | file |   image for the house user uploads
| Caption | String |   Description for the house
| Interested | Number |   # of people interested in that house
| createdAt| DataTime |   date when post is created (default field)
| updatedAt| DataTime |   date when post is last updated (default field)


Profile
| Property | Type | Description|
| --- | ----------- |-----------|
| Profile Picture| image|  shows pic of user
| Name| String |   username of the profile
| Bookmarks| Array |   list of houses they bookmarked

## 4. Data Models
Chat
get messages
```
    @objc func getMessages() {
        // ParseClass.TrainingFall2020 is a string from our Constants.swift file
        let query = PFQuery(className: "") // className = group chat name, obtained from Constants.swift
        query.addDescendingOrder("createdAt")
        query.limit = 20
        query.includeKey("user")
        query.findObjectsInBackground { (messages, error) in
            if let messages = messages {
                self.messages = messages
                self.tableView.reloadData()
            }
            else {
                print(error!.localizedDescription)
            }
        }
    }
```

Send Messages
```
    @IBAction func onSend(_ sender: Any) {
        // ParseClass.TrainingFall2020 is a string from our Constants.swift file
        if messageTextField.text!.isEmpty == false {
            let chatMessage = PFObject(className: "TrainingFall2020") // className = group chat, Obtained from Constants.swift
            chatMessage["text"] = messageTextField.text ?? ""
            chatMessage["user"] = PFUser.current()
            self.messageTextField.text = "" // reset message
            chatMessage.saveInBackground { (success, error) in
                if success {
                    print("The message was saved!")
                    
                } else if let error = error {
                    print("Problem saving message: \(error.localizedDescription)")
                }
            }
        } else {
            print("\nMessage cannot be empty\n")
        }
    }
```
Get posts
```
    func loadPosts(){
        let query = PFQuery(className: "Posts")
        query.order(byDescending: "createdAt")
        query.includeKeys(["author", "comments", "comments.author"])
        
        query.limit = numberOfPosts
        
        query.findObjectsInBackground{ (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
    }
```
