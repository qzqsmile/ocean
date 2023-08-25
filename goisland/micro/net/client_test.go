package net

import (
	"fmt"
	"net"
	"time"
)

func Connect(network, addr string) error {
	conn, err := net.DialTimeout(network, addr, time.Second*3)
	if err != nil {
		return err
	}

	defer func() {
		_ = conn.Close()
	}()

	for {
		_, err := conn.Write([]byte("hello"))
		if err != nil {
			return err
		}

		res := make([]byte, 128)
		_, err = conn.Read(res)
		if err != nil {
			return err
		}
		fmt.Println(res)
	}
}
