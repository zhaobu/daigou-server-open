gen --sqltype=mysql \
	--connstr="daigou:daigou123@tcp(127.0.0.1:3306)/daigou_online" \
	--database=daigou  \
	--json \
	--json-fmt=snake \
	--gorm \
	--model=entity \
	--out=./app/model \
	--overwrite \
	--guregu \
	--verbose \
	--templateDir=./template \
	--mapping=./template/mapping.json \
	--verbose \
	--model_naming="{{FmtFieldName .}}" \
	--field_naming="{{FmtFieldName (stringifyFirstChar .) }}" \
	--file_naming="{{.}}" \
	# --save=./template
	# --name_test=orders_goods \