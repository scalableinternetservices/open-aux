# open-aux

  

Team Member Name:

1. Justin Han (Github: jhan25)

2. Giovanni Moya (Github: GiovanniMoya)

3. Han Bin Lee (Github: bin315a1

4. David Kim (Github: davidkim0228)

  

Our team attends 2pm section.

  

Open-aux is a "Real time live playlist. Have a host maintain a playlist.

Have users in the host session be able to add songs to the

group’s playlist."

  

# Docs

  

## Models

0. Session

1. User

2. Playlist

3. Song

4. PlaylistSong

5. Guest (?)

  

### Session

Model
- Built in Session model; Session will contain the data: `hashed_id`

Controller
- create: Signup for new users
- destroy: Logout **NOT IMPLEMENTED**

  

View

- new.html.erb: For login

  

### User

  

Model

- Basic user model with: `id`, `name`, `email`, `password`

  

Controller

- new: Creates new user, returns error if the user already exists

  

View

- new.html.erb: signup page

- show.html: redirection (back to login page) page after signup

  

### Playlist

  

Model

- Playlist model with: `id`, `name`, `userId`, `hashed_id`

  

Controller

- create: creates new Playlist instance, hashes the `id` into its `hashed_id` column, and saves it; the `hashed_id` is also stored to the session's :hashed_id. Renders show

- get_playlist_key: uses session[:hahsed_id], and hashes it to shareable key, and returns a json response:

```

{

"key": "<key val here>"

}

```

- decrypt_key: using `params[:key]`, it decrypts the passed key into a usable `hashed_id`, and redirects to the specified playlist's main page.

- get_songs: using session[:hashed_id], it returns back all the songs within the specified playlist:

```

{

"res": [

{

"id": 1,

"name": "song1",

"vote_count": 0,

"artist": "artist1",

"created_at": "2019-11-15T23:35:42.712Z",

"updated_at": "2019-11-15T23:35:42.712Z",

"spotify_id": "id1"

}

]

}

```

  

View

- new.html.erb: Create a playlist page after login

  

### Song

  

Model

- Song model with: `id`, `name`, `vote_count`, `artist`, `spotify_id`

  

Controller

- search: using `params[:q]`, it returns back the result of Spotify API search by rendering it to show.

- create: as the user chooses one of the results from search, it creates the song instance, and also creates a PlaylistSong instance with `song.id` and `session[:hashed_id]`.

  

### PlaylistSong

  
Model

- A join table that links the Song and Playlist table, with fields: `id`, `song_id`, `hashed_id`

  

Controller

- N/A

  

View

- N/A