# README

These are the endpoints that'll be consumed by the frontend, 

api = http://127.0.0.1:3000

Use the endpoints in frontend as mentioned below, I'll add the value of api later

****### User Authentication| Method | URL | Purpose || :--- | :--- | :--- 

|| `POST` | `api/register` | Create a new user account. 
|| `POST` | `api/login` | Log in a user and get a JWT. 
|| `DELETE`| `api/logout` | Log out a user and invalidate their JWT. 

|***### Categories| Method | URL | Purpose || :--- | :--- | :--- 

|| `GET` | `api/categories` | Get a list of all categories.


|***### Events| Method | URL | Purpose || :--- | :--- | :--- 

|| `GET` | `api/events` | Get a list of all events.
|| `GET` | `api/events?query=:category` | Get a list of all events that match the given category.
|| `GET` | `api/events/:id` | Get details for a single event. 
|| `POST` | `api/events` | Create a new event (requires auth). 
|| `PATCH`/`PUT`| `api/events/:id` | Update an event you created (requires auth).
|| `DELETE`| `api/events/:id` | Delete an event you created (requires auth). 

|***### Event Participants| Method | URL | Purpose || :--- | :--- | :--- 

|| `GET` | `api/events/:event_id/participants` | Get a list of all participants for a specific event. 
|| `POST` | `api/events/:event_id/participants` | Join an event (requires auth). 
|| `DELETE`| `api/participants/:id` | Leave an event (requires auth). 

|***### Admin PanelAll these routes require an admin to be authenticated via the admin login 
`POST /admins/sign_in`, and logout via `DELETE /admins/sign_out` .| Method | URL | Purpose || :--- | :--- | :--- 

|| `GET` | `api/admin/dashboard` | View admin dashboard stats. 
|| `GET` | `api/admin/events` | View all events as an admin. 
|| `DELETE`| `api/admin/events/:id` | Delete any event as an admin. 
|| `GET` | `api/admin/categories`| View all categories as an admin. 
|| `POST` | `api/admin/categories`| Create a new category as an admin. |
||`DELETE` | `api/admin/participants/:id`| Remove a participant from an event
||`GET` | `api/admin/events/:id/participants`| Get participants for a specific event as admin