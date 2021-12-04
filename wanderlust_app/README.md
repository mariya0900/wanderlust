# Wanderlust

## Instructions

### Save User Data
To save user data to DB.
```
var currentUser = FirebaseAuth.instance.currentUser;
if (currentUser != null) {
    UserData testuser =
        UserData(uid: currentUser.uid, trips: trips);
    dbService.addUser(user: testuser);
}
```


### Get User Data
To get the user from DB. User contains trips and activities within trips.
```
var currentUser = FirebaseAuth.instance.currentUser;
if (currentUser != null) {
    UserData user;
    dbService.getUserData(uid: currentUser.uid).then((value) {
    user = UserData.fromJson(value);
    //print(user.trips[0].title);
    });
}
```

### Data Structure
```
UserData
    uid
    Trips
        0
            title
            ..
            itinerary
                0
                    name
                    ..    
```
