import turtle
import time

tt = turtle.Turtle()
tt.shape('turtle') # 화살표를 거북이 모양으로 바꾸기
tt.color('green')
tt.pensize(5)

tt.forward(100) # 기본값인 오른쪽으로 100만큼 이동
tt.left(90) # 왼쪽으로 꺾기
tt.forward(100)
tt.left(90)
tt.forward(100)
tt.left(90)
tt.forward(100)

time.sleep(5)