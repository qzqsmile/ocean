package net

import (
	"encoding/binary"
	"fmt"
	"net"
	"time"
)

func connect(network, addr string) error {
	conn, err := net.DialTimeout(network, addr, time.Second*3)
	if err != nil {
		return err
	}

	for i := 0; i < 10; i++ {
		_, err = conn.Write([]byte("hello"))
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
	return nil
}

type Client struct {
	network string
	addr    string
}

func (c *Client) Send(data string) (string, error) {
	conn, err := net.DialTimeout(c.network, c.addr, time.Second*3)
	if err != nil {
		return "", err
	}
	defer func() {
		_ = conn.Close()
	}()
	//for i := 0; i < 10; i++ {
	respLen := len(data)
	req := make([]byte, respLen+numofLengthByte)
	binary.BigEndian.PutUint64(req[:numofLengthByte], uint64(respLen))
	copy(req[numofLengthByte:], data)

	_, err = conn.Write(req)
	if err != nil {
		return "", err
	}
	lenBs := make([]byte, numofLengthByte)
	_, err = conn.Read(lenBs)
	if err != nil {
		return "", err
	}

	length := binary.BigEndian.Uint64(lenBs)
	respBs := make([]byte, length)
	_, err = conn.Read(respBs)
	if err != nil {
		return "", err
	}
	//fmt.Println(res)
	//}
	return string(respBs), nil
}
