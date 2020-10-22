package redis

import (
	"context"
	"daigou/library/zaplog"
	"fmt"
	"strconv"

	jsoniter "github.com/json-iterator/go"
)

type SessionMap struct {
	UserID    uint32 `json:"user_id"`
	SessionID string `json:"session_id"`
}

//更新user_id到session_id的映射信息
func UpdateSessionMap(_args *SessionMap) (val int64, err error) {
	conn := cache.Conn(context.Background())
	defer conn.Close()

	//序列化
	info, err := jsoniter.MarshalToString(_args)
	if err != nil {
		zaplog.Errorf("UpdateSessionMap err=%s", err)
		return
	}
	//写入到redis
	res := conn.HSet(context.Background(), Cache_Hash_Session, _args.UserID, info)
	if err = res.Err(); err != nil {
		zaplog.Errorf("UpdateSessionMap err=%s", err)
		return
	}

	return res.Result()
}

//通过UserID获取sessionID
func GetSessionID(_arg uint32) (res SessionMap, err error) {
	conn := cache.Conn(context.Background())
	defer conn.Close()

	//从redis读取
	v1, err := conn.HGet(context.Background(), Cache_Hash_Session, strconv.Itoa(int(_arg))).Result()
	if err != nil {
		zaplog.Errorf("GetSessionID err:%s", err)
		return
	}

	if v1 == "" {
		err = fmt.Errorf("用户未登录")
		return
	}
	err = jsoniter.Unmarshal([]byte(v1), &res)
	if err != nil {
		zaplog.Errorf("RedisSendSmsCode err=%s", err)
		return
	}
	return
}

// 删除用户session
func DelSession(_arg uint32) (val int64, err error) {
	conn := cache.Conn(context.Background())
	defer conn.Close()

	return conn.HDel(context.Background(), Cache_Hash_Session, strconv.Itoa(int(_arg))).Result()
}
