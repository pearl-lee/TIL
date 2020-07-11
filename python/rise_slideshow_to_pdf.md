1. 슬라이드 생성 후 터미널에 명령어 입력

    `jupyter nbconvert --to slides [파일제목].ipynb --post serve`

2. 웹페이지가 열린다

    `http://127.0.0.1:8000/[파일제목].slides.html#/`

3. 웹페이지의 url을 조금 수정(**#/** 를 지우고, **?print-pdf** 입력)

    `http://127.0.0.1:8000/[파일제목].slides.html?print-pdf`
    

4. pdf 파일로 저장하기

    `cmd + p`

[출처]https://rise.readthedocs.io/en/stable/exportpdf.html
