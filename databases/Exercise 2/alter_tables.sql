
ALTER TABLE movie
    ADD CONSTRAINT movie_pk
    PRIMARY KEY (id);
    
ALTER TABLE ratings
    ADD CONSTRAINT ratings_pk
    PRIMARY KEY (user_id,movie_id);

ALTER TABLE genre 
    ADD CONSTRAINT genre_pk
    PRIMARY KEY (id)

ALTER TABLE productioncompany
    ADD CONSTRAINT company_pk
    PRIMARY KEY (id)

ALTER TABLE collection
    ADD CONSTRAINT collection_pk
    PRIMARY KEY (id)

ALTER TABLE movie_cast
    ADD CONSTRAINT movie_cast_pk
    PRIMARY KEY (cid)

ALTER TABLE movie_crew
    ADD CONSTRAINT movie_crew_pk
    PRIMARY KEY (cid)

ALTER TABLE Keyword
    ADD CONSTRAINT keyword_pk
    PRIMARY KEY (id)

ALTER TABLE belongsTocollection
    ADD CONSTRAINT FK_coll_movied FOREIGN
KEY (movie_id)
    REFERENCES movie(id)

ALTER TABLE belongsTocollection
    ADD CONSTRAINT FK_coll_id FOREIGN
KEY (collection_id)
    REFERENCES collection(id)

ALTER TABLE hasGenre
    ADD CONSTRAINT FK_movie_id FOREIGN
KEY (movie_id)
    REFERENCES movie(id)

ALTER TABLE hasGenre
    ADD CONSTRAINT FK_genreid FOREIGN
KEY (genre_id)
    REFERENCES genre(id)

ALTER TABLE hasProductioncompany
    ADD CONSTRAINT FK_movie_comp_id FOREIGN
KEY (movie_id)
    REFERENCES movie(id)

ALTER TABLE hasProductioncompany
    ADD CONSTRAINT FK_pc_id FOREIGN
KEY (pc_id)
    REFERENCES productioncompany(id)

ALTER TABLE ratings
    ADD CONSTRAINT FK_movieid FOREIGN
KEY (movie_id)
    REFERENCES movie(id);

ALTER TABLE movie_cast
    ADD CONSTRAINT FK_cast_movieid FOREIGN
KEY (movie_id)
    REFERENCES movie(id)

ALTER TABLE movie_crew
    ADD CONSTRAINT FK_crew_movieid FOREIGN
KEY (movie_id)
    REFERENCES movie(id)

ALTER TABLE haskeyword
    ADD CONSTRAINT FK_hk_movieid FOREIGN
KEY (movie_id)
    REFERENCES movie(id)

ALTER TABLE haskeyword
    ADD CONSTRAINT FK_hk_keywordid FOREIGN
KEY (keyword_id)
    REFERENCES keyword(id)
