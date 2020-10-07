package main

import (
	"encoding/json"
	"fmt"
	"log"
	"math/rand"
	"net/http"
	"time"
)

type HttpHandler struct{}

func (h HttpHandler) ServeHTTP(res http.ResponseWriter, req *http.Request) {
	fmt.Println("Perform GET request to Main service")

	res.Header().Set("Content-Type", "application/json")
	delay := rand.Intn(11)
	time.Sleep(time.Duration(delay) * time.Second)
	payload := PayLoad{
		Name:     "Jhon",
		LastName: "Doe",
		Delay: delay,
	}
	json.NewEncoder(res).Encode(payload)
}

func (h HttpHandler) ServeHTTP2(res http.ResponseWriter, req *http.Request) {
	fmt.Println("Perform GET request to Main service")

	res.Header().Set("Content-Type", "application/json")
	payload := PayLoad{
		Name:     "Jhon",
		LastName: "Doe",
		Delay: 0,
	}
	json.NewEncoder(res).Encode(payload)
}

type PayLoad struct {
	Name string `json:"name"`
	LastName string `json:"last_name"`
	Delay int `json:"delay"`
}

func main()  {
	handler := HttpHandler{}

	http.HandleFunc("/service", handler.ServeHTTP)
	http.HandleFunc("/health", handler.ServeHTTP2)

	log.Fatal(http.ListenAndServe(":9000", nil))

}
