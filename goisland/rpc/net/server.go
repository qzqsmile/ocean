package net

import (
	"encoding/binary"
	"net"
)

const numofLengthByte = 8

//func Serve(network, addr string) error {
//	listener, err := net.Listen(network, addr)
//	if err != nil {
//		return err
//	}
//
//	for {
//		conn, err := listener.Accept()
//		if err != nil {
//			return err
//		}
//		go func() {
//			if err := handleConn(conn); err != nil {
//				conn.Close()
//			}
//		}()
//	}
//}
//
//func handleConn(conn net.Conn) error {
//	//panic("implement me")
//	for {
//		bs := make([]byte, 8)
//		n, err := conn.Read(bs)
//		if err != nil {
//			return err
//		}
//		if n != 8 {
//			return errors.New("micro:没读够数据")
//		}
//
//		res := handleMsg(bs)
//		n, err = conn.Write(res)
//		if err != nil {
//			return err
//		}
//		if n != len(res) {
//			return errors.New("micro:没写完数据")
//		}
//	}
//}

func handleMsg(req []byte) []byte {
	res := make([]byte, 2*len(req))
	copy(res[:len(req)], req)
	copy(res[len(req):], req)
	return res
}

type Server struct {
	network string
	addr    string
}

func NewServer(network, addr string) *Server {
	return &Server{
		network: network,
		addr:    addr,
	}
}

func (s *Server) Start(network, addr string) error {
	listener, err := net.Listen(network, addr)
	if err != nil {
		return err
	}

	for {
		conn, err := listener.Accept()
		if err != nil {
			return err
		}
		go func() {
			if err := handleConn(conn); err != nil {
				conn.Close()
			}
		}()
	}
}

func handleConn(conn net.Conn) error {
	//panic("implement me")
	for {
		lenBs := make([]byte, 8)
		_, err := conn.Read(lenBs)
		if err != nil {
			return err
		}
		//if n != 8 {
		//	return errors.New("micro:没读够数据")
		//}
		length := binary.BigEndian.Uint64(lenBs)
		reqBs := make([]byte, length)
		_, err = conn.Read(reqBs)
		if err != nil {
			return err
		}

		respData := handleMsg(reqBs)
		respLen := len(respData)
		res := make([]byte, respLen+8)

		//step1 write length into first 8 bytes
		binary.BigEndian.PutUint64(res[:8], uint64(respLen))
		copy(res[numofLengthByte:], respData)

		_, err = conn.Write(res)
		if err != nil {
			return err
		}
	}
}
