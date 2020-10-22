package entity

import (
	"database/sql/driver"
	"fmt"
	"time"
)

const (
	timeFormart = "2006-01-02 15:04:05"
)

// Action CRUD actions
type Action int32

var (
	// Create action when record is created
	Create = Action(0)

	// Retrieve action when record is retrieved from db
	Retrieve = Action(1)

	// Update action when record is updated in db
	Update = Action(2)

	// Delete action when record is deleted in db
	Delete = Action(3)
)

// Model interface methods for database structs generated
type Model interface {
	TableName() string
	BeforeSave() error
	Prepare()
	Validate(action Action) error
}

type Time struct {
	time.Time
}

func Now() *Time {
	return &Time{time.Now()}
}

func (t *Time) MarshalJSON() ([]byte, error) {
	b := make([]byte, 0, len(timeFormart)+2)
	b = append(b, '"')
	b = t.AppendFormat(b, timeFormart)
	b = append(b, '"')
	return b, nil
}

func (t *Time) UnmarshalJSON(data []byte) (err error) {
	now, err := time.ParseInLocation(`"`+timeFormart+`"`, string(data), time.Local)
	t.Time = now
	return
}

// Value insert timestamp into mysql need this function.
func (t Time) Value() (driver.Value, error) {
	var zeroTime time.Time
	if t.Time.UnixNano() == zeroTime.UnixNano() {
		return nil, nil
	}
	return t.Time, nil
}

// Scan valueof time.Time
func (t *Time) Scan(v interface{}) error {
	value, ok := v.(time.Time)
	if ok {
		*t = Time{Time: value}
		return nil
	}
	return fmt.Errorf("can not convert %v to timestamp", v)
}
