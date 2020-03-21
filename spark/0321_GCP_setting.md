### VM(Vertual Machine) 만들기 
- 머신, 인스턴스, VM
- CPU, RAM, HDD, OS 설정

- Data Node (Worker, Slave)
	- 불안정하더라도 저렴한 장비를 묶어서 사용
	- 저장할 파일(5G)을 128MB씩 나눠서(block) 분산 저장(알아서 저장됨) -> 읽을 때 알아서 합쳐서 가져옴
	- 3개의 copy를 만들어 머신 하나가 죽어도 작동되도록? 설정 (15G가 필요)
	- 4개의 VM을 만들 예정.

- Name Node (Master)
	- 데이터 저장 정보를 기록하는 장부 필요 
	- 장부만 관리하는 VM이 따로 필요
	- 얘가 날아가면 데이터를 하나도 못씀

- 내부 IP 
	- 보안상 사용하는 내부의 IP. GCP에서 만 사용
- 외부 IP 
	- 외부에서 서버에 접근할 때 사용하는 IP
	- 서버를 껐다가 켜면 reset되는데 고정해서 사용할 수 있음
	- 접속할 떄마다 내 컴퓨터에 hosts 파일을 수정해야한다  

- DNS (domain name service) : 웹페이지의 URL을 IP로 바꿔주는 서비스
- etc/hosts : dns와 비슷한 역할을 하는 파일
	- ip와 프로젝트id를 연결해주는 파일?


### Hadoop 
- HDFS(저장소)
	- Fully distributed (완전분산모드)로 4대를 설치
	- 하둡사용하려면 이거만 필요.?
- MR(연산, Map Reduce) 
	-  거의 안씀, 데이터엔지니어의 역할 -> spark로 대체
- YARN(리소스 관리)
	- 리소스: CPU Memory ; 리소스를 어플리케이션에 할당

### Spark (MR과 비슷)

### 해킹주의
- 해킹당할 위험이 있음 
- Default port를 사용하지 않고 port를 설정해서 바꿀 예정