- mongodb에 데이터를 집어 넣으려고 하는데,
- OperationFailure: not authorized on dbs to execute command
- 오류가 발생. 해결 방법을 찾아보다가 아주 간단히 해결이 됐다..

```python
Import pymongo

server = pymongo.MongoClient(f"mongodb://{username}:{password}@{pubilc_ip}“, port) 
db = server.dbs
collection = db.recruit
collection.insert(datas)
```

- MongoClient에 "mongodb://username:password@public-ip:port"
- username, password를 넣어야 한다는 것... 
