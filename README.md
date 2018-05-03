## Build an API demo

HTTP GET http://10.100.25.23:3000/api/v1/users/1 

```
{
"user": {
	"id": 1,
	"email": "test1@cscs.com",
	"name": "mark",
	"activated": "2018-05-03T08:03:49.895Z",
	"admin": false,
	"created_at": "2018-05-03T08:03:49.902Z",
	"updated_at": "2018-05-03T09:38:35.036Z"
	}
}
```

HTTP POST http://10.100.25.23:3000/api/v1/sessions

header
content-type: application/x-www-form-urlencoded

body
user[email]=test1@cscs.com&user[password]=1234

```
{
"session": {
	"id": 1,
	"name": "mark",
	"admin": false,
	"token": "95LzmhGr1Mg0dUep5wug5KIaJXG8wi2WHYh+LifHlj2Ie3PSr8lowPTpQ7hkC718219rZ9U/EA3aRTOaRGOBPA=="
	}
}
```

HTTP PUT http://10.100.25.23:3000/api/v1/users/1

header
content-type: application/x-www-form-urlencoded
authorization: Token token=`<token_string>`,email=test1@cscs.com

body
user[name]=mark

```
{
"user": {
	"id": 1,
	"name": "mark"
	}
}
``` 


HTTP GET http://10.100.25.23:3000/api/v1/user/1/microposts?page=3

```
{
	"paginate_meta": {
		"current_page": 3,
		"next_page": 4,
		"prev_page": 2,
		"total_pages": 4,
		"total_count": 100
		},
	"microposts": [
		{
			"id": 51,
			"title": "title-50",
			"content": "content-50"
		},
		{
			"id": 52,
			"title": "title-51",
			"content": "content-51"
		},
		{
			"id": 53,
			"title": "title-52",
			"content": "content-52"
		},

...
}
'''
        	                                                                            
HTTP GET http://10.100.25.23:3000/api/v1/user/1/microposts?per_page=4 (each page size is 4)
