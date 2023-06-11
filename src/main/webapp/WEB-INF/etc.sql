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
DELETE FROM Feed WHERE id=2 ;

DESC File;
SELECT * FROM File ORDER BY feedId DESC,id DESC;

SELECT * FROM Feed fd JOIN File fl
ON fd.id = fl.feedId
WHERE fd.id = 11;

SELECT * FROM File ORDER BY id DESC;

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

ALTER TABLE File DROP memberId;
ALTER TABLE File ADD memberId varchar(12);
ALTER TABLE File ADD foreign key(memberId) references Member(id);
ALTER TABLE File DROP foreign key File_ibfk_2;
select* from information_schema.table_constraints WHERE table_name = 'File';

show full columns from Member;