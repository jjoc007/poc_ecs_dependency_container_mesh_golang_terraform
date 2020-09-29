package main

import (
	"encoding/json"
	"net/http"
)

type PayLoad struct {
	Name string `json:"name"`
	LastName string `json:"last_name"`
}

type HttpHandler struct{}

func (h HttpHandler) ServeHTTP(res http.ResponseWriter, req *http.Request) {

	res.Header().Set("Content-Type", "application/json")

	payload := PayLoad{
		Name:     "Jhon",
		LastName: "Doe",
	}

	// write `data` to response
	json.NewEncoder(res).Encode(payload)
}

func main()  {
	// create a new handler
	handler := HttpHandler{}
	// listen and serve
	http.ListenAndServe(":9000", handler)
}
