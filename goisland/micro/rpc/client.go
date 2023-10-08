package rpc

import (
	"errors"
	"reflect"
)

func InitClientProxy(service any) error {
	if service == nil {
		return errors.New("rpc:不支持 nil")
	}
	val := reflect.ValueOf(service)
	typ := val.Type()
	//只支持指向接头体的一级指针
	if typ.Kind() != reflect.Pointer || typ.Elem().Kind() != reflect.Struct {
		return errors.New("rpc:只支持指向结构体的一级指针")
	}
	return nil
}
