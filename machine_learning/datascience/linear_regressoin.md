### 최소자승법
- 데이터 전체에서 발생하는 총 오륫값을 알고 싶은 것.
- sum of sqerrors를 최소화해주는 계수를 찾는 것
- x의 열은 서로 선형독립해야 함
- x의 모든 열은 오류와 아부런 상관관계가 없다

### 결정계수(R-squared)
- 모델의 적합성 척도
- 종속 변수의 총 변화량 중 모델이 잡아낼 수 있는 변화량의 비율
- 새로운 변수를 추가하면 높아진다.

### 경사 하강법
- 최적의 계수를 찾는 방법
- 실제로 이 방법으로 선형회귀모델을 추정하지 않고, 선형대수 기법을 사용함

### 최대가능도 추정법
- 관측된 데이터가 발생할 경우를 가장 높게 만들어 주는 값
- 전체 데이터에 대한 가능도는 각 데이터의 가능도를 모두 곱한 값
- 오류의 제곱값을 최소화하는 알파와 베타가 계산되는 지점이 가능도가 최대화 되는 지점

### 적합성 평가
- 새로운 변수를 추가하면 결정계수는 필연적으로 높아짐.
- 최적의 다중 회귀 분석 모델은 언제나 단순 회귀 분석 모델보다 같거나 작은 오류값을 가진다
- 그러므로 각 계수의 표준오차를 살펴 봐야한다 : 추정된 계수가 얼마나 확실한지
- 오차 측정 방법 : 오류는 독립이며, 평균은 0이고 표준편차는 sigma인 정규분포의 확률변수라는 가정으로 시작함
	- 부트스트랩을 적용하여 생성한 표본으로부터 계수 추정, 계수가 크게 변하지 않는다면 추정된 계수가 꽤 정확

### 정규화
- 학습데이터에 대한 과적합을 막고 모델의 일반화 성능을 높이기 위한 모든 행위를 통칭. 규칙화, 규제화
- Lidge Regression : 계수의 값을 전체적으로 줄여줌, 경사하강법으로 학습 가능
- Lasso Regression : 계수의 값을 0으로 강제하는 효과가 있음, 경사하강법으로 학습 불가능

[ref] O'Reilly, 밑바닥부터 시작하는 데이터 과학