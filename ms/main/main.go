package main

import (
	"encoding/json"
	"github.com/valyala/fasthttp"
	"log"
	"math/rand"
	"time"
)

// request handler in net/http style, i.e. method bound to MyHandler struct.
func requestHandler(ctx *fasthttp.RequestCtx) {
	ctx.SetContentType("application/json")

	delay := rand.Intn(10)
	time.Sleep(time.Duration(delay) * time.Second)

	payload := PayLoad{
		Name:     "Jhon",
		LastName: "Doe",
		Delay: delay,
	}

	json.NewEncoder(ctx.Response.BodyWriter()).Encode(payload)
}

type PayLoad struct {
	Name string `json:"name"`
	LastName string `json:"last_name"`
	Delay int `json:"delay"`
}

func main()  {
	h := requestHandler
	if err := fasthttp.ListenAndServe(":9000", h); err != nil {
		log.Fatalf("Error in ListenAndServe: %s", err)
	}
}
