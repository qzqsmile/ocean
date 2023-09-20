package net

import (
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
	"testing"
	"time"
)

//func TestConnect(t *testing.T) {
//	go func() {
//		err := Serve("tcp", ":8082")
//		t.Log(err)
//	}()
//	time.Sleep(time.Second * 3)
//	err := connect("tcp", "localhost:8082")
//	t.Log(err)
//}

func TestClient_Send(t *testing.T) {
	//server := NewServer("http", "localhost")
	server := &Server{}
	go func() {
		err := server.Start("tcp", "localhost:8081")
		t.Log(err)
	}()
	time.Sleep(time.Second * 3)
	client := &Client{
		network: "tcp",
		addr:    "localhost:8081",
	}
	resp, err := client.Send("hello")
	require.NoError(t, err)
	assert.Equal(t, "hellohello", resp)
}
