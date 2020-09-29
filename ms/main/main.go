package main

import (
	"encoding/json"
	"math/rand"
	"net/http"
	"time"
)

type PayLoad struct {
	Name string `json:"name"`
	LastName string `json:"last_name"`
	Delay int `json:"delay"`
}

type HttpHandler struct{}

func (h HttpHandler) ServeHTTP(res http.ResponseWriter, req *http.Request) {
	res.Header().Set("Content-Type", "application/json")

	delay := rand.Intn(10)
	time.Sleep(time.Duration(delay) * time.Second)

	payload := PayLoad{
		Name:     "Jhon",
		LastName: "Doe",
		Delay: delay,
	}
	// write `data` to response
	json.NewEncoder(res).Encode(payload)
}

func main()  {
	handler := HttpHandler{}
	http.ListenAndServe(":9000", handler)
}
