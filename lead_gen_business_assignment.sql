##LEAD GEN BUSINESS


## 1. What query would you run to get the total revenue for March of 2012?

SELECT *
FROM billing;

SELECT MONTHNAME(charged_datetime) as month, SUM(amount) as total_revenue
FROM billing
WHERE YEAR(charged_datetime) = 2012 AND MONTH(charged_datetime) = 3;

## 2. What query would you run to get total revenue collected from the client with an id of 2?

SELECT client_id, SUM(amount) as total_revenue
FROM billing
WHERE client_id = 2;

## 3. What query would you run to get all the sites that client=10 owns?

SELECT client_id, domain_name as website
FROM sites
WHERE client_id = 10;

## 4. What query would you run to get total # of sites created per month per year for the client with an id of 1? What about for client=20?

SELECT client_id, count(domain_name) as number_websites, MONTHNAME(created_datetime) as month_created, YEAR(created_datetime) as year_created
FROM sites
WHERE client_id = 1
GROUP BY year_created, month_created;

SELECT client_id, count(domain_name) as number_websites, MONTHNAME(created_datetime) as month_created, YEAR(created_datetime) as year_created
FROM sites
WHERE client_id = 20
GROUP BY year_created, month_created;

## 5. What query would you run to get the total # of leads generated for each of the sites between January 1, 2011 to February 15, 2011?

SELECT sites.domain_name AS website, COUNT(leads.leads_id) AS number_of_leads, DATE_FORMAT(leads.registered_datetime, '%M %d, %Y') AS date_generated
FROM sites
JOIN leads ON sites.site_id = leads.site_id
WHERE DATE(leads.registered_datetime) BETWEEN '2011-01-01' AND '2011-02-15' 
GROUP BY website;

## 6. What query would you run to get a list of client names and the total # of leads we've generated for each of our clients between January 1, 2011 to December 31, 2011?

SELECT CONCAT(clients.first_name, ' ', clients.last_name) AS client_name, COUNT(leads.leads_id) AS number_of_leads
FROM clients
JOIN sites ON clients.client_id = sites.client_id
JOIN leads ON sites.site_id = leads.site_id
WHERE DATE(leads.registered_datetime) BETWEEN '2011-01-01' AND '2011-12-31'
GROUP BY client_name;

## 7. What query would you run to get a list of client names and the total # of leads we've generated for each client each month between months 1 - 6 of Year 2011?

SELECT CONCAT(clients.first_name, ' ', clients.last_name) AS client_name, COUNT(leads.leads_id) AS number_of_leads, leads.registered_datetime
FROM clients
JOIN sites ON clients.client_id = sites.client_id
JOIN leads ON sites.site_id = leads.site_id
WHERE YEAR(leads.registered_datetime) = '2011' AND MONTH(leads.registered_datetime) BETWEEN 1 AND 6
GROUP BY leads.leads_id;

## 8. What query would you run to get a list of client names and the total # of leads we've generated for each of our clients' sites between January 1, 2011 to December 31, 2011? Order this query by client id.  Come up with a second query that shows all the clients, the site name(s), and the total number of leads generated from each site for all time.


SELECT CONCAT(clients.first_name, ' ', clients.last_name) AS client_name, sites.domain_name AS websites, COUNT(leads.leads_id) AS number_of_leads, DATE_FORMAT(leads.registered_datetime, '%M %d, %Y') AS date_generated
FROM clients
JOIN sites ON clients.client_id = sites.client_id
JOIN leads ON sites.site_id = leads.site_id
WHERE DATE(leads.registered_datetime) BETWEEN '2011-01-01' AND '2011-12-31'
GROUP BY sites.site_id;

SELECT CONCAT(clients.first_name, ' ', clients.last_name) AS client_name, sites.domain_name AS websites, COUNT(leads.leads_id) AS number_of_leads, sites.site_id, leads.leads_id, leads.first_name
FROM clients
LEFT JOIN sites ON clients.client_id = sites.client_id
LEFT JOIN leads ON sites.site_id = leads.site_id
GROUP BY websites, client_name;

## 9. Write a single query that retrieves total revenue collected from each client for each month of the year. Order it by client id.

SELECT CONCAT(first_name, ' ', last_name) AS client_name, SUM(billing.amount) AS total_revenue, MONTHNAME(billing.charged_datetime), YEAR(billing.charged_datetime)
FROM clients
JOIN billing ON clients.client_id = billing.client_id
GROUP BY MONTH(billing.charged_datetime), YEAR(billing.charged_datetime), client_name;

## 10. Write a single query that retrieves all the sites that each client owns. Group the results so that each row shows a new client. It will become clearer when you add a new field called 'sites' that has all the sites that the client owns. (HINT: use GROUP_CONCAT

SELECT CONCAT(clients.first_name, ' ', clients.last_name) AS client_name , GROUP_CONCAT(sites.domain_name) as sites
FROM clients
LEFT JOIN sites ON clients.client_id = sites.client_id
GROUP BY clients.client_id