package zaplog

import (
	"go.uber.org/zap"
)

var (
	log  *zap.SugaredLogger //printf风格
	tlog *zap.Logger        //structured 风格
)

type Config struct {
	Logdir   string `json:"Logdir"`
	LogName  string `json:"LogName"`
	Loglevel string `json:"Loglevel"`
	Debug    bool   `json:"Debug"`
}

//增加init,防止go test时日志报错
func init() {
	tlog = NewLogger(&Config{Debug: true, Loglevel: "debug"}, 1).Logger
	log = tlog.Sugar()
}

func InitLog(conf *Config) {
	tlog = NewLogger(conf, 1).Logger
	log = tlog.Sugar()
}

//fmt.Sprint to construct and log a message
func Debug(args ...interface{}) {
	log.Debug(args...)
}

func Info(args ...interface{}) {
	log.Info(args...)
}

func Warn(args ...interface{}) {
	log.Warn(args...)
}

func Error(args ...interface{}) {
	log.Error(args...)
}

func DPanic(args ...interface{}) {
	log.DPanic(args...)
}

func Panic(args ...interface{}) {
	log.Panic(args...)
}

func Fatal(args ...interface{}) {
	log.Fatal(args...)
}

//fmt.Sprintf to log a templated message
func Debugf(template string, args ...interface{}) {
	log.Debugf(template, args...)
}

func Infof(template string, args ...interface{}) {
	log.Infof(template, args...)
}

func Warnf(template string, args ...interface{}) {
	log.Warnf(template, args...)
}

func Errorf(template string, args ...interface{}) {
	log.Errorf(template, args...)
}

func DPanicf(template string, args ...interface{}) {
	log.DPanicf(template, args...)
}

func Panicf(template string, args ...interface{}) {
	log.Panicf(template, args...)
}

func Fatalf(template string, args ...interface{}) {
	log.Fatalf(template, args...)
}

//key value形式打印
func Debugw(msg string, keysAndValues ...interface{}) {
	log.Debugw(msg, keysAndValues...)
}

func Infow(msg string, keysAndValues ...interface{}) {
	log.Infow(msg, keysAndValues...)
}

func Warnw(msg string, keysAndValues ...interface{}) {
	log.Warnw(msg, keysAndValues...)
}

func Errorw(msg string, keysAndValues ...interface{}) {
	log.Errorw(msg, keysAndValues...)
}

func DPanicw(msg string, keysAndValues ...interface{}) {
	log.DPanicw(msg, keysAndValues...)
}

func Panicw(msg string, keysAndValues ...interface{}) {
	log.Panicw(msg, keysAndValues...)
}

func Fatalw(msg string, keysAndValues ...interface{}) {
	log.Fatalw(msg, keysAndValues...)
}

//structured 风格打印
func TDebug(msg string, fields ...zap.Field) {
	tlog.Debug(msg, fields...)
}

func TInfo(msg string, fields ...zap.Field) {
	tlog.Info(msg, fields...)
}

func TWarn(msg string, fields ...zap.Field) {
	tlog.Warn(msg, fields...)
}

func TError(msg string, fields ...zap.Field) {
	tlog.Error(msg, fields...)
}

func TDPanic(msg string, fields ...zap.Field) {
	tlog.DPanic(msg, fields...)
}

func TPanic(msg string, fields ...zap.Field) {
	tlog.Panic(msg, fields...)
}

func TFatal(msg string, fields ...zap.Field) {
	tlog.Fatal(msg, fields...)
}
