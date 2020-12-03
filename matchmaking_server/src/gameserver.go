package main

import (
	"encoding/json"
	"fmt"
	"net/http"

	"github.com/julienschmidt/httprouter"
)

type GameServer struct {
	Id              string
	Name            string
	Type            string
	MaxPlayerCount  int
	CurrPlayerCount int
}

type GameServerList struct {
	Pages       int
	Page        int
	GameServers []GameServer
}

type GameServerController struct{}

func NewGameServerController() *GameServerController {
	return &GameServerController{}
}

func (gsc GameServerController) GetGameServer(w http.ResponseWriter, r *http.Request, p httprouter.Params) {
	gs := GameServer{
		Id:              "jh1hj45g23jk452k3h",
		Name:            "MyServer",
		Type:            "Deathmatch",
		MaxPlayerCount:  4,
		CurrPlayerCount: 2,
	}
	gsj, _ := json.Marshal(gs)

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(200)
	fmt.Fprintf(w, "%s", gsj)
}

func (gsc GameServerController) GetGameServers(w http.ResponseWriter, r *http.Request, p httprouter.Params) {
	gss := GameServerList{
		Pages: 1,
		Page:  0,
		GameServers: []GameServer{
			GameServer{
				Id:              "jh1hj45g23jk452k3h",
				Name:            "MyServer",
				Type:            "Deathmatch",
				MaxPlayerCount:  4,
				CurrPlayerCount: 2,
			},
		},
	}
	gssj, _ := json.Marshal(gss)

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(200)
	fmt.Fprintf(w, "%s", gssj)
}
