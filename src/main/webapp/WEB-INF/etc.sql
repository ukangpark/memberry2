USE membery;
SELECT * FROM Feed ORDER BY id DESC;
SELECT * FROM File ORDER BY id DESC;
SELECT * FROM File WHERE feedId = 44;

DELETE FROM Feed WHERE id = 48;

DESC Feed;
DESC File;

SELECT 
				fd.id,
				fd.title,
				fd.content,
				fd.writer,
				fd.inserted,
				fd.location,
				fl.fileName,
				fl.feedId
			FROM Feed fd LEFT JOIN File fl ON fd.id = fl.feedId
			WHERE fd.id = 37;
            
CREATE TABLE FeedLike (
	feedId INT NOT NULL,
    memberId VARCHAR(12) NOT NULL,
    PRIMARY KEY (feedId, memberId),
    FOREIGN KEY (feedId) REFERENCES Feed(id),
    FOREIGN KEY (memberId) REFERENCES Member(id)
);

DESC Member;

show full columns from File;

alter table Feed convert to character set utf8mb4 collate utf8mb4_unicode_ci;
alter database membery character set utf8mb4 collate utf8mb4_unicode_ci;

DESC File;
DESC Feed;
SELECT * FROM Feed ORDER BY id DESC;
DELETE FROM Feed WHERE id=81 ;

DESC File;
SELECT * FROM File ORDER BY feedId DESC,id DESC;

SELECT * FROM Feed fd JOIN File fl
ON fd.id = fl.feedId
WHERE fd.id = 11;

SELECT * FROM File ORDER BY id DESC;
DELETE FROM File WHERE feedId = 81 ;
SELECT fileName FROM File;

SELECT * FROM File GROUP BY FeedId ORDER BY id DESC;

DELETE FROM Feed WHERE id = 8;

SELECT * FROM FeedLike;

SELECT * FROM File;

SELECT * FROM Pet ORDER BY id DESC;

SELECT feedId, fileName FROM File
WHERE memberId = "playKim"
GROUP BY FeedId ORDER BY id DESC;
            
DESC Pet;
DESC Member;
DESC File;
DESC FeedLike;
DESC Feed;

ALTER TABLE File DROP memberId;
ALTER TABLE File ADD memberId varchar(12);
ALTER TABLE File ADD foreign key(memberId) references Member(id);
ALTER TABLE File DROP foreign key File_ibfk_2;
select* from information_schema.table_constraints WHERE table_name = 'File';

show full columns from Member;

ALTER TABLE Feed MODIFY writer VARCHAR(12);

SELECT * FROM Member ORDER BY id DESC;
DELETE FROM Member WHERE name = '어드민';

SET SQL_SAFE_UPDATES = 0;

UPDATE Feed SET writer = 'playkim';

SELECT * FROM Feed ORDER BY id DESC;
UPDATE Feed SET writer = 'ukang0711' WHERE id = 82;

ALTER TABLE Feed
ADD FOREIGN KEY (writer) REFERENCES Member(id);

UPDATE Feed SET writer = 'sohee.G' WHERE id = 106;