ALTER TABLE hasGenre
    ADD CONSTRAINT PK_hg
PRIMARY KEY(movie_id,genre_id)

ALTER TABLE haskeyword
    ADD CONSTRAINT PK_hk
PRIMARY KEY (movie_id,keyword_id)

ALTER TABLE belongsTocollection
    ADD CONSTRAINT PK_belongsTocoll
PRIMARY KEY (movie_id,collection_id)

ALTER TABLE hasProductioncompany
    ADD CONSTRAINT PK_hasProductioncomp
PRIMARY KEY (movie_id,pc_id)

ALTER TABLE ratings
    ADD CONSTRAINT ratings_pk
PRIMARY KEY (user_id,movie_id); 