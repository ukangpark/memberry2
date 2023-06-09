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

show full columns from Feed;

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

SELECT * FROM Member;
