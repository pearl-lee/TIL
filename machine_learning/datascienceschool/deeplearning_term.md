## epoch, batch size, iteration
#### epoch
- 인공신경망에서 전체 데이터셋에 대해 forward/backward pass(역전파 알고리즘) 과정을 거친 것
- 전체 데이터셋에 대해 한 번 학습을 완료한 상태
- 적절한 epoch 값을 설정해야만 underfitting, overfitting의 문제가 생기지 않는다
	- epoch값이 너무 작은 경우 : underfitting 가능성
	- epoch값이 너무 큰 경우 : overfitting 가능성

#### batch sisze
- 한 번의 batch마다 주는 데이터의 샘플 사이즈
- batch(mini-batch) : 나눠진 데이터셋

#### iteration
- epoch를 나눠서 실행하는 횟수

---
메모리의 한계와 속도 저하 때문에 대부분의 경우에 한번의 epoch에서 모든 데이터를 한번에 집어넣을 수 없다. 그래서 데이터를 나눠주는데, 
- 이때 몇 번 나눠주는가 : iteration
- 각 iteration마다 주는 데이터 사이즈 : batch size

```
전체 데이터 수 = batch size X iteration
```
