create database P2;

 use P2;
 
 
 # 1. Who is the senior most employee based on job title? 
 SELECT * FROM employee
 ORDER BY levels desc
 LIMIT 1;
 
# 2. Which countries have the most Invoices? 
SELECT * FROM invoice;

SELECT billing_country,count(*) as BC_total
FROM invoice
GROUP BY billing_country
ORDER BY BC_total desc
LIMIT 3;



# 3. What are top 3 values of total invoice? 
SELECT * FROM invoice;

SELECT billing_country, total
FROM invoice
ORDER BY total desc
LIMIT 3;


# 4. Which city has the best customers? We would like to throw a promotional Music 
    #Festival in the city we made the most money. Write a query that returns one city that 
    #has the highest sum of invoice totals. Return both the city name & sum of all invoice 
	#totals 

SELECT * FROM invoice;

SELECT SUM(total) as invoice_total,billing_city
FROM invoice
GROUP BY billing_city
ORDER BY invoice_total desc
LIMIT 3;



# 5. Who is the best customer? The customer who has spent the most money will be 
    #declared the best customer. Write a query that returns the person who has spent the 
    #most money
    
SELECT * FROM customer;
SELECT * FROM invoice;

SELECT customer.customer_id,first_name, last_name , SUM(total) as total
FROM customer
JOIN
invoice ON
customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id,first_name,last_name
ORDER BY total desc 
LIMIT 3;

# 6.Write query to return the email, first name, last name, & Genre of all Rock Music 
#    listeners. Return your list ordered alphabetically by email starting with A 

SELECT * FROM genre;
SELECT * FROM track;

SELECT DISTINCT first_name,last_name,email
FROM customer
JOIN invoice ON invoice.customer_id = customer.customer_id
JOIN invoice_line ON invoice_line.invoice_id = invoice.invoice_id
WHERE track_id 
IN(SELECT track_id FROM track
   JOIN genre ON genre.genre_id = track.genre_id
   WHERE genre.name LIKE 'Rock')
ORDER BY email;
    


# 7.Let's invite the artists who have written the most rock music in our dataset. Write a 
#    query that returns the Artist name and total track count of the top 10 rock bands 

SELECT * FROM artist;
SELECT * FROM album2;
SELECT * FROM track;
SELECT * FROM genre;

SELECT artist.artist_id, artist.name, COUNT(artist.artist_id) as Number_of_songs
FROM genre
JOIN track ON genre.genre_id = track.genre_id
JOIN album2 ON album2.album_id = track.album_id
JOIN artist ON album2.artist_id = artist.artist_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id,artist.name
ORDER BY Number_of_songs DESC
LIMIT  10;  


# 8.Return all the track names that have a song length longer than the average song length. 
#   Return the Name and Milliseconds for each track. Order by the song length with the 
#   longest songs listed first 

SELECT * FROM track;

SELECT track_id,name,AVG(milliseconds) AS AVG_SL
FROM track
GROUP BY name,track_id
ORDER BY AVG_SL DESC;

# 9. Find how much amount spent by each customer on artists? Write a query to return 
#    customer name, artist name and total spent 

SELECT * FROM customer;
SELECT * FROM invoice;
SELECT * FROM invoice_line;
SELECT * FROM track;
SELECT * FROM album2;
SELECT * FROM artist;

SELECT customer.customer_id, customer.first_name, artist.name,
SUM(invoice_line.unit_price * invoice_line.quantity) AS totalamt_spend
FROM customer
JOIN invoice ON invoice.customer_id = customer.customer_id
JOIN invoice_line ON invoice_line.invoice_id = invoice.invoice_id
JOIN track ON track.track_id = invoice_line.track_id
JOIN album2 ON album2.album_id = track.album_id
JOIN artist ON artist.artist_id = album2.artist_id
GROUP BY customer.customer_id, customer.first_name, artist.name
ORDER BY totalamt_spend DESC;



