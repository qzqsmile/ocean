package web

import "net/http"

type HTTPServer struct {
}

func (h *HTTPServer) ServeHTTP(writer http.ResponseWriter, request *http.Request) {
	panic("implement me")
}

func (h *HTTPServer) Start(addr string) error {
	panic("implement me")
}
