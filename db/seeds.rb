# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Creating Users...
User.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!(User.table_name)

User.create!(name:"user_1", email:"foo1@gmail.com", password_digest: BCrypt::Password.create('password1'))
User.create!(name:"user_2", email:"foo2@gmail.com", password_digest: BCrypt::Password.create('password2'), password:"password2")
User.create!(name:"user_3", email:"foo3@gmail.com", password_digest: BCrypt::Password.create('password3'), password:"password3")

# Creating Playlists...
Playlist.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!(Playlist.table_name)

@playlist1 = Playlist.create(name:"playlist_1", userId:1)
@playlist1.update(hashed_id: BCrypt::Password.create(@playlist1.id))

@playlist2 = Playlist.create(name:"playlist_2", userId:1)
@playlist2.update(hashed_id: BCrypt::Password.create(@playlist2.id))

@playlist3 = Playlist.create(name:"playlist_3", userId:1)
@playlist3.update(hashed_id: BCrypt::Password.create(@playlist3.id))

@playlist4 = Playlist.create(name:"playlist_4", userId:2)
@playlist4.update(hashed_id: BCrypt::Password.create(@playlist4.id))

@playlist5 = Playlist.create(name:"playlist_5", userId:2)
@playlist5.update(hashed_id: BCrypt::Password.create(@playlist5.id))

@playlist6 = Playlist.create(name:"playlist_6", userId:3)
@playlist6.update(hashed_id: BCrypt::Password.create(@playlist6.id))

# Creating Songs...
PlaylistSong.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!(PlaylistSong.table_name)
Song.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!(Song.table_name)

Song.create( name: "No Guidance (feat. Drake)", vote_count: 0, artist: "Chris Brown", spotify_id: "6XHVuErjQ4XNm6nDPVCxVX")
Song.create( name: "No Guidance (feat. Drake)", vote_count: 0, artist: "Chris Brown", spotify_id: "6XHVuErjQ4XNm6nDPVCxVX")
Song.create( name: "No Guidance (feat. Drake)", vote_count: 0, artist: "Chris Brown", spotify_id: "6XHVuErjQ4XNm6nDPVCxVX")
Song.create( name: "Going Bad (feat. Drake)", vote_count: 0, artist: "Meek Mill", spotify_id: "2IRZnDFmlqMuOrYOLnZZyc")
Song.create( name: "Going Bad (feat. Drake)", vote_count: 0, artist: "Meek Mill", spotify_id: "2IRZnDFmlqMuOrYOLnZZyc")
Song.create( name: "Money In The Grave (Drake ft. Rick Ross)", vote_count: 0, artist: "Drake", spotify_id: "5ry2OE6R2zPQFDO85XkgRb")
Song.create( name: "22", vote_count: 0, artist: "Taylor Swift", spotify_id: "3bIxTsfeNMO7Nt2J3EUKrA")

# Creating join table PlaylistSong

PlaylistSong.create(song_id: 1, hashed_id: @playlist1.hashed_id)
PlaylistSong.create(song_id: 2, hashed_id: @playlist2.hashed_id)
PlaylistSong.create(song_id: 3, hashed_id: @playlist3.hashed_id)
PlaylistSong.create(song_id: 4, hashed_id: @playlist1.hashed_id)
PlaylistSong.create(song_id: 5, hashed_id: @playlist2.hashed_id)
PlaylistSong.create(song_id: 6, hashed_id: @playlist4.hashed_id)
