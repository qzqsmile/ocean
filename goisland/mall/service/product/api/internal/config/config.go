package config

import (
	"github.com/zeromicro/go-zero/rest"
	"github.com/zeromicro/go-zero/zrpc"
)

type Config struct {
	//zrpc.RpcServerConf
	//
	//Mysql struct {
	//	DataSource string
	//}
	//
	//CacheRedis cache.CacheConf
	rest.RestConf

	Auth struct {
		AccessSecret string
		AccessExpire int64
	}
	ProductRpc zrpc.RpcClientConf
}
