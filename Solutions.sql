-- Solutions
-- Finding 5 oldest users
SELECT
    *
FROM
    USERS
ORDER BY
    created_at
LIMIT
    5;

-- Most Popular Registration Date
SELECT
    username,
    DAYNAME (created_at) AS day_name,
    COUNT(*) AS total
FROM
    USERS
GROUP BY
    day_name
ORDER BY
    total DESC
LIMIT
    2;

-- Identify Inactive Users (users with no photos)
SELECT
    username,
    image_url
FROM
    users
    LEFT JOIN photos ON photos.user_id = users.id
WHERE
    photos.id IS NULL;

-- Identify most popular photo (and user who created it)
SELECT
    username,
    photos.id,
    image_url,
    COUNT(likes.created_at) AS Number_of_likes
FROM
    users
    JOIN photos ON photos.user_id = users.id
    JOIN likes ON likes.photo_id = photos.id
GROUP BY
    image_url
ORDER BY
    Number_of_likes DESC;

-- Calculate avg number of photos per user
SELECT
    (
        SELECT
            COUNT(*)
        FROM
            photos
    ) / (
        SELECT
            COUNT(*)
        FROM
            Users
    ) AS avg;

-- Top 5 Most commonly used hashtags
SELECT
    tags.tag_name,
    Count(*) AS total
FROM
    photo_tags
    JOIN tags ON photo_tags.tag_id = tags.id
GROUP BY
    tags.id
ORDER BY
    total DESC
LIMIT
    5;

-- Finding Bots - Users who liked every single photo
SELECT
    username,
    Count(*) AS num_likes
FROM
    users
    INNER JOIN likes ON users.id = likes.user_id
GROUP BY
    likes.user_id
HAVING
    num_likes = (
        SELECT
            Count(*)
        FROM
            photos
    );