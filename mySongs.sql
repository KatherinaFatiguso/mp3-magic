-- create table songs
--

CREATE table if not exists songs(
  id serial primary key,
  title text,
  artist text,
  genre text,
  duration interval
);

INSERT INTO songs(id, title, artist, genre, duration) VALUES(1, '09 Where''s Your Head At.mp3', 'Banana Boat', 'pop', '04:44');
INSERT INTO songs(id, title, artist, genre, duration) VALUES(2, 'Adhesive Wombat - Marsupial Madness - 01 8 Bit Adventure.mp3', 'Angry Muffins Club', 'rock', '04:31');
INSERT INTO songs(id, title, artist, genre, duration) VALUES(3, 'Lost in Space.mp3', 'Silver Horse', 'rock', '03:25');

CREATE table if not exists playlist(
  playlist_id int references songs(id)
)
