package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
)

type PayLoad struct {
	Name string `json:"name"`
	LastName string `json:"last_name"`
	Delay int `json:"delay"`
}

type PayLoadResponse struct {
	NameMod string `json:"name_mod"`
	LastNameMod string `json:"last_name_mod"`
	DelayFinal int `json:"delay_final"`
}

type HttpHandler struct{}

func (h HttpHandler) ServeHTTP(res http.ResponseWriter, req *http.Request) {
	fmt.Println("Perform GET request to Main service")
	resp, err := http.Get("http://api:9000/")
	if err != nil {
		log.Fatalln(err)
	}

	defer resp.Body.Close()
	bodyBytes, _ := ioutil.ReadAll(resp.Body)

	// Convert response body to Todo struct
	var payloadAPI PayLoad
	json.Unmarshal(bodyBytes, &payloadAPI)
	fmt.Printf("API Response as struct %+v\n", payloadAPI)

	res.Header().Set("Content-Type", "application/json")

	payloadResponse := PayLoadResponse{
		NameMod:     payloadAPI.Name,
		LastNameMod: payloadAPI.LastName,
		DelayFinal:  payloadAPI.Delay,
	}
	// write `data` to response
	json.NewEncoder(res).Encode(payloadResponse)
}


func main()  {
	handler := HttpHandler{}
	http.ListenAndServe(":8080", handler)
}
