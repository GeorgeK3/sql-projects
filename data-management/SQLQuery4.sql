set statistics io on
set statistics time on


-----------------------EROTIMA 1 -----------------------
checkpoint
dbcc dropcleanbuffers

SELECT displayName, profileviews
 FROM users
WHERE YEAR(CreationDate)=2010
ORDER BY creationDate, profileViews

CREATE INDEX idx_CreationDate ON Users (CreationDate DESC) INCLUDE (profileViews,displayName)

SELECT displayName, profileviews
 FROM users
WHERE CreationDate >= '2010-01-01' AND CreationDate < '2011-01-01'
ORDER BY creationDate, profileViews

DROP INDEX idx_CreationDate ON Users


--------------------------------------------------------
-----------------------EROTIMA 2 -----------------------
checkpoint
dbcc dropcleanbuffers

SELECT users.*
 FROM users, posts, postTypes
WHERE users.userid=posts.ownerUserid and
 posts.postTypeid=PostTypes.postTypeid and postTypeName='Answer'
EXCEPT
SELECT users.*
 FROM users, posts, postTypes
WHERE users.userid=posts.ownerUserid and
 posts.postTypeid=PostTypes.postTypeid and postTypeName='Question'

CREATE INDEX idx_OwnerUserId_postTypeId ON Posts (OwnerUserId) INCLUDE (PostTypeId)

SELECT DISTINCT u.*
FROM users u
JOIN posts p ON u.userid = p.ownerUserid
JOIN postTypes pt ON p.postTypeid = pt.postTypeid
WHERE pt.postTypeName = 'Answer'
AND NOT EXISTS (
    SELECT null
    FROM posts p2
    JOIN postTypes pt2 ON p2.postTypeid = pt2.postTypeid
    WHERE u.userid = p2.ownerUserid
    AND pt2.postTypeName = 'Question'
);

DROP INDEX idx_OwnerUserId_postTypeId ON Posts

--------------------------------------------------------
-----------------------EROTIMA 3 -----------------------
checkpoint
dbcc dropcleanbuffers

SELECT TagName, COUNT(*) AS UpVotes
FROM Tags
 INNER JOIN PostTags ON PostTags.TagId = Tags.tagid
 INNER JOIN Posts ON Posts.ParentId = PostTags.PostId
INNER JOIN Users ON Posts.OwnerUserId=Users.Userid
 INNER JOIN Votes ON Votes.PostId = Posts.postId
INNER JOIN VoteTypes ON Votes.voteTypeId=VoteTypes.VoteTypeID
WHERE
 VoteTypeName='UpVote' AND Users.displayName = 'Dominik Weber'
GROUP BY TagName
ORDER BY UpVotes DESCCREATE INDEX idx_TagId ON PostTags (TagId)CREATE INDEX idx_ParentId ON Posts (ParentId)CREATE INDEX idx_OwnerUserId ON Posts (OwnerUserId)CREATE INDEX idx_UserId ON Users (UserID)CREATE INDEX idx_PostId ON Votes (PostId)CREATE INDEX idx_voteTypeId ON Votes (voteTypeId)DROP INDEX idx_TagId ON PostTagsDROP INDEX idx_ParentId ON PostsDROP INDEX idx_OwnerUserId ON PostsDROP INDEX idx_UserId ON UsersDROP INDEX idx_PostId ON VotesDROP INDEX idx_voteTypeId ON Votes
--------------------------------------------------------
-----------------------EROTIMA 4 -----------------------
checkpoint
dbcc dropcleanbuffers

select top 100
 userid,
 round((100.0 * (Reputation/10)) / (Upvotes+1), 2) as [Ratio %],
 Reputation,
 UpVotes,
 DownVotes
from Users
where Reputation > 1000
 and Upvotes > 100
order by [Ratio %] desc

CREATE INDEX idx_Reputation_UpVotes ON Users (Reputation, Upvotes) INCLUDE (DownVotes)
DROP INDEX idx_Reputation_UpVotes ON Users 

CREATE INDEX idx_Rep_UpVotes ON users (Reputation, UpVotes);
DROP INDEX idx_Rep_UpVotes ON users

--------------------------------------------------------
-----------------------EROTIMA 5 -----------------------
checkpoint
dbcc dropcleanbuffers

SELECT TOP 10
    p.PostId AS question_id,
    p.Title AS question_title,
	p.ViewCount AS question_views,
    u.DisplayName AS user_display_name
FROM 
    Posts p
JOIN 
    Users u ON p.OwnerUserId = u.UserId
JOIN
    PostTypes pt ON p.PostTypeId = pt.PostTypeId
WHERE 
    pt.PostTypeName = 'Question'
    AND YEAR(p.CreationDate) = 2010
ORDER BY 
    p.ViewCount DESC;

CREATE INDEX idx_creationDate ON Posts (CreationDate);
CREATE INDEX idx_viewCount ON Posts (ViewCount DESC);

DROP INDEX idx_creationDate ON Posts
DROP INDEX idx_viewCount ON Posts
--------------------------------------------------------