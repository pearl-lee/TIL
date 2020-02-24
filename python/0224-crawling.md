### Web crawling 
1. requests : json : 동적페이지
- 1. 웹서비스 분석: URL 분석
- 2. requests, response : json 얻기
	- response = requests.get(url)
- 3. 문자열 json 데이터를 dict로 변경(파싱), 데이터 프레임 생성
	- datas = response.json()['필요한 데이터']
	- df = pd.DataFrame(datas)
2. requests : html : 정적페이지
- 1. 웹페이지 분석 : URL 분석
- 2. request -> response : html
	- resonse = requests.get(url))
- 3. html(str) -> BeautifulSoup obj(css-selector) -> DF
	- dom = BeautifulSoup(response['열'], 'html.parser')
3. selenium : web browser

- 정규화: z = (x - min(x)/(max(x) - min(x))
- sk.preprocessing.minmax_scale(data)
