package main

import (
	"net/http"

	"github.com/julienschmidt/httprouter"
)

func main() {
	r := httprouter.New()
	gsc := NewGameServerController()

	r.GET("/gameserver", gsc.GetGameServers)
	r.GET("/gameserver/:id", gsc.GetGameServer)

	http.ListenAndServe(":10001", r)
}
